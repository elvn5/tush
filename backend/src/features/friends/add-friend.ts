import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import {
  DynamoDBDocumentClient,
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

  const body = JSON.parse(event.body || "{}");
  const { friendId } = body;

  if (!friendId) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: "friendId is required" }),
    };
  }

  if (friendId === userId) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: "Cannot add yourself as a friend" }),
    };
  }

  try {
    // Check if already friends
    const existingFriend = await dynamoDb.send(
      new GetCommand({
        TableName: Resource.Friends.name,
        Key: { userId, friendId },
      })
    );

    if (existingFriend.Item) {
      return {
        statusCode: 409,
        body: JSON.stringify({ error: "Already friends" }),
      };
    }

    const now = Date.now();

    // Add friend relationship (both directions for easy querying)
    await dynamoDb.send(
      new PutCommand({
        TableName: Resource.Friends.name,
        Item: {
          userId,
          friendId,
          createdAt: now,
        },
      })
    );

    // Add reverse relationship
    await dynamoDb.send(
      new PutCommand({
        TableName: Resource.Friends.name,
        Item: {
          userId: friendId,
          friendId: userId,
          createdAt: now,
        },
      })
    );

    return {
      statusCode: 201,
      body: JSON.stringify({ message: "Friend added successfully" }),
    };
  } catch (error) {
    console.error("Error adding friend:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Could not add friend" }),
    };
  }
};
