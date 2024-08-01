PWD := $(shell pwd)
DOCKER_COMPOSE_ENV=--env-file ./opentelemetry-demo/.env --env-file .env

COMPOSE_CMD=docker compose --project-directory $(PWD)/opentelemetry-demo --env-file ./opentelemetry-demo/.env --env-file .env -f docker-compose.yml
COMPOSE_UP_CMD=up --force-recreate --remove-orphans --detach

.PHONY: start-all
start-all:
	$(COMPOSE_CMD) \
		-f projects/signoz/docker-compose.yml \
		$(COMPOSE_UP_CMD)
	@echo ""
	@echo "OpenTelemetry Big Demo is running."
	@echo "Go to http://localhost:8080 for the demo UI."
	@echo "Go to http://localhost:8080/jaeger/ui for the Jaeger UI."
	@echo "Go to http://localhost:9090 for the Prometheus UI."
	@echo "Go to http://localhost:10001 for the SigNoz UI."

.PHONY: stop
stop:
	docker compose --project-directory $(PWD)/opentelemetry-demo down --remove-orphans --volumes
	@echo ""
	@echo "OpenTelemetry Big Demo is stopped."
