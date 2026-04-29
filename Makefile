IMAGE_NAME := morpheus-android-builder

# ── Android build targets ─────────────────────────────────────────────────────

## Build release APK
android-apk:
	./scripts/docker-build.sh apk

## Build release App Bundle (AAB) — default release target
android-aab:
	./scripts/docker-build.sh aab

## Alias: release = aab
android-release: android-aab

## Build the Docker image without running a build
android-image:
	docker build \
		-f Dockerfile.android \
		-t $(IMAGE_NAME) \
		.

## Force-rebuild the Docker image (useful after Flutter/SDK version bump)
android-image-rebuild:
	docker build \
		--no-cache \
		-f Dockerfile.android \
		-t $(IMAGE_NAME) \
		.

## Remove build artifacts
android-clean:
	rm -rf build-output/

## Remove build artifacts AND Docker image
android-clean-all: android-clean
	docker rmi -f $(IMAGE_NAME) 2>/dev/null || true

.PHONY: android-apk android-aab android-release android-image android-image-rebuild android-clean android-clean-all
