# Kubernetes Helm Chart

## Prepare

```sh
helm repo add bitnami https://charts.bitnami.com/bitnami
helm dependency update kubernetes/
kubectl create namespace mykube
```

## Install

```sh
helm upgrade --install mykube --namespace mykube kubernetes/
```

## Deprovision

```sh
helm delete mykube --purge
```