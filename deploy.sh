#!/bin/bash
SNOWFLAKE_PASSWORD=""
CONTAINER_NAME=aci-graviton-$RANDOM
az container create \
    --name $CONTAINER_NAME \
    --resource-group "rg-flaskapi-dev" \
    --image python:3.6 \
    --vnet "vnet-flaskapi-dev" \
    --vnet-address-prefix "10.0.0.0/16" \
    --subnet "default" \
    --subnet-address-prefix "10.0.1.0/24" \
    --environment-variables SNOWFLAKE_PASSWORD=$SNOWFLAKE_PASSWORD \
    --query ipAddress.fqdn \
    --ports 80 \
    --gitrepo-url https://github.com/dg-hub/graviton.git \
    --gitrepo-mount-path /mnt/graviton \
    --command-line "/bin/sh -c '/mnt/graviton/run.sh'" \
    --restart-policy Never \
    --cpu 1 \
    --memory 1

#    --dns-name-label $CONTAINER_NAME \
#    --subnet-address-prefix 10.0.0.0/24 \
