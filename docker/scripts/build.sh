#!/bin/bash

for distribution in "alpine" "bullseye" "buster"; do
	for edition in "standard" "enterprise"; do
		for os in "linux"; do
			for arch in "amd64" "arm64"; do
        if [ $distribution == "bullseye" ] && [ $edition == "standard" ]; then
          docker buildx build --no-cache \
						--file ./$distribution/Dockerfile \
						--platform $os/$arch \
						--build-arg BLACKSMITH_EDITION=$edition \
						--build-arg BLACKSMITH_VERSION=${BLACKSMITH_VERSION} \
						--build-arg GO_OS=$os \
						--build-arg GO_ARCH=$arch \
						--tag nunchistudio/blacksmith:latest \
						--tag nunchistudio/blacksmith:${BLACKSMITH_VERSION} \
						--tag nunchistudio/blacksmith-standard:latest \
						--tag nunchistudio/blacksmith-standard:${BLACKSMITH_VERSION} \
						. ; \
				else
					docker buildx build --no-cache \
						--file ./$distribution/Dockerfile \
						--platform $os/$arch \
						--build-arg BLACKSMITH_EDITION=$edition \
						--build-arg BLACKSMITH_VERSION=${BLACKSMITH_VERSION} \
						--build-arg GO_OS=$os \
						--build-arg GO_ARCH=$arch \
						--tag nunchistudio/blacksmith-$edition:latest-$distribution \
						--tag nunchistudio/blacksmith-$edition:${BLACKSMITH_VERSION}-$distribution \
						. ; \
				fi
			done
		done
	done
done
