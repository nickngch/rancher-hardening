# Rancher Hardening Benchmark Scanning Script

## rancher-harden
This script is to performance hardening benchmark scanning against Rancher v2.3.x  (k8s v1.15) cluster based on https://rancher.com/docs/rancher/v2.x/en/security/hardening-2.3/

## Pre-requisites:
- jq
- grep
- awk
- kubectl

## Usage
1. git clone https://github.com/nickngch/rancher-hardening.git

### For Master Node
- sudo bash ./master.sh 2.3

### For Worker Node
- sudo bash ./worker.sh 2.3

#### Modified from https://github.com/neuvector/kubernetes-cis-benchmark
