#!/usr/bin/env bash

if [ "$1" = "-h" ]; then
        echo "Usage: start-shield-ca.sh <genkey> where genkey should be set to true only the first time and empty thereafter"
	exit 0
fi

######## Update these values #########

# Get orgid from UI under settings
ORG_ID=<organization id>

# Examples: kubernetes, marathon, docker, none
CM=<cm type>

# If k8s, this needs to match the cluster of interest from kubeconfig
CNAME=<cluster name>

# Using default as prod
BANYAN_URL=https://net.banyanops.com:443/api_server_host_v1

# If using marathon, set to true: marathon nodes use a custom version of openssl that seems to be causing problems
TLSNOVERIFY=<true/false>

# Examples: stage, prod, test
GROUPTYPE=<type of deployment>

######## UNTIL HERE #########


# Deploy Intermediate CA
./deploy-ca.sh $1

# wait for things to stabilize
sleep 5

# Deploy shield
./deploy-shield.sh ${ORG_ID} ${CM} ${CNAME} ${BANYAN_URL} ${TLSNOVERIFY} ${GROUPTYPE}
