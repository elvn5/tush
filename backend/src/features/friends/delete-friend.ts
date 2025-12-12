import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, DeleteCommand } from "@aws-sdk/lib-dynamodb";
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

  const friendId = event.pathParameters?.id;

  if (!friendId) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: "friendId is required" }),
    };
  }

  try {
    // Delete both directions
    await dynamoDb.send(
      new DeleteCommand({
        TableName: Resource.Friends.name,
        Key: { userId, friendId },
      })
    );

    await dynamoDb.send(
      new DeleteCommand({
        TableName: Resource.Friends.name,
        Key: { userId: friendId, friendId: userId },
      })
    );

    return {
      statusCode: 200,
      body: JSON.stringify({ message: "Friend removed successfully" }),
    };
  } catch (error) {
    console.error("Error removing friend:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Could not remove friend" }),
    };
  }
};
