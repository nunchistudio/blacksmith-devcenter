FROM golang:1.17.1-alpine

# Set the default OS/Arch if not set.
ARG GO_OS=linux
ARG GO_ARCH=amd64

# Set the default Blacksmith variables if not set.
ARG BLACKSMITH_VERSION=1.0.0-rc3
ARG BLACKSMITH_EDITION=standard

# Set the remote URL and the archive name to download.
ARG REMOTE=https://github.com/nunchistudio/blacksmith-devcenter/releases/download/v${BLACKSMITH_VERSION}
ARG ARCHIVE=blacksmith-${BLACKSMITH_EDITION}_${BLACKSMITH_VERSION}_${GO_OS}_${GO_ARCH}.zip

# We need to install gcc (and its dependencies) in addition to unzip.
# This is needed because the Go image for Alpine deletes it after installation
# to keep the image as small as possible.
RUN apk add --no-cache \
  bash \
  musl-dev \
  gcc \
  unzip

# Download, unzip, and remove the archive.
RUN wget -nv "${REMOTE}/${ARCHIVE}"; \
  unzip -j -d /usr/local/bin ${ARCHIVE}; \
  rm ${ARCHIVE}
