# Kubernetes BYO Worker

_**Disclaimer**: Work in progress, not all security measures are in place_

- Launch Kubernetes Master Services with ease
  - [x] docker-compose (on a Docker instance) for rapid prototyping
  - [ ] Helm (on an existing Kubernetes cluster) for production grade setup
  - [x] TLS cert generation for components
- Components
  - [x] etcd (insecure, not production ready)
  - [x] kube-apiserver (secure, not production ready)
  - [ ] kube-scheduler
  - [x] kube-controller-manager

## Run for prototyping

_**Note**: You might need to run a few times before it will work. This is because the certificates and kubeconfigs take some time, and docker-compose doesn't wait for init container dependencies to complete before starting the services. The same applies if you change the certs._

```sh
KUBE_APISERVER_PORT=8443 docker-compose up -d
kubectl --kubeconfig=certs/output/admin_kubeconfig get componentstatuses
```

## To hit the API in a browser

Create a PKCS12 (PFX) of the admin key pair.

```sh
openssl pkcs12 -export -out ~/admin.pfx -inkey certs/output/admin_private.pem -in certs/output/admin_public.pem
```

1. Import the PFX into your browser's identity store
2. Trust the CA (certs/output/ca_public.pem) in your browser's trust store
3. Visit <https://localhost:8443>, you should receive a popup for the itentity certificate, and the connection should be trusted.
