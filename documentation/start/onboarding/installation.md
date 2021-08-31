---
title: Installation
enterprise: false
---

# Installation

Blacksmith is available as a single binary for several operating systems, as well
as Docker images for running in containers if your environment requires it. You
can download it from the dedicated [downloads page](/blacksmith/downloads).

After downloading Blacksmith, you need to unzip the package in an appropriate
directory. Make sure that the `blacksmith` binary is available on your `PATH`,
before continuing.

You can check the locations available on your path by running:
```bash
$ echo $PATH
```

The output is a list of locations separated by colons. You can make Blacksmith
available by moving the binary to one of the listed locations, or by adding
Blacksmith's location to your `PATH`.

To verify Blacksmith was installed correctly, try the `blacksmith` command:
```bash
$ blacksmith version

Blacksmith Enterprise Edition v1.0.0
Built with Go v1.17 for darwin/amd64
```
