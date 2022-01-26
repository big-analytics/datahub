#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
IMAGE=mnexus001:8082/acryldata/datahub-upgrade:head
cd $DIR && sudo docker pull ${IMAGE} && sudo docker run --env-file ./env/docker.env --network="datahub_network" ${IMAGE} "$@"
