#!/bin/bash
ENVIRONMENT=$1

# AWS EXPORTS
export AWS_ACCESS_KEY_ID=$(pass cloud/aws.amazon.com/rootbytes/aws-access-key-id)
export AWS_SECRET_ACCESS_KEY=$(pass cloud/aws.amazon.com/rootbytes/aws-secret-access-key)


# RAW CHARTS
export NAMESPACES="frontend,backend,middleware,cert-manager"
export PASSWORD=$(pass devops/backend/secret-password)
export DOCKER_SECRET=$(pass cloud/aws.amazon.com/rootbytes/docker-secret)

# CERT MANAGER
export CERT_MANAGER_DNS_ZONES="rootbytes.net;demo.rootbytes.net"
export CERT_MANAGER_EMAIL="chess7th@pm.me"
export CERT_MANAGER_IAM_ROLE=$(pass cloud/aws.amazon.com/rootbytes/cert-manager-role)
export CERT_MANAGER_INGRESS_SHIM_DEFAULT_ISSUER_KIND="ClusterIssuer"
export CERT_MANAGER_INGRESS_SHIM_DEFAULT_ISSUER_NAME="letsencrypt-staging"
export CERT_MANAGER_INSTALLED=true
export CERT_MANAGER_REGION="eu-west-1"


# EXTERNAL DNS
export EXTERNAL_DNS_DOMAIN_FILTERS="plop.rootbytes.org;prod.rootbytes.org"
export EXTERNAL_DNS_PROVIDER="aws"


CHG_CTX=$(kubectl config use-context $ENVIRONMENT".rootbytes.net" 2>&1)

if [[ $? -ne 0 ]]; then
    echo "Could not change context to $ENVIRONMENT: $CHG_CTX"
    exit 1
else
    helmfile -f helmfile.yaml -i --environment $ENVIRONMENT apply
fi


