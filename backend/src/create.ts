import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, PutCommand } from "@aws-sdk/lib-dynamodb";
import { Resource } from "sst";
import { v4 as uuidv4 } from "uuid";

const client = new DynamoDBClient({});
const dynamoDb = DynamoDBDocumentClient.from(client);

export const handler = async (event: any) => {
  const data = JSON.parse(event.body);
  const userId = event.requestContext.authorizer.jwt.claims.sub;
  const dreamId = uuidv4();

  const params = {
    TableName: Resource.Dreams.name,
    Item: {
      userId: userId,
      dreamId: dreamId,
      title: data.title,
      dream: data.dream,
      createdAt: Date.now(),
      updatedAt: Date.now(),
    },
  };

  try {
    await dynamoDb.send(new PutCommand(params));
    return {
      statusCode: 200,
      body: JSON.stringify(params.Item),
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Could not create dream" }),
    };
  }
};
