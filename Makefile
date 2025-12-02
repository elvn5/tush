.PHONY: up dev deploy

up:
	dart tool/startup.dart $(if $(stage),--stage $(stage),)

dev: up

deploy:
	@echo "Deploying..."
	@dart tool/startup.dart --deploy $(if $(stage),--stage $(stage),)
