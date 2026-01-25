/// <reference path="./.sst/platform/config.d.ts" />

export default $config({
  app(input) {
    return {
      name: "tush-backend",
      removal: input?.stage === "production" ? "retain" : "remove",
      home: "aws",
    };
  },
  async run() {
    // 1. Create DynamoDB Table
    const table = new sst.aws.Dynamo("Dreams", {
      fields: {
        userId: "string",
        dreamId: "string",
      },
      primaryIndex: { hashKey: "userId", rangeKey: "dreamId" },
      stream: "new-and-old-images",
    });

    table.subscribe("InterpretDream", {
      handler: "src/features/dreams/interpret.handler",
      link: [table],
      environment: {
        GEMINI_API_KEY: process.env.GEMINI_API_KEY || "",
      },
    });

    // Friends DynamoDB Table
    const friendsTable = new sst.aws.Dynamo("Friends", {
      fields: {
        userId: "string",
        friendId: "string",
      },
      primaryIndex: { hashKey: "userId", rangeKey: "friendId" },
    });

    // Friend Requests DynamoDB Table (for pending requests)
    const friendRequestsTable = new sst.aws.Dynamo("FriendRequests", {
      fields: {
        recipientId: "string",
        senderId: "string",
      },
      primaryIndex: { hashKey: "recipientId", rangeKey: "senderId" },
    });

    // 2. Create Cognito User Pool
    const userPool = new sst.aws.CognitoUserPool("UserPool", {
      transform: {
        userPool: {
          autoVerifiedAttributes: ["email"],
          emailConfiguration: {
            emailSendingAccount: "COGNITO_DEFAULT",
          },
        },
      },
    });
    const client = userPool.addClient("Web", {
      transform: {
        client: {
          callbackUrls: ["myapp://callback"],
          logoutUrls: ["myapp://signout"],
        },
      },
    });

    // 5. Create API Gateway V2
    const api = new sst.aws.ApiGatewayV2("Api", {
      transform: {
        route: {
          handler: {
            link: [table],
          },
        },
      },
    });

    const authorizer = api.addAuthorizer({
      name: "userPoolAuthorizer",
      jwt: {
        issuer: $interpolate`https://${userPool.nodes.userPool.endpoint}`,
        audiences: [client.id],
      },
    });

    // 6. Add Routes
    api.route("POST /dreams", "src/features/dreams/create.handler", {
      auth: {
        jwt: {
          authorizer: authorizer.id,
        },
      },
    });

    api.route("GET /dreams", "src/features/dreams/list.handler", {
      auth: {
        jwt: {
          authorizer: authorizer.id,
        },
      },
    });

    api.route("PUT /dreams/{id}", "src/features/dreams/update.handler", {
      auth: {
        jwt: {
          authorizer: authorizer.id,
        },
      },
    });

    api.route("DELETE /dreams/{id}", "src/features/dreams/delete.handler", {
      auth: {
        jwt: {
          authorizer: authorizer.id,
        },
      },
    });

    // User Search Route
    const searchUsersHandler = new sst.aws.Function("SearchUsers", {
      handler: "src/features/users/search-users.handler",
      environment: {
        USER_POOL_ID: userPool.id,
      },
      permissions: [
        {
          actions: ["cognito-idp:ListUsers"],
          resources: [userPool.nodes.userPool.arn],
        },
      ],
    });

    api.route("GET /users/search", searchUsersHandler.arn, {
      auth: {
        jwt: {
          authorizer: authorizer.id,
        },
      },
    });

    // Friend Routes
    const addFriendHandler = new sst.aws.Function("AddFriend", {
      handler: "src/features/friends/add-friend.handler",
      link: [friendsTable, friendRequestsTable],
    });

    api.route("POST /friends", addFriendHandler.arn, {
      auth: {
        jwt: {
          authorizer: authorizer.id,
        },
      },
    });

    const listFriendsHandler = new sst.aws.Function("ListFriends", {
      handler: "src/features/friends/list-friends.handler",
      link: [friendsTable],
      environment: {
        USER_POOL_ID: userPool.id,
      },
      permissions: [
        {
          actions: ["cognito-idp:AdminGetUser", "cognito-idp:ListUsers"],
          resources: [userPool.nodes.userPool.arn],
        },
      ],
    });

    api.route("GET /friends", listFriendsHandler.arn, {
      auth: {
        jwt: {
          authorizer: authorizer.id,
        },
      },
    });

    const deleteFriendHandler = new sst.aws.Function("DeleteFriend", {
      handler: "src/features/friends/delete-friend.handler",
      link: [friendsTable],
    });

    api.route("DELETE /friends/{id}", deleteFriendHandler.arn, {
      auth: {
        jwt: {
          authorizer: authorizer.id,
        },
      },
    });

    const getFriendDreamsHandler = new sst.aws.Function("GetFriendDreams", {
      handler: "src/features/friends/get-friend-dreams.handler",
      link: [friendsTable, table],
    });

    api.route("GET /friends/{id}/dreams", getFriendDreamsHandler.arn, {
      auth: {
        jwt: {
          authorizer: authorizer.id,
        },
      },
    });

    // Friend Request Routes
    const listFriendRequestsHandler = new sst.aws.Function(
      "ListFriendRequests",
      {
        handler: "src/features/friends/list-friend-requests.handler",
        link: [friendRequestsTable],
        environment: {
          USER_POOL_ID: userPool.id,
        },
        permissions: [
          {
            actions: ["cognito-idp:AdminGetUser", "cognito-idp:ListUsers"],
            resources: [userPool.nodes.userPool.arn],
          },
        ],
      },
    );

    api.route("GET /friend-requests", listFriendRequestsHandler.arn, {
      auth: {
        jwt: {
          authorizer: authorizer.id,
        },
      },
    });

    const acceptFriendRequestHandler = new sst.aws.Function(
      "AcceptFriendRequest",
      {
        handler: "src/features/friends/accept-friend-request.handler",
        link: [friendRequestsTable, friendsTable],
      },
    );

    api.route(
      "POST /friend-requests/{id}/accept",
      acceptFriendRequestHandler.arn,
      {
        auth: {
          jwt: {
            authorizer: authorizer.id,
          },
        },
      },
    );

    const declineFriendRequestHandler = new sst.aws.Function(
      "DeclineFriendRequest",
      {
        handler: "src/features/friends/decline-friend-request.handler",
        link: [friendRequestsTable],
      },
    );

    api.route(
      "POST /friend-requests/{id}/decline",
      declineFriendRequestHandler.arn,
      {
        auth: {
          jwt: {
            authorizer: authorizer.id,
          },
        },
      },
    );

    // 7. Outputs
    return {
      ApiEndpoint: api.url,
      UserPoolId: userPool.id,
      UserPoolClientId: client.id,
    };
  },
});
