find /app/test/tracetesting/ -name all.yaml | xargs -i /app/tracetest apply testsuite --config /app/test/tracetesting/cli-config.yml -f {}

/app/tracetest apply variableset --config /app/test/tracetesting/cli-config.yml -f /app/tracetest-vars.yaml
