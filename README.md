# OpenTelemetry Big Demo

Compare OpenTelemetry backends here

# How to use

```shell
git clone git@github.com:mrasu/opentelemetry-big-demo.git
cd opentelemetry-big-demo

make start-all
```

Then, you can use all backends like SigNoz at http://localhost:10001

When you want to run a specific project, you can use `make start-xxx`, e.g. `make start-signoz`

# Usable Backends

- [x] [SigNoz](https://signoz.io/) at http://localhost:10001 (need to create an account first)
- [x] [OpenObserve](https://openobserve.ai/) at http://localhost:10002 (email=root@example.com, password=root)
- [ ] Grafana stack
- [ ] and more...
