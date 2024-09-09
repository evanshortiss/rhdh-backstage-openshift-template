#!/usr/bin/env bash

set -e

source .env

oc project $NAMESPACE

oc process -f manifests/template.yaml \
-l app=${RHDH_NAME}-backstage \
-p NAMESPACE="$NAMESPACE" \
-p RHDH_NAME="$RHDH_NAME" \
-p CLUSTER_DOMAIN="$CLUSTER_DOMAIN" \
-p GH_APP_APP_ID="$GH_APP_APP_ID" \
-p GH_APP_CLIENT_ID="$GH_APP_CLIENT_ID" \
-p GH_APP_CLIENT_SECRET="$GH_APP_CLIENT_SECRET" | oc delete -f -

# Delete volumes to avoid issues with database migration locks on subsequent deployments
oc get pvc -o jsonpath='{.items[*].metadata.name}' | xargs oc delete pvc
oc get pv -o json | jq -r '.items[] | select(.status.phase == "Released" and (.spec.c
laimRef.name | test("backstage"))) | .metadata.name' | xargs -r -n 1 oc delete pv