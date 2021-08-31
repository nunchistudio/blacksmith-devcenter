---

dotenvdotenv:
  schema:
    - key: "AWS_ACCESS_KEY_ID"
      type: "string"
      example: "AKIAIOSFODNN7EXAMPLE"
      required: true
      description: |
        The AWS access key ID to use.

    - key: "AWS_SECRET_ACCESS_KEY"
      type: "string"
      example: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
      required: true
      description: |
        The AWS secret access key to use.

    - key: "AWS_REGION"
      type: "string"
      example: "us-east-2"
      description: |
        The AWS region to connect to.

---

Drivers related to Amazon Web Services follow the SDKs conventions and best
practices, leveraging reserved environment variables for some configuration.
