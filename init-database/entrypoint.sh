#!/bin/bash

echo "Install the schema"
curl -s -X POST \
     ${DGRAPH_SERVER}/admin/schema \
     -H 'Content-Type: application/graphql' \
     --data-binary '@/data/schema/schema.graphql'

echo -e "\nInsert Constants"
curl -s -X POST \
     ${DGRAPH_SERVER}/graphql \
     -H 'Content-Type: application/graphql' \
     --data-binary '@/data/schema/constants.graphql'