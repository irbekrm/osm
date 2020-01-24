#!/bin/bash

set -aueo pipefail

source .env

kubectl apply -f https://raw.githubusercontent.com/deislabs/smi-sdk-go/master/crds/split.yaml

kubectl create namespace "$K8S_NAMESPACE" || true

VM_NAME="myVM"

kubectl apply -f - <<EOF
apiVersion: split.smi-spec.io/v1alpha2
kind: TrafficSplit
metadata:
  name: bookstore.mesh
  namespace: "$K8S_NAMESPACE"
spec:
  service: bookstore.mesh
  backends:

  - service: bookstore-1
    weight: 100


EOF
