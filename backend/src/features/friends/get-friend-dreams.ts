import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import {
  DynamoDBDocumentClient,
  QueryCommand,
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

  const friendId = event.pathParameters?.id;
  if (!friendId) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: "Friend ID is required" }),
    };
  }

  try {
    // Verify friendship exists
    const friendshipResult = await dynamoDb.send(
      new GetCommand({
        TableName: Resource.Friends.name,
        Key: {
          userId: userId,
          friendId: friendId,
        },
      })
    );

    if (!friendshipResult.Item) {
      return {
        statusCode: 403,
        body: JSON.stringify({ error: "You are not friends with this user" }),
      };
    }

    // Get friend's dreams
    const { limit, cursor } = event.queryStringParameters || {};
    const queryLimit = limit ? parseInt(limit) : 10;
    const exclusiveStartKey = cursor
      ? JSON.parse(Buffer.from(cursor, "base64").toString("utf-8"))
      : undefined;

    const result = await dynamoDb.send(
      new QueryCommand({
        TableName: Resource.Dreams.name,
        KeyConditionExpression: "userId = :userId",
        ExpressionAttributeValues: {
          ":userId": friendId,
        },
        Limit: queryLimit,
        ExclusiveStartKey: exclusiveStartKey,
      })
    );

    const nextCursor = result.LastEvaluatedKey
      ? Buffer.from(JSON.stringify(result.LastEvaluatedKey)).toString("base64")
      : null;

    return {
      statusCode: 200,
      body: JSON.stringify({
        items: result.Items,
        nextCursor,
      }),
    };
  } catch (error) {
    console.error("Error getting friend dreams:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Could not retrieve friend's dreams" }),
    };
  }
};
