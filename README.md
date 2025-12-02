# Tush

A Flutter project with an AWS SST backend.

## Environment Setup

This project uses a single `.env` file or CLI flags to manage deployment environments (e.g., `dev`, `stage`, `prod`).

### 1. Configuration

Create a `.env` file in the root directory:

```env
APP_ENV=dev
```

### 2. Running the App

We use a helper script to start the backend (SST) and automatically configure the Flutter app.

**Using Make:**

```bash
# Uses APP_ENV from .env
make up

# Override stage via CLI
make up stage=$stage
# Example: make up stage=prod
```

**Using Dart Script directly:**

```bash
dart tool/startup.dart
dart tool/startup.dart --stage prod
```

**What this does:**

1.  Checks the environment (`APP_ENV` or flag).
2.  Prompts for confirmation if running in `prod`.
3.  Starts `sst dev` for the backend.
4.  Watches for backend output changes and automatically updates `lib/amplifyconfiguration.dart` and `lib/core/config/app_config.dart`.

### 3. Deployment

To deploy the backend without running the dev server:

```bash
make deploy
# OR
make deploy stage=prod
```
