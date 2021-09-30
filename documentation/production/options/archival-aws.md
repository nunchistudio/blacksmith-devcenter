---
title: Remote archival with AWS S3
enterprise: false
---

# Remote archival with AWS S3

To leverage AWS S3 for archival you need to configure the `server.archival`
object in `BLACKSMITH_DIR/services.BLACKSMITH_EXT`:
```yml
server:
  archival:
    driver: aws/s3
    connection: mybucket
```

The driver follows the AWS SDKs conventions and best practices, using reserved
environment variables for authentication:
```bash
AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
AWS_REGION=us-east-2
```
