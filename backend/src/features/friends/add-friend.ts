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

    // Check if request already exists
    const existingRequest = await dynamoDb.send(
      new GetCommand({
        TableName: Resource.FriendRequests.name,
        Key: { recipientId: friendId, senderId: userId },
      })
    );

    if (existingRequest.Item) {
      return {
        statusCode: 409,
        body: JSON.stringify({ error: "Friend request already sent" }),
      };
    }

    // Check if there's a pending request from the other user (auto-accept)
    const reverseRequest = await dynamoDb.send(
      new GetCommand({
        TableName: Resource.FriendRequests.name,
        Key: { recipientId: userId, senderId: friendId },
      })
    );

    if (reverseRequest.Item) {
      // Auto-accept: they already sent us a request, so just become friends
      const now = Date.now();

      // Create bidirectional friendship
      await dynamoDb.send(
        new PutCommand({
          TableName: Resource.Friends.name,
          Item: { userId, friendId, createdAt: now },
        })
      );
      await dynamoDb.send(
        new PutCommand({
          TableName: Resource.Friends.name,
          Item: { userId: friendId, friendId: userId, createdAt: now },
        })
      );

      // Delete the pending request
      const { DeleteCommand } = await import("@aws-sdk/lib-dynamodb");
      await dynamoDb.send(
        new DeleteCommand({
          TableName: Resource.FriendRequests.name,
          Key: { recipientId: userId, senderId: friendId },
        })
      );

      return {
        statusCode: 201,
        body: JSON.stringify({ message: "Friend added successfully" }),
      };
    }

    // Create a pending friend request
    const now = Date.now();
    await dynamoDb.send(
      new PutCommand({
        TableName: Resource.FriendRequests.name,
        Item: {
          recipientId: friendId,
          senderId: userId,
          createdAt: now,
        },
      })
    );

    return {
      statusCode: 201,
      body: JSON.stringify({ message: "Friend request sent" }),
    };
  } catch (error) {
    console.error("Error adding friend:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Could not send friend request" }),
    };
  }
};
