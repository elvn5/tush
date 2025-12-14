import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, QueryCommand } from "@aws-sdk/lib-dynamodb";
import {
  CognitoIdentityProviderClient,
  AdminGetUserCommand,
  UserType,
  AttributeType,
} from "@aws-sdk/client-cognito-identity-provider";
import { Resource } from "sst";

const client = new DynamoDBClient({});
const dynamoDb = DynamoDBDocumentClient.from(client);
const cognitoClient = new CognitoIdentityProviderClient({});

export const handler = async (event: any) => {
  const userId = event.requestContext?.authorizer?.jwt?.claims?.sub;

  if (!userId) {
    return {
      statusCode: 401,
      body: JSON.stringify({ error: "Unauthorized" }),
    };
  }

  const userPoolId = process.env.USER_POOL_ID;
  if (!userPoolId) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Server configuration error" }),
    };
  }

  try {
    // Get friend IDs from DynamoDB
    const result = await dynamoDb.send(
      new QueryCommand({
        TableName: Resource.Friends.name,
        KeyConditionExpression: "userId = :userId",
        ExpressionAttributeValues: {
          ":userId": userId,
        },
      })
    );

    const friendIds = (result.Items || []).map((item) => item.friendId);

    if (friendIds.length === 0) {
      return {
        statusCode: 200,
        body: JSON.stringify({ friends: [] }),
      };
    }

    // Get friend details from Cognito
    const friends = await Promise.all(
      friendIds.map(async (friendId: string) => {
        try {
          // Use ListUsersCommand with sub filter since Username might be email
          const { ListUsersCommand } = await import(
            "@aws-sdk/client-cognito-identity-provider"
          );
          const listResult = await cognitoClient.send(
            new ListUsersCommand({
              UserPoolId: userPoolId,
              Filter: `sub = "${friendId}"`,
              Limit: 1,
            })
          );

          const user = listResult.Users?.[0];
          if (!user) {
            console.log(`User not found for friendId: ${friendId}`);
            return null;
          }

          const attributes: AttributeType[] = user.Attributes || [];
          const email = attributes.find((a) => a.Name === "email")?.Value || "";
          const givenName =
            attributes.find((a) => a.Name === "given_name")?.Value || "";
          const familyName =
            attributes.find((a) => a.Name === "family_name")?.Value || "";
          const name =
            givenName || familyName
              ? `${givenName} ${familyName}`.trim()
              : undefined;

          return {
            id: friendId,
            email,
            name,
          };
        } catch (error) {
          console.error(`Error fetching friend ${friendId}:`, error);
          return null;
        }
      })
    );

    return {
      statusCode: 200,
      body: JSON.stringify({
        friends: friends.filter((f) => f !== null),
      }),
    };
  } catch (error) {
    console.error("Error listing friends:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Could not list friends" }),
    };
  }
};
