#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# Runs INSIDE the Docker container.
# Called by scripts/docker-build.sh via `docker run`.
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

BUILD_TYPE="${BUILD_TYPE:-apk}"           # apk | aab
API_URL="${API_URL:-http://localhost:8080}"
HOST_UID="${HOST_UID:-0}"
HOST_GID="${HOST_GID:-0}"

KEYSTORE_PATH="/tmp/morpheus-release.jks"
KEY_PROPERTIES="/workspace/android/key.properties"

# ── Validate required env vars ────────────────────────────────────────────────
for var in KEYSTORE_FILE_BASE64 KEYSTORE_PASSWORD KEY_ALIAS KEY_PASSWORD; do
    if [[ -z "${!var:-}" ]]; then
        echo "❌  Missing required env var: ${var}"
        exit 1
    fi
done

cleanup() {
    rm -f "${KEYSTORE_PATH}" "${KEY_PROPERTIES}"
}
trap cleanup EXIT

# ── Decode keystore ───────────────────────────────────────────────────────────
echo "🔑  Decoding keystore..."
echo "${KEYSTORE_FILE_BASE64}" | base64 -d > "${KEYSTORE_PATH}"

# ── Write key.properties (read by android/app/build.gradle.kts) ──────────────
cat > "${KEY_PROPERTIES}" <<EOF
storePassword=${KEYSTORE_PASSWORD}
keyPassword=${KEY_PASSWORD}
keyAlias=${KEY_ALIAS}
storeFile=${KEYSTORE_PATH}
EOF

# ── Flutter pub get ───────────────────────────────────────────────────────────
cd /workspace
echo "📦  Fetching packages..."
flutter pub get

# ── Build ─────────────────────────────────────────────────────────────────────
mkdir -p /workspace/build-output

if [[ "${BUILD_TYPE}" == "aab" ]]; then
    echo "🏗️   Building App Bundle (AAB)..."
    flutter build appbundle --release \
        --dart-define=API_URL="${API_URL}"

    ARTIFACT_SRC="/workspace/build/app/outputs/bundle/release/app-release.aab"
    ARTIFACT_DST="/workspace/build-output/app-release.aab"
else
    echo "🏗️   Building APK..."
    flutter build apk --release \
        --dart-define=API_URL="${API_URL}"

    ARTIFACT_SRC="/workspace/build/app/outputs/flutter-apk/app-release.apk"
    ARTIFACT_DST="/workspace/build-output/app-release.apk"
fi

cp "${ARTIFACT_SRC}" "${ARTIFACT_DST}"

# ── Fix ownership so files belong to the host user, not root ─────────────────
if [[ "${HOST_UID}" != "0" ]]; then
    chown -R "${HOST_UID}:${HOST_GID}" /workspace/build-output
fi

echo ""
echo "✅  Done! Artifact:"
ls -lh /workspace/build-output/
