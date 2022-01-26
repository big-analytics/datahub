#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

# Tear down and clean up all DataHub-related containers, volumes, and network
sudo /usr/local/bin/docker-compose -p datahub down -v
sudo /usr/local/bin/docker-compose rm -f -v

# Tear down ingestion container
(cd ingestion && sudo /usr/local/bin/docker-compose -p datahub down -v)
