# Kubernetes Helm Chart

## Prepare

```sh
helm repo add bitnami https://charts.bitnami.com/bitnami
helm dependency update kubernetes/
kubectl create namespace mykube
```

## Dry Run

**Quick validation**
```sh
helm install --dry-run --namespace=mykube kubernetes/
```

**View rendered output** _and pass to yq for querying_
```sh
helm upgrade --install mykube --dry-run --namespace=mykube kubernetes/  --debug | sed '0,/^COMPUTED VALUES:$/d' | sed '/^Release.*/,$d' | yq -y 'select(has("kind")) | {(.kind|tostring): .metadata.name}'

helm upgrade --install mykube --dry-run --namespace=mykube kubernetes/ --debug | sed '0,/^COMPUTED VALUES:$/d' | sed '/^Release.*/,$d' | yq -y 'select(has("kind")) | select(.kind=="Deployment") | .spec.template.spec.containers[] | .command'
```

## Install

```sh
helm upgrade --install mykube --namespace mykube kubernetes/
```

## Test

```sh
helm test mykube
```

## Deprovision

```sh
helm delete mykube --purge
```