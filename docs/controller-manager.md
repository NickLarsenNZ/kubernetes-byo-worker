# Controller Manager

## CLI Arguments

| Argument | Notes |
| -------- | ----- |
| `--leader-elect` | ??? `kubectl -n kube-system get endpoints` |
| `--kubeconfig` | If not specifies, you need to specify `--master` among other configs. Much easier to specify the `kubeconfig` |
| `--service-account-private-key-file` | Console logs if not present: `W0922 00:50:18.272941       1 controllermanager.go:552] "serviceaccount-token" is disabled because there is no private key` |
| `--authentication-kubeconfig` | `W0922 00:58:52.675172       1 authentication.go:249] No authentication-kubeconfig provided in order to lookup client-ca-file in configmap/extension-apiserver-authentication in kube-system, so client certificate authentication won't work.`<br>`W0922 00:58:52.675209       1 authentication.go:252] No authentication-kubeconfig provided in order to lookup requestheader-client-ca-file in configmap/extension-apiserver-authentication in kube-system, so request-header client certificate authentication won't work.`<br>`authorization.go:146] No authorization-kubeconfig provided, so SubjectAccessReview of authorization tokens won't work.` |
| `--cluster-signing-cert-file`<br>`--cluster-signing-key-file` | For controller-manager signing certs for kubelets (allowing them to bootstrap with a token) |

**todo**

```logs
I0922 00:58:52.387358       1 serving.go:319] Generated self-signed cert in-memory
W0922 00:58:52.675172       1 authentication.go:249] No authentication-kubeconfig provided in order to lookup client-ca-file in configmap/extension-apiserver-authentication in kube-system, so client certificate authentication won't work.
W0922 00:58:52.675209       1 authentication.go:252] No authentication-kubeconfig provided in order to lookup requestheader-client-ca-file in configmap/extension-apiserver-authentication in kube-system, so request-header client certificate authentication won't work.
W0922 00:58:52.675226       1 authorization.go:146] No authorization-kubeconfig provided, so SubjectAccessReview of authorization tokens won't work.
I0922 00:58:52.675327       1 controllermanager.go:164] Version: v1.15.3
I0922 00:58:52.676116       1 secure_serving.go:116] Serving securely on [::]:10257
I0922 00:58:52.676760       1 deprecated_insecure_serving.go:53] Serving insecurely on [::]:10252
I0922 00:58:52.676817       1 leaderelection.go:235] attempting to acquire leader lease  kube-system/kube-controller-manager...
```