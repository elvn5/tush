import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, DeleteCommand } from "@aws-sdk/lib-dynamodb";
import { Resource } from "sst";

const client = new DynamoDBClient({});
const dynamoDb = DynamoDBDocumentClient.from(client);

export const handler = async (event: any) => {
  const userId = event.requestContext.authorizer.jwt.claims.sub;
  const dreamId = event.pathParameters.id;

  const params = {
    TableName: Resource.Dreams.name,
    Key: {
      userId: userId,
      dreamId: dreamId,
    },
  };

  try {
    await dynamoDb.send(new DeleteCommand(params));
    return {
      statusCode: 200,
      body: JSON.stringify({ status: true }),
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Could not delete dream" }),
    };
  }
};
