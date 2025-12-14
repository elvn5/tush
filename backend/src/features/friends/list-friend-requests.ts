import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, QueryCommand } from "@aws-sdk/lib-dynamodb";
import {
  CognitoIdentityProviderClient,
  AdminGetUserCommand,
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
    console.log("Listing friend requests for userId:", userId);

    // Get pending friend requests where current user is the recipient
    const result = await dynamoDb.send(
      new QueryCommand({
        TableName: Resource.FriendRequests.name,
        KeyConditionExpression: "recipientId = :recipientId",
        ExpressionAttributeValues: {
          ":recipientId": userId,
        },
      })
    );

    console.log("DynamoDB query result:", JSON.stringify(result.Items));

    const senderIds = (result.Items || []).map((item) => item.senderId);

    if (senderIds.length === 0) {
      return {
        statusCode: 200,
        body: JSON.stringify({ requests: [] }),
      };
    }

    // Get sender details from Cognito
    const requests = await Promise.all(
      senderIds.map(async (senderId: string) => {
        try {
          // Use ListUsersCommand with sub filter since Username might be email
          const { ListUsersCommand } = await import(
            "@aws-sdk/client-cognito-identity-provider"
          );
          const listResult = await cognitoClient.send(
            new ListUsersCommand({
              UserPoolId: userPoolId,
              Filter: `sub = "${senderId}"`,
              Limit: 1,
            })
          );

          const user = listResult.Users?.[0];
          if (!user) {
            console.log(`User not found for senderId: ${senderId}`);
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
            id: senderId,
            email,
            name,
          };
        } catch (error) {
          console.error(`Error fetching user ${senderId}:`, error);
          return null;
        }
      })
    );

    console.log("Requests:", JSON.stringify(requests));

    return {
      statusCode: 200,
      body: JSON.stringify({
        requests: requests.filter((r) => r !== null),
      }),
    };
  } catch (error) {
    console.error("Error listing friend requests:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Could not list friend requests" }),
    };
  }
};
