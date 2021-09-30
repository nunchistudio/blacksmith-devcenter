FROM golang:1.17.1-buster

# Retrieve the target OS/Arch from buildx.
ARG TARGETOS
ARG TARGETARCH

# Set the default Blacksmith variables if not set.
ARG BLACKSMITH_VERSION=1.0.0-rc3
ARG BLACKSMITH_EDITION=standard

# Set the remote URL and the archive name to download.
ARG REMOTE=https://github.com/nunchistudio/blacksmith-devcenter/releases/download/v${BLACKSMITH_VERSION}
ARG ARCHIVE=blacksmith-${BLACKSMITH_EDITION}_${BLACKSMITH_VERSION}_${TARGETOS}_${TARGETARCH}.zip

# Update registry and install unzip.
RUN apt-get update -y; \
  apt-get install unzip -y

# Download, unzip, and remove the archive.
RUN wget -nv "${REMOTE}/${ARCHIVE}"; \
  unzip -j -d /usr/local/bin ${ARCHIVE}; \
  rm ${ARCHIVE}
