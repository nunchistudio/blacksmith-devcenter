---

dotenvdotenv:
  schema:
    - key: "GOOGLE_APPLICATION_CREDENTIALS"
      type: "string"
      example: "/home/user/service-account-file.json"
      required: true
      description: |
        The path of the JSON file containing the Google account key.

---

Drivers related to Google Cloud follow the SDKs conventions and best practices,
leveraging reserved environment variables for some configuration.
