# ca_keys

This is to setup signing keys for the private CA used by etcd and to authenticate the kubelets and other Kubernetes components with the apiserver.

```
                      +-----------------------+
                      |      Trusted CA       |
                      |   (Existing Issuer)   |
                      +-----------^-----------+
                                  |
                           +------+------+
                           |             |
+--------------------------+--+       +--+-----------------------+
|    Kubernetes Public CA     |       |  Kubernetes Private CA   |
| (clients to kube-apiserver) |       | (inter-component comms)  |
+-----------------------------+       +--------------------------+

```

## Install global cert-manager

Intention: cluster wide cert-manager installed (example below), then a ClusterIssuer to...

```sh
kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.11/deploy/manifests/00-crds.yaml
kubectl create ns cert-manager
helm repo add jetstack https://charts.jetstack.io
helm install --name my-release --namespace cert-manager jetstack/cert-manager
```

_Note: The CRDs require Kubernetes >= 1.11_