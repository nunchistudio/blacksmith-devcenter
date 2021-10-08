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

      - key: "prefix"
        type: "string"
        example: "/mysource"
        description: |
          Endpoint prefix without the trailing slash that will prefix all the
          HTTP endpoints registered in this source.

      - key: "policies"
        type: "object"
        items:
          - key: "extraction"
            type: "object"
            items:
              - key: "timeout"
                type: "integer"
        example:
          extraction:
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
          The method to use for accepting HTTP requests.

      - key: "endpoint"
        type: "string"
        example: "/endpoint"
        required: true
        description: |
          The endpoint to use for accepting HTTP requests. It is prefixed by
          the prefix defined in its parent source, if applicable.

    mapping:
      values:
        user_id: "body.data.user.id"
        subscription_id: "body.data.subscriptions[0].id"
        sku: "body.data.subscriptions[0].sku"
        quantity: "body.data.subscriptions[0].quantity"

---

### Extraction from HTTP webhook

A trigger of mode HTTP endpoint (`http_endpoint`) registers a HTTP route in the
gateway. This way, it can be requested by clients when desired, such as
**E**xtracting data from a webhook.

Once **E**xtracted (in other words, once a HTTP request was made against the
defined trigger), the trigger exposes:
- `status`: The status of the Extraction process. It is one of `succeeded`,
  `failed`.
- `statusCode`: The HTTP status code returned by the trigger. It is one of `202`
  (in case of `status` is `succeeded`), `400` or `500` (in case of `status` is
  `failed`).
- `method`: The HTTP method used by the client to make the request.
  Example: `POST`.
- `endpoint`: The path requested by the client.
  Example: `/endpoint`.
- `query`: The HTTP query params passed by the client when making the request.
  Example:
  ```json
  {
    "search": [
      "mysearchqueryparam"
    ]
  }
  ```
- `params`: The key / value of the route params. If an endpoint contains params,
  such as `/users/:user` and the path requested is `/users/johndoe`, then `params`
  would be:
  ```json
  {
    "user": "johndoe"
  }
  ```
- `contentLength`: The content length of the request's body.
  Example: `192`.
- `headers`: The headers of the request passed by the client. Example:
  ```json
  {
    "Content-Type": [
      "application/json"
    ]
  }
  ```
- `body`: The JSON marshaled body of the request passed by the client. Example:
  ```json
  {
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
  ```

The value of each of the keys defined above can be passed to integrations using
the `mapping` object.
