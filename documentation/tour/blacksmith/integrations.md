---

policies:
  load:
    schema:
      - key: "timeout"
        type: "integer"
        example: 15
        required: true
        description: |
          The maximum time (in seconds) of a single data Load execution attempt.
          This timeout should be as short as the longest possible execution of
          the Loading.

      - key: "initialInterval"
        type: "integer"
        example: 30
        required: true
        description: |
          The backoff interval (in seconds) for the first retry. If
          `backoffCoefficient` is `1.0` then it is used for all retries.

      - key: "backoffCoefficient"
        type: "float"
        example: 1.75
        required: true
        description: |
          The coefficient used to calculate the next retry backoff interval. The
          next retry interval is previous interval multiplied by this coefficient.
          Must be `1.0` or larger.

      - key: "maximumInterval"
        type: "integer"
        example: 15
        description: |
          The maximum backoff interval between retries. Exponential backoff
          leads to interval increase. This value is the cap of the interval.
          Default is `initialInterval * 100`.

      - key: "maximumAttempts"
        type: "integer"
        example: 60
        required: true
        description: |
          The maximum number of attempts of retries. When exceeded the retries
          stop even if not expired yet.

resources:
  - parent: "Getting started"
    title: "How Blacksmith works"
    link: "/blacksmith/start/onboarding/how"
    icon: "cheer"
  - parent: "Getting started"
    title: "Your first integration"
    link: "/blacksmith/start/discover/integration"
    icon: "magnifyWithPlus"

---

