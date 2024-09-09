#!/usr/bin/env bash

source .env

oc new-project $NAMESPACE || oc project $NAMESPACE

# Formatting of private key needs to be correct. Creating a secret from the
# file is easiest.
oc create secret generic gh-app-private-key --from-file=GH_APP_PRIVATE_KEY=gh.private-key.pem 

oc process -f manifests/template.yaml \
-l app=${RHDH_NAME}-backstage \
-p NAMESPACE="$NAMESPACE" \
-p RHDH_NAME="$RHDH_NAME" \
-p CLUSTER_DOMAIN="$CLUSTER_DOMAIN" \
-p GH_APP_APP_ID="$GH_APP_APP_ID" \
-p GH_APP_CLIENT_ID="$GH_APP_CLIENT_ID" \
-p GH_APP_CLIENT_SECRET="$GH_APP_CLIENT_SECRET" | oc create -f -

# Get the keycloak secret
# oc get secret keycloak-initial-admin -n $NAMESPACE -o template --template='{{.data
# .password}}' | base64 -d ; echo
