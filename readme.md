# k8s cluster bootstrap

## .env

`$ mv .env.example .env` and adapt the variables

## kubeconfig

Needs to be a kubeconfig which user has cluster admin capabilities

## bootstrap cluster

Installs nginx ingress and letsencrypt cert-manager.

- `./bootstrap-cluster.sh`

## boostrap namespace

Helper to generate a namespace with a dedicated service account and rolebinding for ci integration.

`./bootstrap-namespace.sh your-namespace`


