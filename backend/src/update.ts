import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, UpdateCommand } from "@aws-sdk/lib-dynamodb";
import { Resource } from "sst";

const client = new DynamoDBClient({});
const dynamoDb = DynamoDBDocumentClient.from(client);

export const handler = async (event: any) => {
  const data = JSON.parse(event.body);
  const userId = event.requestContext.authorizer.jwt.claims.sub;
  const dreamId = event.pathParameters.id;

  const params = {
    TableName: Resource.Dreams.name,
    Key: {
      userId: userId,
      dreamId: dreamId,
    },
    UpdateExpression:
      "SET title = :title, dream = :dream, updatedAt = :updatedAt",
    ExpressionAttributeValues: {
      ":title": data.title,
      ":dream": data.dream,
      ":updatedAt": Date.now(),
    },
    ReturnValues: "ALL_NEW" as const,
  };

  try {
    const result = await dynamoDb.send(new UpdateCommand(params));
    return {
      statusCode: 200,
      body: JSON.stringify(result.Attributes),
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Could not update dream" }),
    };
  }
};
