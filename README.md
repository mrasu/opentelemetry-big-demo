# OpenTelemetry Big Demo

Compare OpenTelemetry tools here

# How to use

```shell
git clone --recursive git@github.com:mrasu/opentelemetry-big-demo.git
cd opentelemetry-big-demo

make start-all
```

Then, you can use any tools

When you want to run a specific tool, you can use `make start-xxx`, e.g. `make start-signoz`

# UsableTools

- [x] [SigNoz](https://signoz.io/) at http://localhost:10001 (need to create an account first)
- [x] [OpenObserve](https://openobserve.ai/) at http://localhost:10002 (email=root@example.com, password=root)
- [x] [Grafana stack](https://grafana.com/) at http://localhost:1003
- [ ] and more...
