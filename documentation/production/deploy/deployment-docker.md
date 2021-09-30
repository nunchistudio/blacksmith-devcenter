---
title: Deployment with Docker
enterprise: false
---

# Deployment with Docker

Blacksmith can be used inside a Docker container using one of the official Docker
images:
- [`blacksmith`](https://hub.docker.com/r/nunchistudio/blacksmith) or
  [`blacksmith-standard`](https://hub.docker.com/r/nunchistudio/blacksmith-standard)
  for Blacksmith Standard Edition
- [`blacksmith-enterprise`](https://hub.docker.com/r/nunchistudio/blacksmith-enterprise)
  for Blacksmith Enterprise Edition

Images follow the convention:
`nunchistudio/blacksmith[-edition]:[version][-distribution]`:
- `edition` is the Blacksmith Edition and is one of `standard`, `enterprise.`
  Defaults to `standard`.
- `version` is the Blacksmith version. Defaults to `latest`.
- `distribution` is one of `alpine`, `bullseye`, `buster`. Defaults to `bullseye`.

We recommend to always explicitly set the `version` to avoid any surprises in
production.

When generating a new Blacksmith application, Dockerfiles are created as well
with:
- `Dockerfile.server` for running the server;
- `Dockerfile.loader` for running the worker `loader`;
- `Dockerfile.operator` for running the worker `operator`;
- `Dockerfile.gateway` for running the gateway.

A valid Dockerfile for running Blacksmith should look like this:
```dockerfile
FROM nunchistudio/blacksmith-enterprise:1.0.0-alpine

# Copy the application inside the container.
COPY ./ /app
WORKDIR /app

# Start the Blacksmith worker 'loader'.
CMD ["blacksmith", "start", "worker", "loader"]
```
