#!/usr/bin/env bash

for i in 12181 22181 32181; do
  echo "ZooKeeper instance listening on port $i:"
  docker run --net=host --rm mbe1224/zookeeper bash -c "echo ruok | nc localhost $i"
  echo ""
  docker run --net=host --rm mbe1224/zookeeper bash -c "echo stat | nc localhost $i | grep Mode"
  echo "---------------------------------------------"
done
