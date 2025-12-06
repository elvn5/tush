.PHONY: up dev deploy

up:
	dart tool/startup.dart $(if $(stage),--stage $(stage),)

dev: up

deploy:
	@echo "Deploying to AWS..."
	cd backend && npx sst deploy --stage $(if $(stage),$(stage),prod)
	@echo "Updating Flutter config..."
	cd backend && npm run update-flutter-config
