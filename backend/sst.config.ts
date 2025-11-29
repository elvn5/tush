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

    table.subscribe({
      handler: "src/interpret.handler",
      link: [table],
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
    api.route("POST /dreams", "src/create.handler", {
      auth: {
        jwt: {
          authorizer: authorizer.id,
        },
      },
    });

    api.route("GET /dreams", "src/list.handler", {
      auth: {
        jwt: {
          authorizer: authorizer.id,
        },
      },
    });

    api.route("PUT /dreams/{id}", "src/update.handler", {
      auth: {
        jwt: {
          authorizer: authorizer.id,
        },
      },
    });

    api.route("DELETE /dreams/{id}", "src/delete.handler", {
      auth: {
        jwt: {
          authorizer: authorizer.id,
        },
      },
    });

    // 7. Outputs
    return {
      ApiEndpoint: api.url,
      UserPoolId: userPool.id,
      UserPoolClientId: client.id,
    };
  },
});
