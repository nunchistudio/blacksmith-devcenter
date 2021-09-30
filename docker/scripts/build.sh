#!/bin/bash

for distribution in "alpine" "bullseye" "buster"; do
	for edition in "standard" "enterprise"; do
    if [[ $distribution == "bullseye" ]] && [[ $edition == "standard" ]]; then
      docker buildx build --no-cache \
        --file ./$distribution/Dockerfile \
        --platform linux/amd64,linux/arm64 \
        --build-arg BLACKSMITH_EDITION=$edition \
        --build-arg BLACKSMITH_VERSION=${BLACKSMITH_VERSION} \
        --tag nunchistudio/blacksmith \
        --tag nunchistudio/blacksmith:latest \
        --tag nunchistudio/blacksmith:latest-$distribution \
        --tag nunchistudio/blacksmith:${BLACKSMITH_VERSION} \
        --tag nunchistudio/blacksmith:${BLACKSMITH_VERSION}-$distribution \
        --tag nunchistudio/blacksmith-standard \
        --tag nunchistudio/blacksmith-standard:latest \
        --tag nunchistudio/blacksmith-standard:latest-$distribution \
        --tag nunchistudio/blacksmith-standard:${BLACKSMITH_VERSION} \
        --tag nunchistudio/blacksmith-standard:${BLACKSMITH_VERSION}-$distribution \
        --push . ; \
    elif [[ $distribution != "bullseye" ]] && [[ $edition == "standard" ]]; then
      docker buildx build --no-cache \
        --file ./$distribution/Dockerfile \
        --platform linux/amd64,linux/arm64 \
        --build-arg BLACKSMITH_EDITION=$edition \
        --build-arg BLACKSMITH_VERSION=${BLACKSMITH_VERSION} \
        --tag nunchistudio/blacksmith:latest-$distribution \
        --tag nunchistudio/blacksmith:${BLACKSMITH_VERSION} \
        --tag nunchistudio/blacksmith:${BLACKSMITH_VERSION}-$distribution \
        --tag nunchistudio/blacksmith-standard:latest-$distribution \
        --tag nunchistudio/blacksmith-standard:${BLACKSMITH_VERSION} \
        --tag nunchistudio/blacksmith-standard:${BLACKSMITH_VERSION}-$distribution \
        . ; \
    else
      docker buildx build --no-cache \
        --file ./$distribution/Dockerfile \
        --platform linux/amd64,linux/arm64 \
        --build-arg BLACKSMITH_EDITION=$edition \
        --build-arg BLACKSMITH_VERSION=${BLACKSMITH_VERSION} \
        --tag nunchistudio/blacksmith-$edition:latest-$distribution \
        --tag nunchistudio/blacksmith-$edition:${BLACKSMITH_VERSION}-$distribution \
        . ; \
    fi
	done
done
