---

dotenvdotenv:
  schema:
    - key: "NATS_SERVER_URL"
      type: "string"
      example: "nats://127.0.0.1:4222"
      defaults: "nats://127.0.0.1:4222"
      required: true
      description: |
        The NATS server URL to dial for pub / sub.

gateway:
  trigger:
    values:
      topic: "<subject>"
      queue: "<queue>"

---
