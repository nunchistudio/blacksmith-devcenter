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

The workers don't need configuration at all. Our goal is to simplify networking,
scalability, and security as much as possible so end-users don't need to worry
about those. *This may change in a near future depending on the feedback received.*
