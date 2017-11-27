#!/usr/bin/env bash

kubectl apply -f 20_kafka-configmap.yml
kubectl apply -f 21_kafka-poddisruptionbudget.yml
kubectl apply -f 22_kafka-service.yml
kubectl apply -f 23_kafka-statefulset.yml