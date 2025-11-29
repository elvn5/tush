import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, UpdateCommand } from "@aws-sdk/lib-dynamodb";
import { DynamoDBStreamEvent } from "aws-lambda";
import { GoogleGenerativeAI } from "@google/generative-ai";
import { Resource } from "sst";

const client = new DynamoDBClient({});
const dynamoDb = DynamoDBDocumentClient.from(client);

const genAI = new GoogleGenerativeAI("AIzaSyD12KmZDQQTDlI_Yi9vOU--wTdD1e1x_DA");
const model = genAI.getGenerativeModel({ model: "gemini-pro" });

export const handler = async (event: DynamoDBStreamEvent) => {
  for (const record of event.Records) {
    if (record.eventName === "INSERT") {
      const newImage = record.dynamodb?.NewImage;
      if (newImage) {
        const userId = newImage.userId.S;
        const dreamId = newImage.dreamId.S;
        const dreamText = newImage.dream.S;

        if (userId && dreamId && dreamText) {
          try {
            const prompt = `Interpret this dream: ${dreamText}`;
            const result = await model.generateContent(prompt);
            const response = await result.response;
            const interpretation = response.text();

            // Update the dream in DynamoDB
            await dynamoDb.send(
              new UpdateCommand({
                TableName: Resource.Dreams.name,
                Key: { userId, dreamId },
                UpdateExpression: "SET interpretation = :i, isReady = :r",
                ExpressionAttributeValues: {
                  ":i": interpretation,
                  ":r": true,
                },
              })
            );
            console.log(`Interpreted dream ${dreamId} for user ${userId}`);
          } catch (error) {
            console.error(`Error interpreting dream ${dreamId}:`, error);
          }
        }
      }
    }
  }
};
