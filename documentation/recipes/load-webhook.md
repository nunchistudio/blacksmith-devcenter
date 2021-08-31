---

gateway:
  values:
    name: "my-webhook"

  schema:
    - key: "method"
      type: "string"
      example: "POST"
      description: |
        The HTTP method to use for making the request. If not set, the detault
        method passed in the source will be applied.

    - key: "endpoint"
      type: "string"
      required: true
      example: "/endpoint"
      description: |
        The path to the HTTP resource to consume.

    - key: "query"
      type: "map[string][]string"
      example:
        search:
          - "mysearchqueryparam"
      description: |
        The HTTP query params to apply to the request. They are added to the full
        URL after the base URL and endpoint.

    - key: "headers"
      type: "map[string][]string"
      example:
        Content-Type:
          - "application/json"
      description: |
        The HTTP headers to apply to the request.

---

Given the example defined above, the `options` and `mapping` defined in the example
on the right side, the `curl` representation of the request would be:
```bash
$ curl --request 'POST' \
  --url '<integration-base-url>/endpoint?search=mysearchqueryparam' \
  --header 'Content-Type: application/json' \
  --data '{
    "user_id": "4d6c34df-250e-4fb5-bfb2-27e8d4e9becf",
    "subscription_id": "206b0e36-0d24-43f7-9e9c-c1fdf2cd4780",
    "sku": "BLACKSMITH_EE",
    "quantity": 1.0
  }'
```
