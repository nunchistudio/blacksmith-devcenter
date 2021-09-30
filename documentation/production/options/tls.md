---
title: TLS everywhere
enterprise: false
---

# TLS everywhere

Blacksmith supports mutual TLS (mTLS) as a way of encrypting network traffic
between the services of a cluster and also between application processes and a
cluster. Self-signed or properly minted certificates can be used for mTLS.

All TLS configuration happen in `BLACKSMITH_DIR/services.BLACKSMITH_EXT`.

**Notes:**
- If TLS is set on the `server`, all clients (`cli`, `gateway`) and `workers` must
  set TLS. The server requires other services to authenticate with a certificate
  when connecting, otherwise known as mutual TLS. This is designed this way to
  avoid mistakes and ensure trust as much as possible.
- As of now, only the `local` driver is supported for leveraging TLS. It allows
  to load files from directory. If this is highly demanded, we may build other
  drivers such as `vault`.

## TLS for the server

To use TLS on Blacksmith, the first thing to do is to configure the `server`:
```yml
server:
  tls:
    driver: "local"
    options:
      server_name: "localhost"
      cert_file: "./tls/cluster.pem"
      key_file: "./tls/cluster.key"
      root_ca_files:
        - "./tls/ca.cert"
      client_ca_files:
        - "./tls/ca.cert"
```

Where `options` are:
- `server_name`: The *DNS SubjectName* contained in the presented server
  certificate. This is needed as Blacksmith uses IP to IP communication. You can
  avoid specifying this only if your server certificates contain the appropriate
  *IP Subject Alternative Names*.
- `cert_file`: The path to the file containing the PEM-encoded public key of the
  certificate to use.
- `key_file`: The path to the file containing the PEM-encoded private key of the
  certificate to use.
- `root_ca_files`: List of paths to files containing the PEM-encoded public
  key of the Certificate Authorities you wish to trust for server authentication.
- `client_ca_files`: List of paths to files containing the PEM-encoded public
  key of the Certificate Authorities you wish to trust for client authentication.

## TLS for clients and workers

Once the `server` is configured, you must configure the clients (`cli`, `gateway`)
and `workers`:
```yml
cli:
  tls:
    driver: "local"
    options:
      server_name: "localhost"
      cert_file: "./tls/cluster.pem"
      key_file: "./tls/cluster.key"
      ca_file: "./tls/ca.cert"

workers:
  loader:
    tls:
      driver: "local"
      options:
        server_name: "localhost"
        cert_file: "./tls/cluster.pem"
        key_file: "./tls/cluster.key"
        ca_file: "./tls/ca.cert"
  operator:
    tls:
      driver: "local"
      options:
        server_name: "localhost"
        cert_file: "./tls/cluster.pem"
        key_file: "./tls/cluster.key"
        ca_file: "./tls/ca.cert"

gateway:
  tls:
    driver: "local"
    options:
      server_name: "localhost"
      cert_file: "./tls/client.pem"
      key_file: "./tls/client.key"
      ca_file: "./tls/ca.cert"
```

For clients and workers, `options` are:
- `server_name`: The *DNS SubjectName* contained in the presented server
  certificate. This is needed as Blacksmith uses IP to IP communication. You can
  avoid specifying this only if your server certificates contain the appropriate
  *IP Subject Alternative Names*.
- `cert_file`: The path to the file containing the PEM-encoded public key of the
  certificate to use.
- `key_file`: The path to the file containing the PEM-encoded private key of the
  certificate to use.
- `ca_file`: The path to the file containing the PEM-encoded public key of the
  Certificate Authorities you wish to trust for authentication. The file must be
  known by the server in order to trust it. In other words, the CA file used must
  also be set in `client_ca_files` of the `server`.

## TLS for databases

In addition of using TLS across Blacksmith services, you might want to use it with
your databases as well. Here is an example where TLS is set for both `store` and
`visibility` databases:
```yml
server:
  databases:
    store:
      tls:
        driver: "local"
        options:
          server_name: "localhost"
          cert_file: "./tls/cluster.pem"
          key_file: "./tls/cluster.key"
          ca_file: "./tls/ca.cert"
    visibility:
      tls:
        driver: "local"
        options:
          server_name: "localhost"
          cert_file: "./tls/cluster.pem"
          key_file: "./tls/cluster.key"
          ca_file: "./tls/ca.cert"
```
