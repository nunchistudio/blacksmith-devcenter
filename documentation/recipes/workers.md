---

dotenvdotenv:
  schema:
    - key: "BLACKSMITH_NAMESPACE"
      type: "string"
      example: "default"
      defaults: "default"
      description: |
        The Blacksmith namespace to connect to.

    - key: "BLACKSMITH_SERVER_URL"
      type: "string"
      example: "localhost:7200"
      defaults: "localhost:7200"
      description: |
        The Blacksmith server URL to connect to shall vary between
        environments.

services:
  workers:
    schema: []

---

Workers only needs configuration for following production best-practices. We
invite to [follow the dedicated guides to learn more](/blacksmith/production).
