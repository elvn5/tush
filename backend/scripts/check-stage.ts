#!/usr/bin/env tsx

import * as fs from "fs";
import * as path from "path";

const stageFile = path.join(__dirname, "../.sst/stage");
const outputsFile = path.join(__dirname, "../.sst/outputs.json");
const flutterConfigFile = path.join(
  __dirname,
  "../../assets/amplify_outputs.json",
);
const appConfigFile = path.join(
  __dirname,
  "../../lib/core/config/app_config.dart",
);

console.log("🔍 Checking SST Stage Configuration\n");

// Check stage file
if (fs.existsSync(stageFile)) {
  const currentStage = fs.readFileSync(stageFile, "utf8").trim();
  console.log(`✅ Current Stage: ${currentStage}`);
} else {
  console.log("❌ Stage file not found - SST not initialized");
}

// Check outputs
if (fs.existsSync(outputsFile)) {
  const outputs = JSON.parse(fs.readFileSync(outputsFile, "utf8"));
  console.log(`\n📡 Backend Configuration:`);
  console.log(`   API Endpoint: ${outputs.ApiEndpoint}`);
  console.log(`   User Pool: ${outputs.UserPoolId}`);
  console.log(`   Client ID: ${outputs.UserPoolClientId}`);
} else {
  console.log("\n❌ Outputs file not found");
}

// Check Flutter config
if (fs.existsSync(flutterConfigFile)) {
  const flutterConfig = JSON.parse(fs.readFileSync(flutterConfigFile, "utf8"));
  console.log(`\n📱 Flutter Configuration:`);
  console.log(`   API URL: ${flutterConfig.data?.url || "N/A"}`);
  console.log(`   User Pool: ${flutterConfig.auth?.user_pool_id || "N/A"}`);
} else {
  console.log("\n❌ Flutter config not found");
}

// Check app config
if (fs.existsSync(appConfigFile)) {
  const appConfig = fs.readFileSync(appConfigFile, "utf8");
  const urlMatch = appConfig.match(/apiUrl\s*=\s*'([^']+)'/);
  if (urlMatch) {
    console.log(`\n⚙️  App Config:`);
    console.log(`   API URL: ${urlMatch[1]}`);
  }
}

console.log("\n");
