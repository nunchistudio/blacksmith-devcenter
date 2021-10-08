---

dotenvdotenv:
  schema:
    - key: "RABBIT_SERVER_URL"
      type: "string"
      example: "amqp://guest:guest@127.0.0.1:5672/"
      defaults: "amqp://guest:guest@127.0.0.1:5672/"
      required: true
      description: |
        The RabbitMQ server URL to dial for pub / sub.

integrations:
  values:
    connection: "<exchange>"

---

Open the .env files to see how RabbitMQ credentials are set in the application.
