#!/bin/bash -e

if [[ $# -ne 1 ]]; then
  echo "error: please specify the commit to use"
  echo "usage: $0 <commit>"
  exit 1
fi

COMMIT=$1

cmd() {
  echo "+ $*"
  "$@"
}

# Credentials should come from environment variables, never hardcoded
: "${DOCKER_USERNAME:?DOCKER_USERNAME environment variable is required}"
: "${DOCKER_PASSWORD:?DOCKER_PASSWORD environment variable is required}"

BUILD_DATE=$(printf '%(%Y-%m-%d)T' -1)
OUTPUT_IMAGE_REPO="${DOCKER_USERNAME}/kynema-snapshot"
DATED_IMAGE="${OUTPUT_IMAGE_REPO}:${BUILD_DATE}"
LATEST_IMAGE="${OUTPUT_IMAGE_REPO}:latest"

# Log in before doing anything that requires registry access
docker login --username "${DOCKER_USERNAME}" --password "${DOCKER_PASSWORD}"

cmd time docker build \
  --no-cache \
  --build-arg COMMIT="${COMMIT}" \
  --build-arg BUILD_DATE="${BUILD_DATE}" \
  -t "${DATED_IMAGE}" \
  .

cmd docker tag "${DATED_IMAGE}" "${LATEST_IMAGE}"
cmd docker push "${DATED_IMAGE}"
cmd docker push "${LATEST_IMAGE}"

docker logout
