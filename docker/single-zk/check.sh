#!/usr/bin/env bash

  echo "ZooKeeper instance listening on port 2181:"
  docker run --net=host --rm mbe1224/zookeeper bash -c "echo ruok | nc localhost 2181"
  echo ""
  docker run --net=host --rm mbe1224/zookeeper bash -c "echo stat | nc localhost 2181 | grep Mode"
  echo "---------------------------------------------"
