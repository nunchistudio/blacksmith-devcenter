---

dotenvdotenv:
  schema:
    - key: "AZURE_STORAGE_ACCOUNT"
      type: "string"
      example: "https://myaccount.blob.core.windows.net"
      required: true
      description: |
        The Azure Storage account to use.

    - key: "AZURE_STORAGE_KEY"
      type: "string"
      example: ""
      description: |
        The Azure Storage key to use. Only one of `AZURE_STORAGE_KEY`
        and `AZURE_STORAGE_SAS_TOKEN` is required.

    - key: "AZURE_STORAGE_SAS_TOKEN"
      type: "string"
      example: ""
      description: |
        The Azure Storage token to use. Only one of `AZURE_STORAGE_KEY`
        and `AZURE_STORAGE_SAS_TOKEN` is required.

integrations:
  values:
    connection: "<container>"

---

Open the .env files to see how Azure credentials are set in the application.
