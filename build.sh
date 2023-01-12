#!/bin/bash

export eTAG="latest-dev"
echo $1
if [ $1 ] ; then
  eTAG=$1
fi

echo Building tetris/faas-cli:$eTAG

docker build --build-arg -t tetris/faas-cli:$eTAG .

if [ $? == 0 ] ; then

  docker create --name faas-cli tetris/faas-cli:$eTAG && \
  docker cp faas-cli:/usr/bin/faas-cli . && \
  mv ./faas-cli faasdev-cli
  docker rm -f faas-cli

else
 exit 1
fi
