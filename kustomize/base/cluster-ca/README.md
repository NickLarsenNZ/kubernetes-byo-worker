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

