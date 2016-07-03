#!/bin/bash

BRANCH=$(echo $GIT_BRANCH | cut -d "/" -f 2)
IMAGE="$JOB_NAME-$BRANCH"

# dear future self, ensure that you have built this
# and pushed it to quay first.
docker pull quay.io/kingsreach/slackin

OUT=$?
if [ $OUT -eq 0 ]; then
    docker kill $IMAGE 2>/dev/null || true
    docker rm -f $IMAGE 2>/dev/null || true
    docker run \
        --detached \
        --restart=on-failure:5 \
        --name $IMAGE \
        --env HTTP_PORT=$HTTP_PORT \
        --publish $HTTP_PORT:$HTTP_PORT \
        quay.io/kingsreach/slackin \
          ./bin/slackin --port $HTTP_PORT $SLACK_TEAM $SLACK_TOKEN
else
    exit $OUT
fi
