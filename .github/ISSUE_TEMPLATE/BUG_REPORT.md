name: Bug report
description: |
  You are experiencing an issue with Blacksmith that is different than the
  documented or expected behavior

body:
  - type: dropdown
    attributes:
      label: What version of Blacksmith are you using?
      options:
        - v1.0.x
    validations:
      required: true
  - type: dropdown
    attributes:
      label: What Blacksmith Edition are you using?
      options:
        - Standard
        - Enterprise
    validations:
      required: true
  - type: dropdown
    attributes:
      label: What OS are you using?
      options:
        - Linux
        - macOS
        - Windows
    validations:
      required: true
  - type: markdown
    attributes:
      label: Unexpected behavior
      value: Please write a clear and concise description of what the bug is.
    validations:
      required: true
  - type: markdown
    attributes:
      label: Steps to reproduce
      value: Please indicate the steps needed to reproduce the previously described behavior.
  - type: markdown
    attributes:
      label: Expected behavior
      value: Please describe the behavior you were expected.
  - type: textarea
    attributes:
      label: Logs
      value: You can provide logs (if applicable) so we can better adress your issue.
