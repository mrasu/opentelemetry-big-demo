PWD := $(shell pwd)
DEV_DETACH ?= true
DEV_LOAD ?= true

ifeq ($(DEV_DETACH),true)
	DETACH_CMD=--detach
else
	DETACH_CMD=
endif

ifeq ($(DEV_LOAD),true)
	LOAD_CMD=-f docker-compose-loadgenerator.yml
else
	LOAD_CMD=
endif

DOCKER_COMPOSE_ENV=--env-file ./opentelemetry-demo/.env --env-file .env

COMPOSE_CMD=docker compose --project-directory $(PWD)/opentelemetry-demo --env-file ./opentelemetry-demo/.env --env-file .env -f docker-compose.yml $(LOAD_CMD)
COMPOSE_UP_CMD=up --force-recreate --remove-orphans $(DETACH_CMD)

.PHONY: start-all
start-all:
	$(COMPOSE_CMD) \
		-f backends/signoz/docker-compose.yml \
		-f backends/openobserve/docker-compose.yml \
		-f backends/grafana/docker-compose.yml \
		$(COMPOSE_UP_CMD)
	@echo ""
	@echo "OpenTelemetry Big Demo is running."
	@echo "Go to http://localhost:8080 for the demo UI."
	@echo "Go to http://localhost:8080/jaeger/ui for the Jaeger UI."
	@echo "Go to http://localhost:9090 for the Prometheus UI."
	@echo "Go to http://localhost:10001 for the SigNoz UI."
	@echo "Go to http://localhost:10002 for the OpenObserve UI."
	@echo "Go to http://localhost:10003 for the Grafana UI."

.PHONY: start-signoz
start-signoz:
	OTEL_COLLECTOR_CONFIG_EXTRAS=../backends/signoz/otelcol-config-extras.yml \
		$(COMPOSE_CMD) \
		-f backends/signoz/docker-compose.yml \
		$(COMPOSE_UP_CMD)
	@echo ""
	@echo "OpenTelemetry Big Demo is running."
	@echo "Go to http://localhost:8080 for the demo UI."
	@echo "Go to http://localhost:8080/jaeger/ui for the Jaeger UI."
	@echo "Go to http://localhost:9090 for the Prometheus UI."
	@echo "Go to http://localhost:10001 for the SigNoz UI."

.PHONY: start-openobserve
start-openobserve:
	OTEL_COLLECTOR_CONFIG_EXTRAS=../backends/openobserve/otelcol-config-extras.yml \
		$(COMPOSE_CMD) \
		-f backends/openobserve/docker-compose.yml \
		$(COMPOSE_UP_CMD)
	@echo ""
	@echo "OpenTelemetry Big Demo is running."
	@echo "Go to http://localhost:8080 for the demo UI."
	@echo "Go to http://localhost:8080/jaeger/ui for the Jaeger UI."
	@echo "Go to http://localhost:9090 for the Prometheus UI."
	@echo "Go to http://localhost:10002 for the OpenObserve UI."


.PHONY: start-grafana
start-grafana:
	OTEL_COLLECTOR_CONFIG_EXTRAS=../backends/grafana/otelcol-config-extras.yml \
		$(COMPOSE_CMD) \
		-f backends/grafana/docker-compose.yml \
		$(COMPOSE_UP_CMD)
	@echo ""
	@echo "OpenTelemetry Big Demo is running."
	@echo "Go to http://localhost:8080 for the demo UI."
	@echo "Go to http://localhost:8080/jaeger/ui for the Jaeger UI."
	@echo "Go to http://localhost:9090 for the Prometheus UI."
	@echo "Go to http://localhost:10003 for the Grafana UI."

.PHONY: stop
stop:
	docker compose --project-directory $(PWD)/opentelemetry-demo down --remove-orphans --volumes
	@echo ""
	@echo "OpenTelemetry Big Demo is stopped."

.PHONY: clean
clean:
	sudo rm -rf backends/data
	# Tempo requires its directory to be owned by user 10001
	mkdir -p backends/data/grafana/tempo-data/ && touch backends/data/grafana/tempo-data/.git-keep && sudo chown 10001:10001 backends/data/grafana/tempo-data/
