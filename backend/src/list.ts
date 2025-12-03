import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, QueryCommand } from "@aws-sdk/lib-dynamodb";
import { Resource } from "sst";

const client = new DynamoDBClient({});
const dynamoDb = DynamoDBDocumentClient.from(client);

export const handler = async (event: any) => {
  const userId = event.requestContext.authorizer.jwt.claims.sub;
  const { limit, cursor, search, status, startDate, endDate } =
    event.queryStringParameters || {};

  const queryLimit = limit ? parseInt(limit) : 10;
  const exclusiveStartKey = cursor
    ? JSON.parse(Buffer.from(cursor, "base64").toString("utf-8"))
    : undefined;

  const expressionAttributeValues: any = {
    ":userId": userId,
  };
  const expressionAttributeNames: any = {};
  let filterExpression = "";

  if (search) {
    filterExpression +=
      "(contains(#title, :search) OR contains(#description, :search))";
    expressionAttributeValues[":search"] = search;
    expressionAttributeNames["#title"] = "title";
    expressionAttributeNames["#description"] = "description";
  }

  if (status) {
    if (filterExpression) filterExpression += " AND ";
    filterExpression += "#isReady = :status";
    expressionAttributeValues[":status"] = status === "true";
    expressionAttributeNames["#isReady"] = "isReady";
  }

  if (startDate && endDate) {
    if (filterExpression) filterExpression += " AND ";
    filterExpression += "#createdAt BETWEEN :startDate AND :endDate";
    expressionAttributeValues[":startDate"] = parseInt(startDate);
    expressionAttributeValues[":endDate"] = parseInt(endDate);
    expressionAttributeNames["#createdAt"] = "createdAt";
  } else if (startDate) {
    if (filterExpression) filterExpression += " AND ";
    filterExpression += "#createdAt >= :startDate";
    expressionAttributeValues[":startDate"] = parseInt(startDate);
    expressionAttributeNames["#createdAt"] = "createdAt";
  } else if (endDate) {
    if (filterExpression) filterExpression += " AND ";
    filterExpression += "#createdAt <= :endDate";
    expressionAttributeValues[":endDate"] = parseInt(endDate);
    expressionAttributeNames["#createdAt"] = "createdAt";
  }

  const params: any = {
    TableName: Resource.Dreams.name,
    KeyConditionExpression: "userId = :userId",
    ExpressionAttributeValues: expressionAttributeValues,
    Limit: queryLimit,
    ExclusiveStartKey: exclusiveStartKey,
  };

  if (filterExpression) {
    params.FilterExpression = filterExpression;
  }

  if (Object.keys(expressionAttributeNames).length > 0) {
    params.ExpressionAttributeNames = expressionAttributeNames;
  }

  try {
    const result = await dynamoDb.send(new QueryCommand(params));

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
    console.error(error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Could not retrieve dreams" }),
    };
  }
};
