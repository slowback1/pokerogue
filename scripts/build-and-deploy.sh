#!/bin/bash
#check if TAG and PORT are set
if [ -z "$TAG" ]; then
    echo "Setting TAG to default value"
    TAG="pokerogue"
fi

if [ -z "$PORT" ]; then
    echo "Setting PORT to default value"
    PORT=7678
fi

docker stop $(docker ps -a -q --filter ancestor=$TAG --format="{{.ID}}") 2> /dev/null

cd $(git rev-parse --show-toplevel)

docker build -t $TAG .

docker run --restart=always -d -p $PORT:80 $TAG