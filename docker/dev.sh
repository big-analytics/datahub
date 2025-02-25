#!/bin/bash

MONITORING_COMPOSE=""
if [[ $MONITORING == true ]]; then
  MONITORING_COMPOSE="-f monitoring/docker-compose.monitoring.yml"
fi

CONSUMERS_COMPOSE=""
if [[ $SEPARATE_CONSUMERS == true ]]; then
  CONSUMERS_COMPOSE="-f docker-compose.consumers.yml -f docker-compose.consumers.dev.yml"
  if [[ $MONITORING == true ]]; then
    MONITORING_COMPOSE="-f monitoring/docker-compose.monitoring.yml -f monitoring/docker-compose.consumers.monitoring.yml"
  fi
fi

# Launches dev instances of DataHub images. See documentation for more details.
# YOU MUST BUILD VIA GRADLE BEFORE RUNNING THIS.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR && \
  COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 sudo /usr/local/bin/docker-compose \
    -f docker-compose.yml \
    -f docker-compose.override.yml \
    -f docker-compose.dev.yml \
    $CONSUMERS_COMPOSE $MONITORING_COMPOSE pull \
&& \
  COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 sudo /usr/local/bin/docker-compose -p datahub \
    -f docker-compose.yml \
    -f docker-compose.override.yml \
    -f docker-compose.dev.yml \
    $CONSUMERS_COMPOSE $MONITORING_COMPOSE up --build $@
