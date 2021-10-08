---

dotenvdotenv:
  schema:
    - key: "KAFKA_BROKERS"
      type: "string"
      example: "127.0.0.1:9092,127.0.0.1:9093,127.0.0.1:9094"
      required: true
      description: |
        The Kafka broker URLs to dial for pub / sub.

integrations:
  values:
    connection: "<topic>"

---

Open the .env files to see how Kafka credentials are set in the application.
