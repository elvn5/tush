import {
  CognitoIdentityProviderClient,
  ListUsersCommand,
  UserType,
  AttributeType,
} from "@aws-sdk/client-cognito-identity-provider";

const cognitoClient = new CognitoIdentityProviderClient({});

export const handler = async (event: any) => {
  const userId = event.requestContext?.authorizer?.jwt?.claims?.sub;

  if (!userId) {
    return {
      statusCode: 401,
      body: JSON.stringify({ error: "Unauthorized" }),
    };
  }

  const { query } = event.queryStringParameters || {};

  if (!query || query.trim().length < 2) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: "Query must be at least 2 characters" }),
    };
  }

  const userPoolId = process.env.USER_POOL_ID;
  if (!userPoolId) {
    console.error("USER_POOL_ID environment variable not set");
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Server configuration error" }),
    };
  }

  try {
    const command = new ListUsersCommand({
      UserPoolId: userPoolId,
      Filter: `email ^= "${query}"`,
      Limit: 20,
    });

    const response = await cognitoClient.send(command);

    const users = (response.Users || [])
      .filter((user: UserType) => user.Username !== userId)
      .map((user: UserType) => {
        const attributes: AttributeType[] = user.Attributes || [];
        const email = attributes.find((a) => a.Name === "email")?.Value || "";
        const givenName =
          attributes.find((a) => a.Name === "given_name")?.Value || "";
        const familyName =
          attributes.find((a) => a.Name === "family_name")?.Value || "";
        const name =
          givenName || familyName
            ? `${givenName} ${familyName}`.trim()
            : undefined;

        return {
          id: user.Username,
          email,
          name,
        };
      });

    return {
      statusCode: 200,
      body: JSON.stringify({ users }),
    };
  } catch (error) {
    console.error("Error searching users:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Could not search users" }),
    };
  }
};
