---

dotenvdotenv:
  schema:
    - key: "BLACKSMITH_STORE_URL"
      type: "string"
      example: "postgres://<user>:<password>@<host>:<port>"
      defaults: "postgres://<user>:<password>@<host>:<port>"
      required: true
      description: |
        The PostgreSQL URL for the Blacksmith store database.

    - key: "BLACKSMITH_VISIBILITY_URL"
      type: "string"
      example: "postgres://<user>:<password>@<host>:<port>"
      defaults: "postgres://<user>:<password>@<host>:<port>"
      required: true
      description: |
        The PostgreSQL URL for the Blacksmith visibility database.

services:
  server:
    schema:
      - key: "host"
        type: "string"
        example: "localhost"
        defaults: "localhost"
        required: false
        description: |
          The host (IP / DNS) to bind the services to.

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

---

The server doesn't need a lot of configuration. As of now, we voluntarily expose
no configuration but the `host` to bind. Our goal is to simplify networking,
scalability, and security as much as possible so end-users don't need to worry
about those. *This may change in a near future depending on the feedback received.*

The server is a [Temporal server](https://docs.temporal.io/docs/server/introduction)
and exposes ports as follow:
- `pprof`: `7100`
- service `frontend`: `7200` for gRPC, `7300` for membership
- service `matching`: `7201` for gRPC, `7301` for membership
- service `history`: `7202` for gRPC, `7302` for membership
- service `worker`: `7203` for gRPC, `7303` for membership
