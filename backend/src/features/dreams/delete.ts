import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, DeleteCommand } from "@aws-sdk/lib-dynamodb";
import { Resource } from "sst";

const client = new DynamoDBClient({});
const dynamoDb = DynamoDBDocumentClient.from(client);

export const handler = async (event: any) => {
  const userId = event.requestContext.authorizer.jwt.claims.sub;
  const dreamId = event.pathParameters.id;

  console.log("Delete request:", { userId, dreamId });

  const params = {
    TableName: Resource.Dreams.name,
    Key: {
      userId: userId,
      dreamId: dreamId,
    },
  };

  try {
    await dynamoDb.send(new DeleteCommand(params));
    console.log("Dream deleted successfully:", dreamId);
    return {
      statusCode: 200,
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
      },
      body: JSON.stringify({
        status: true,
        message: "Dream deleted successfully",
      }),
    };
  } catch (error) {
    console.error("Error deleting dream:", error);
    return {
      statusCode: 500,
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
      },
      body: JSON.stringify({
        error: "Could not delete dream",
        details: String(error),
      }),
    };
  }
};
