#!/usr/bin/env bash

if [[ $# -eq 0 ]] ; then
    echo 'Must pass kubeconfig file as 1st arg'
    exit 0
fi

CONFIG_FILE=$1

for pod in `kubectl --kubeconfig $CONFIG_FILE --namespace=kafka get pods -l app=kfk -o json | jq -r '[.items[].metadata.name]' | jq .[] | tr -d '"'`; do
  echo "Kafka running on pod $pod knows about"
  kubectl --kubeconfig $CONFIG_FILE --namespace=kafka exec -it $pod -- bash -c "./opt/kafka/bin/kafka-broker-api-versions.sh --bootstrap-server localhost:9092 | grep kfk -c"
  echo "brokers"
  echo "--------------------------------------------"
done

for pod in `kubectl --kubeconfig $CONFIG_FILE  --namespace=kafka get pods -l app=zk -o json | jq -r '[.items[].metadata.name]' | jq .[] | tr -d '"'`; do
  echo "ZooKeeper running on pod $pod knows about the following Kafka brokers:"
  kubectl exec -it $pod -- bash -c "echo dump | nc localhost 2181 | grep broker"
  echo "---------------------------------------------"  
done