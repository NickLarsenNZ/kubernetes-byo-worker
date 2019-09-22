# Scheduler

## CLI Arguments

| Argument | Notes |
| -------- | ----- |
|  |  |

**todo**

```log
I0922 02:25:40.705475       1 serving.go:319] Generated self-signed cert in-memory
W0922 02:25:41.408184       1 authentication.go:249] No authentication-kubeconfig provided in order to lookup client-ca-file in configmap/extension-apiserver-authentication in kube-system, so client certificate authentication won't work.
W0922 02:25:41.408229       1 authentication.go:252] No authentication-kubeconfig provided in order to lookup requestheader-client-ca-file in configmap/extension-apiserver-authentication in kube-system, so request-header client certificate authentication won't work.
W0922 02:25:41.408248       1 authorization.go:146] No authorization-kubeconfig provided, so SubjectAccessReview of authorization tokens won't work.
I0922 02:25:41.410923       1 server.go:142] Version: v1.15.3
I0922 02:25:41.411000       1 defaults.go:87] TaintNodesByCondition is enabled, PodToleratesNodeTaints predicate is mandatory
W0922 02:25:41.413191       1 authorization.go:47] Authorization is disabled
W0922 02:25:41.413224       1 authentication.go:55] Authentication is disabled
I0922 02:25:41.413250       1 deprecated_insecure_serving.go:51] Serving healthz insecurely on [::]:10251
I0922 02:25:41.413937       1 secure_serving.go:116] Serving securely on 127.0.0.1:10259
I0922 02:25:42.317547       1 leaderelection.go:235] attempting to acquire leader lease  kube-system/kube-scheduler...
I0922 02:25:42.326684       1 leaderelection.go:245] successfully acquired lease kube-system/kube-scheduler
```
