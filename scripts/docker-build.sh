#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# Host-side build orchestrator.
# Usage:
#   ./scripts/docker-build.sh apk
#   ./scripts/docker-build.sh aab
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

BUILD_TYPE="${1:-apk}"
IMAGE_NAME="morpheus-android-builder"
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# ── Load .env.android if present ─────────────────────────────────────────────
ENV_FILE="${PROJECT_ROOT}/.env.android"
if [[ -f "${ENV_FILE}" ]]; then
    echo "📄  Loading ${ENV_FILE}"
    set -a
    # shellcheck source=/dev/null
    source "${ENV_FILE}"
    set +a
fi

# ── Validate required vars ────────────────────────────────────────────────────
missing=()
for var in KEYSTORE_FILE_BASE64 KEYSTORE_PASSWORD KEY_ALIAS KEY_PASSWORD; do
    [[ -z "${!var:-}" ]] && missing+=("${var}")
done

if [[ ${#missing[@]} -gt 0 ]]; then
    echo "❌  Missing required variables: ${missing[*]}"
    echo "    Copy .env.android.example → .env.android and fill in the values."
    exit 1
fi

if [[ "${BUILD_TYPE}" != "apk" && "${BUILD_TYPE}" != "aab" ]]; then
    echo "❌  Unknown build type: '${BUILD_TYPE}'. Use 'apk' or 'aab'."
    exit 1
fi

# ── Build Docker image (skip if already up-to-date) ──────────────────────────
if ! docker image inspect "${IMAGE_NAME}" &>/dev/null; then
    echo "🐳  Building Docker image for the first time (this takes ~5 min)..."
    docker build \
        -f "${PROJECT_ROOT}/Dockerfile.android" \
        -t "${IMAGE_NAME}" \
        "${PROJECT_ROOT}"
fi

mkdir -p "${PROJECT_ROOT}/build-output"

# ── Run build inside container ────────────────────────────────────────────────
echo "🚀  Starting ${BUILD_TYPE^^} build..."
docker run --rm \
    --user "$(id -u):$(id -g)" \
    -v "${PROJECT_ROOT}:/workspace" \
    -v "${HOME}/.pub-cache:/root/.pub-cache" \
    -v "${HOME}/.gradle:/root/.gradle" \
    -e BUILD_TYPE="${BUILD_TYPE}" \
    -e KEYSTORE_FILE_BASE64="${KEYSTORE_FILE_BASE64}" \
    -e KEYSTORE_PASSWORD="${KEYSTORE_PASSWORD}" \
    -e KEY_ALIAS="${KEY_ALIAS}" \
    -e KEY_PASSWORD="${KEY_PASSWORD}" \
    -e API_URL="${API_URL:-https://your-production-server.com}" \
    -e HOST_UID="$(id -u)" \
    -e HOST_GID="$(id -g)" \
    "${IMAGE_NAME}"
