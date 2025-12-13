import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import {
  DynamoDBDocumentClient,
  DeleteCommand,
  PutCommand,
  GetCommand,
} from "@aws-sdk/lib-dynamodb";
import { Resource } from "sst";

const client = new DynamoDBClient({});
const dynamoDb = DynamoDBDocumentClient.from(client);

export const handler = async (event: any) => {
  const userId = event.requestContext?.authorizer?.jwt?.claims?.sub;

  if (!userId) {
    return {
      statusCode: 401,
      body: JSON.stringify({ error: "Unauthorized" }),
    };
  }

  const senderId = event.pathParameters?.id;
  if (!senderId) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: "Sender ID is required" }),
    };
  }

  try {
    // Verify the request exists
    const existingRequest = await dynamoDb.send(
      new GetCommand({
        TableName: Resource.FriendRequests.name,
        Key: { recipientId: userId, senderId },
      })
    );

    if (!existingRequest.Item) {
      return {
        statusCode: 404,
        body: JSON.stringify({ error: "Friend request not found" }),
      };
    }

    const now = Date.now();

    // Create bidirectional friendship
    await dynamoDb.send(
      new PutCommand({
        TableName: Resource.Friends.name,
        Item: { userId, friendId: senderId, createdAt: now },
      })
    );
    await dynamoDb.send(
      new PutCommand({
        TableName: Resource.Friends.name,
        Item: { userId: senderId, friendId: userId, createdAt: now },
      })
    );

    // Delete the friend request
    await dynamoDb.send(
      new DeleteCommand({
        TableName: Resource.FriendRequests.name,
        Key: { recipientId: userId, senderId },
      })
    );

    return {
      statusCode: 200,
      body: JSON.stringify({ message: "Friend request accepted" }),
    };
  } catch (error) {
    console.error("Error accepting friend request:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Could not accept friend request" }),
    };
  }
};
