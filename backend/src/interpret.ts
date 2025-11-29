import { DynamoDBStreamHandler } from "aws-lambda";
import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, UpdateCommand } from "@aws-sdk/lib-dynamodb";
import { unmarshall } from "@aws-sdk/util-dynamodb";
import { GoogleGenerativeAI } from "@google/generative-ai";
import { Resource } from "sst";

const client = new DynamoDBClient({});
const dynamoDb = DynamoDBDocumentClient.from(client);

// Initialize Gemini AI
// Ensure GEMINI_API_KEY is set in your environment variables
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || "");
const model = genAI.getGenerativeModel({ model: "gemini-flash-latest" });

export const handler: DynamoDBStreamHandler = async (event) => {
  console.log(`Processing ${event.Records.length} records`);

  for (const record of event.Records) {
    try {
      if (record.eventName !== "INSERT") {
        console.log(`Skipping event type: ${record.eventName}`);
        continue;
      }

      if (!record.dynamodb?.NewImage) {
        console.log("No NewImage found in record");
        continue;
      }

      // Unmarshall the DynamoDB record
      const newImage = unmarshall(record.dynamodb.NewImage as any);
      const { userId, dreamId, dream } = newImage;

      if (!dream) {
        console.log(
          `No dream text found for user: ${userId}, dreamId: ${dreamId}`
        );
        continue;
      }

      console.log(
        `Interpreting dream for user: ${userId}, dreamId: ${dreamId}`
      );

      // Call Gemini AI
      const prompt =
        "Ты толкователь снов. Дай краткую, мистическую, но полезную интерпретацию для этого сна";
      const result = await model.generateContent([prompt, dream]);
      const response = await result.response;
      const interpretation = response.text();

      // Update the record in DynamoDB
      const updateParams = {
        TableName: Resource.Dreams.name,
        Key: {
          userId: userId,
          dreamId: dreamId,
        },
        UpdateExpression:
          "SET interpretation = :i, isReady = :r, updatedAt = :u",
        ExpressionAttributeValues: {
          ":i": interpretation,
          ":r": true,
          ":u": Date.now(),
        },
      };

      await dynamoDb.send(new UpdateCommand(updateParams));
      console.log(`Successfully updated dream interpretation for ${dreamId}`);
    } catch (error) {
      console.error(
        `Error processing record: ${JSON.stringify(record)}`,
        error
      );
      // We continue to the next record so one failure doesn't stop the whole batch
    }
  }
};
