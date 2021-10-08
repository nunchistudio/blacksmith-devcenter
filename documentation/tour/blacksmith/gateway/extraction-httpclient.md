---

gateway:
  source:
    schema:
      - key: "name"
        type: "string"
        example: "my-source"
        required: true
        description: |
          The name for the source that will be used across services.

      - key: "base_url"
        type: "string"
        example: "https://api.example.com"
        required: true
        description: |
          HTTP base URL without the trailing slash that will prefix all the
          HTTP endpoints registered in this source.

      - key: "method"
        type: "string"
        example: "POST"
        required: true
        description: |
          The default method to use for making the HTTP request.

      - key: "headers"
        type: "map[string][]string"
        example:
          Content-Type:
            - "application/json"
        description: |
          The default HTTP headers to use for making the request.

      - key: "policies"
        type: "object"
        items:
          - key: "extraction"
            type: "object"
            items:
              - key: "cron"
                type: "string"
              - key: "timeout"
                type: "integer"
        example:
          extraction:
            cron: "*/2 * * * *"
            timeout: 15
        required: true
        description: |
          The policy to apply by default for all the triggers registered in this
          source.

  trigger:
    schema:
      - key: "name"
        type: "string"
        example: "my-trigger"
        required: true
        description: |
          The name for the trigger that will be used across services.

      - key: "method"
        type: "string"
        example: "POST"
        required: true
        description: |
          The method to use for making the HTTP request.

      - key: "endpoint"
        type: "string"
        example: "/endpoint"
        required: true
        description: |
          The HTTP route to request. It will be prefixed by the base URL set in
          its parent source.

      - key: "query"
        type: "map[string][]string"
        example:
          search:
            - "mysearchqueryparam"
        description: |
          The HTTP query params to add to the request. They are added to the full
          URL after the base URL and endpoint.

      - key: "headers"
        type: "map[string][]string"
        example:
          Content-Type:
            - "application/json"
        description: |
          The HTTP headers to add to the request.

      - key: "body"
        type: "map[string]interface{}"
        description: |
          The JSON body of the HTTP request.

      - key: "policies"
        type: "object"
        items:
          - key: "extraction"
            type: "object"
            items:
              - key: "cron"
                type: "string"
        example:
          extraction:
            cron: "*/2 * * * *"
        required: true
        description: |
          The policy to apply for this trigger. When set, it will override the
          value of the parent source if applicable.

    mapping:
      values:
        user_id: "body.data.user.id"
        subscription_id: "body.data.subscriptions[0].id"
        sku: "body.data.subscriptions[0].sku"
        quantity: "body.data.subscriptions[0].quantity"

---

### Extraction from HTTP request

A trigger of mode HTTP client (`http_client`) **E**xtracts data from a HTTP API
on a CRON schedule. It is done by making a request to the service using the details
passed in the source's `defaults.http_client` config and the `config.http_client`
of the said trigger.

Once **E**xtracted (in other words, once the HTTP request was made against the
service), the trigger exposes:
- `status`: The status of the Extraction process. It is one of `succeeded`,
  `failed`.
- `statusCode`: The HTTP status code returned by the service. Example: `201`.
- `method`: The HTTP method used to make the request. It is the one defined in
  trigger's config and is here for convenience.
  Example: `POST`.
- `url`: The complete HTTP URL, including the base URL of the source, as well as
  the trigger's endpoint and query params.
  Example: `https://api.example.com/endpoint?search=mysearchqueryparam`.
- `contentLength`: The content length of the response returned by the service.
  Example: `64`.
- `headers`: The headers of the response returned by the service. Example:
  ```json
  {
    "Content-Type": [
      "application/json"
    ],
    "Vary": [
      "Origin"
    ]
  }
  ```
- `body`: The JSON marshaled body returned by the service. Example:
  ```json
  {
    "message": "Successful",
    "error": null,
    "data": {
      "user": {
        "id": "4d6c34df-250e-4fb5-bfb2-27e8d4e9becf",
        "first_name": "John",
        "last_name": "Doe",
        "username": "johndoe",
        "address": {
          "city": "Austin"
        }
      },
      "subscriptions": [
        {
          "id": "206b0e36-0d24-43f7-9e9c-c1fdf2cd4780",
          "name": "Enterprise Edition",
          "sku": "BLACKSMITH_EE",
          "quantity": 1.0
        }
      ]
    }
  }
  ```

The value of each of the keys defined above can be passed to integrations using
the `mapping` object.
