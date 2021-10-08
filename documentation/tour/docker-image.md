---

resources:
  - parent: "Production best practices"
    title: "Deployment using Docker"
    link: "/blacksmith/production/deploy/deployment-docker"
    icon: "logoDocker"

---

### Docker images

Blacksmith can be used inside a Docker container using one of the official Docker
images.

When generating a new Blacksmith application, Dockerfiles are created as well
with:
- `Dockerfile.server` for running the server;
- `Dockerfile.loader` for running the worker `loader`;
- `Dockerfile.operator` for running the worker `operator`;
- `Dockerfile.gateway` for running the gateway.
