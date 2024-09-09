# Red Hat Developer Hub Deployment

A repository showing a minimal deployment for Red Hat Developer Hub using an
operator-based installation.

Currently it deploys a: 

. Keycloak and an associated Postgres for persistent storage.
. Realm into Keycloak to store users.
. Red Hat Developer Hub instance.


## Prerequisites

An OpenShift 4.16 cluster with the Red Hat Keycloak Operator and Red Hat
Developer Hub Operator installed.

## Usage

1. Create a _.env_ file based on the _.env.example_.
1. Create or use an existing GitHub Organization to populate the required values in the _.env_ file using a GitHub app, e.g at https://github.com/organizations/YOUR_ORG_NAME/settings/apps.
1. Generate and download a private key from the prior organizations app, and place it in a file named _gh.private-key.pem_ in the root of the repository.
1. Update the cluster domain in the _.env_ if you're not using OpenShift Local.

Use `oc login` to authenticate against your cluster and run the `deploy.sh` script.

After a few minutes Red Hat Developer Hub will be deployed and you can login as `user1` using the password `rhdh`.
