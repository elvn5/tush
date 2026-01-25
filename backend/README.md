# Backend Development Workflow

## Setup

The backend automatically updates the Flutter configuration file when running in development mode.

## Commands

### Development Mode

```bash
npm run dev
```

This command now does two things in parallel:

1. **Starts SST dev server** (`sst dev`) - Your backend infrastructure
2. **Watches for config changes** - Automatically updates `assets/amplify_outputs.json` when SST outputs change

The watcher will:

- Wait for SST to initialize
- Detect when `.sst/outputs.json` is created or updated
- Automatically run the Flutter config update script
- Keep watching for changes throughout your dev session

### Deployment

```bash
npm run deploy
```

This deploys to AWS and automatically updates the Flutter config file via the `postdeploy` hook.

### Manual Config Update

```bash
npm run update-flutter-config
```

Manually update the Flutter configuration from the current SST outputs.

## How It Works

1. **SST generates outputs** → `.sst/outputs.json` is created/updated
2. **File watcher detects change** → `scripts/watch-and-update.ts` notices the change
3. **Config script runs** → `scripts/update-flutter-config.ts` executes
4. **Flutter files updated** → Both `assets/amplify_outputs.json` and `lib/core/config/app_config.dart` are regenerated

## Files Involved

- `package.json` - Contains the npm scripts
- `scripts/watch-and-update.ts` - File watcher that monitors SST outputs
- `scripts/update-flutter-config.ts` - Generates Flutter configuration files
- `.sst/outputs.json` - SST infrastructure outputs (auto-generated)
- `assets/amplify_outputs.json` - Amplify configuration for Flutter (auto-generated)
- `lib/core/config/app_config.dart` - App configuration for Flutter (auto-generated)

## Troubleshooting

If the config doesn't update automatically:

1. Check that both processes are running (you should see output from both SST and the watcher)
2. Verify that `.sst/outputs.json` exists
3. Try running `npm run update-flutter-config` manually to see any error messages
