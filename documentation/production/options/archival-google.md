---
title: Remote archival with Google Cloud Storage
enterprise: false
---

# Remote archival with Google Cloud Storage

To leverage Google Cloud Storage for archival you need to configure the
`server.archival` object in `BLACKSMITH_DIR/services.BLACKSMITH_EXT`:
```yml
server:
  archival:
    driver: google/storage
    connection: mybucket
```

The driver follows the Google Cloud SDKs conventions and best practices, using
reserved environment variables for authentication:
```bash
GOOGLE_APPLICATION_CREDENTIALS=/home/user/service-account-file.json
```
