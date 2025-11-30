#!/usr/bin/env ts-node

import * as fs from "fs";
import * as path from "path";

interface SSTOutputs {
  ApiEndpoint: string;
  UserPoolId: string;
  UserPoolClientId: string;
}

interface AmplifyGen2Config {
  version: string;
  auth: {
    aws_region: string;
    user_pool_id: string;
    user_pool_client_id: string;
    identity_pool_id?: string;
    username_attributes: string[];
    standard_required_attributes: string[];
    user_verification_types: string[];
    mfa_configuration: string;
    password_policy: {
      min_length: number;
      require_lowercase: boolean;
      require_uppercase: boolean;
      require_numbers: boolean;
      require_symbols: boolean;
    };
  };
  data?: {
    aws_region: string;
    url: string;
    api_key?: string;
    default_authorization_type: string;
    authorization_types: string[];
  };
}

// Read SST outputs
const outputsPath = path.join(__dirname, "../.sst/outputs.json");
const outputs: SSTOutputs = JSON.parse(fs.readFileSync(outputsPath, "utf8"));

const { ApiEndpoint, UserPoolId, UserPoolClientId } = outputs;
const region = UserPoolId.split("_")[0];

// Generate Amplify Gen 2 config
const amplifyConfig: AmplifyGen2Config = {
  version: "1",
  auth: {
    aws_region: region,
    user_pool_id: UserPoolId,
    user_pool_client_id: UserPoolClientId,
    username_attributes: ["EMAIL"],
    standard_required_attributes: ["EMAIL"],
    user_verification_types: ["EMAIL"],
    mfa_configuration: "NONE",
    password_policy: {
      min_length: 8,
      require_lowercase: false,
      require_uppercase: false,
      require_numbers: false,
      require_symbols: false,
    },
  },
  data: {
    aws_region: region,
    url: ApiEndpoint,
    default_authorization_type: "AMAZON_COGNITO_USER_POOLS",
    authorization_types: ["AMAZON_COGNITO_USER_POOLS"],
  },
};

// Save to Flutter assets
const outputPath = path.join(__dirname, "../../assets/amplify_outputs.json");
fs.writeFileSync(outputPath, JSON.stringify(amplifyConfig, null, 2), "utf8");

console.log("✅ Successfully generated assets/amplify_outputs.json");
console.log(`   Region: ${region}`);
console.log(`   UserPoolId: ${UserPoolId}`);
console.log(`   ClientId: ${UserPoolClientId}`);
console.log(`   ApiEndpoint: ${ApiEndpoint}`);

// Update lib/core/config/app_config.dart
const appConfigPath = path.join(
  __dirname,
  "../../lib/core/config/app_config.dart"
);
const appConfigContent = `class AppConfig {
  static const String apiUrl =
      '${ApiEndpoint}';
}
`;
fs.writeFileSync(appConfigPath, appConfigContent, "utf8");
console.log("✅ Successfully updated lib/core/config/app_config.dart");
