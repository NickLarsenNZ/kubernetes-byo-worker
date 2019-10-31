# Decisions

_Quick list of decisions_

- path to tls certs in all containers: `/opt/pki/$component/$ca/{ca.crt, tls.crt, tls.key}`, eg:
    - /opt/pki/kube-apiserver/public/ca.crt
    - /opt/pki/kube-scheduler/private/tls.crt
- path to kubeconfigs: `/opt/kubernetes/kubeconfig`