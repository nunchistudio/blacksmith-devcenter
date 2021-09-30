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

The server only needs configuration for following production best-practices. We
invite to [follow the dedicated guides to learn more](/blacksmith/production).
