#! /bin/bash
source .env

# install ingress
kubectl --kubeconfig=$KUBECONFIG_PATH apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml

# setup ingress service
kubectl --kubeconfig=$KUBECONFIG_PATH apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/cloud-generic.yaml

# install cert manager
kubectl --kubeconfig=$KUBECONFIG_PATH apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.6/deploy/manifests/00-crds.yaml
kubectl --kubeconfig=$KUBECONFIG_PATH apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.6/deploy/manifests/cert-manager.yaml

cat <<EOF | kubectl  --kubeconfig=.kubeconfig.yml apply -f -
apiVersion: certmanager.k8s.io/v1alpha1
kind: ClusterIssuer
metadata:
  name: letsencrypt-production
spec:
  acme:
    # The ACME server URL
    server: https://acme-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: $CERTIFICATE_EMAIL
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: $CERTIFICATE_SECRET
    # Enable the HTTP-01 challenge provider
    http01: {}
EOF

find . -type f -exec sed  -ie "s/\$NAMESPACE_ID/$CI_PIPELINE_ID/g" namespace/deployment.yml
