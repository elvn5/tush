#!/usr/bin/env tsx

import * as fs from "fs";
import * as path from "path";
import { execSync } from "child_process";

const outputsPath = path.join(__dirname, "../.sst/outputs.json");
const sstDir = path.join(__dirname, "../.sst");

console.log("👀 Watching for SST outputs changes...");
console.log(`   Monitoring: ${outputsPath}`);

let isUpdating = false;

// Function to update Flutter config
function updateFlutterConfig() {
  if (isUpdating) return;

  try {
    isUpdating = true;
    console.log("\n📱 SST outputs changed, updating Flutter configuration...");
    execSync("npm run update-flutter-config", {
      cwd: path.join(__dirname, ".."),
      stdio: "inherit",
    });
    console.log("✅ Flutter config updated successfully!\n");
  } catch (error) {
    console.error("⚠️  Failed to update Flutter config:", error);
  } finally {
    isUpdating = false;
  }
}

// Wait for .sst directory to be created (in case dev hasn't started yet)
function waitForSSTDir() {
  if (!fs.existsSync(sstDir)) {
    console.log("⏳ Waiting for SST to initialize...");
    const interval = setInterval(() => {
      if (fs.existsSync(sstDir)) {
        clearInterval(interval);
        startWatching();
      }
    }, 1000);
  } else {
    startWatching();
  }
}

function startWatching() {
  // Run once initially if outputs already exist
  if (fs.existsSync(outputsPath)) {
    console.log("📄 Found existing outputs, updating config...");
    updateFlutterConfig();
  }

  // Watch for changes
  try {
    // Watch the .sst directory for any changes
    fs.watch(sstDir, { recursive: true }, (eventType, filename) => {
      if (filename && filename.includes("outputs.json")) {
        // Debounce rapid changes
        setTimeout(() => {
          if (fs.existsSync(outputsPath)) {
            updateFlutterConfig();
          }
        }, 500);
      }
    });

    console.log("✅ Watcher is active. Press Ctrl+C to stop.\n");
  } catch (error) {
    console.error("❌ Failed to set up file watcher:", error);
    process.exit(1);
  }
}

// Handle graceful shutdown
process.on("SIGINT", () => {
  console.log("\n👋 Stopping watcher...");
  process.exit(0);
});

process.on("SIGTERM", () => {
  console.log("\n👋 Stopping watcher...");
  process.exit(0);
});

waitForSSTDir();
