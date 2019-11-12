I install prometheus operator and kube-prometheus.
Grafana dashboard: https://grafana.com/grafana/dashboards/3070


## Install global cert-manager

Intention: cluster wide cert-manager installed (example below), then a ClusterIssuer to...

This will install a not yet released version of cert-manager which allows for extended key usages.
See: <https://github.com/jetstack/cert-manager/pull/2260>

```sh
kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/62c4e0b6eb1f4b598f167fe0d54fc410309144a4/deploy/manifests/00-crds.yaml
kubectl create ns cert-manager
helm repo add jetstack https://charts.jetstack.io
helm upgrade --install my-release --namespace cert-manager jetstack/cert-manager -f kustomize/overlays/local/cluster-ca/cert-manager.yml
```

_Note: The CRDs require Kubernetes >= 1.11_

### Example signed certificate key usage

```sh
kubectl get secrets  local-etcd-peers -o yaml | yq -r '.data["tls.crt"]' | base64 -d | openssl x509 -noout -purpose
Certificate purposes:
SSL client : Yes
SSL client CA : No
SSL server : Yes
SSL server CA : No
Netscape SSL server : Yes
Netscape SSL server CA : No
S/MIME signing : No
S/MIME signing CA : No
S/MIME encryption : No
S/MIME encryption CA : No
CRL signing : No
CRL signing CA : No
Any Purpose : Yes
Any Purpose CA : Yes
OCSP helper : Yes
OCSP helper CA : No
Time Stamp signing : No
Time Stamp signing CA : No
```