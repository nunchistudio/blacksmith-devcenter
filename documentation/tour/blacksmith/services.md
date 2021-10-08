---

services:
  server:
    schema:
      - key: "archival"
        type: "object"
        example:
          driver: "aws/s3"
          connection: "mybucket"
        defaults:
          driver: "local"
          connection: "./blacksmith/.archival"
        required: true
        description: |
          The archival details to archive workflows when retention period is met.

  gateway:
    schema:
      - key: "address"
        type: "string"
        example: ":9090"
        defaults: ":9090"
        required: true
        description: |
          The address and port to which the service gateway is listening to.

      - key: "cors"
        type: "object"
        items:
          - key: "allowedOrigins"
            type: "[]string"
            description: |
              List of origins a cross-domain request can be executed from. If the
              special `*` value is present in the list, all origins will be allowed.
              An origin may contain a wildcard (`*`) to replace 0 or more characters.
              Only one wildcard can be used per origin.
          - key: "allowedMethods"
            type: "[]string"
            description: |
              A list of methods the clients are allowed to use with cross-domain
              requests.
          - key: "allowedHeaders"
            type: "[]string"
            description: |
              A list of non simple headers the client is allowed to use with
              cross-domain requests.
          - key: "allowCredentials"
            type: "boolean"
            description: |
              Indicates whether the request can include user credentials like
              cookies, HTTP authentication or client side SSL certificates.
          - key: "exposedHeaders"
            type: "[]string"
            description: |
              Indicates which headers are safe to expose to the API of a CORS API
              specification.
          - key: "maxAge"
            type: "integer"
            description: |
              Indicates how long (in seconds) the results of a preflight request
              can be cached. `0` which stands for no max age.
        example:
          allowedOrigins: ["http://*.domain.com"]
          allowedMethods: ["POST", "PUT"]
          allowedHeaders: []
          allowCredentials: true
          exposedHeaders: []
          maxAge: 0
        defaults:
          allowedOrigins: ["*"]
          allowedMethods: ["GET", "POST"]
          allowedHeaders: []
          allowCredentials: false
          exposedHeaders: []
          maxAge: 0
        description: |
          Optional configuration for applying Cross Origin Resource Sharing to the
          gateway.

resources:
  - parent: "Getting started"
    title: "How Blacksmith works"
    link: "/blacksmith/start/onboarding/how"
    icon: "cheer"
  - parent: "Getting started"
    title: "Running the server"
    link: "/blacksmith/start/firstapp/server"
    icon: "bolt"
  - parent: "Getting started"
    title: "Running the workers"
    link: "/blacksmith/start/firstapp/workers"
    icon: "bolt"

  - parent: "Getting started"
    title: "Setting up the gateway"
    link: "/blacksmith/start/discover/gateway"
    icon: "magnifyWithPlus"

---

### Blacksmith services

Blacksmith is composed of three kind of services:
- The **server** is the orchestration service. The server itself does not execute
  application code, but instead tracks the state of it using queues, timers, and
  a database. It is highly scalable and multi-tenant, capable of running millions
  of tasks simultaneously. It employs various sharding techniques to ensure
  scalability internally. And it is capable of scaling horizontally by running
  multiple instances on multiple hosts.
- The **workers** are services that executes the code against integrations. There
  are two types of workers:
  - The **loader** is in charge of Loading data asynchronously into integrations.
    This worker is necessary if you leverage Blacksmith for ETL.
  - The **operator** is in charge of running operations, queries, and migrations
    synchronously against SQL integrations and leverages a remote *mutex* for
    handling access locks. This worker is necessary if you leverage Blacksmith
    for SQL operations and migrations.
- The **gateway** is a YAML / JSON-only application to Extract data from various
  sources and Load it into integrations. The gateway is very handy for capturing
  events across sources without knowing any programming language.
