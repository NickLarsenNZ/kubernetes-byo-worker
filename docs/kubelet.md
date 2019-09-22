# Controller Manager

## Notes

- Kubelet can bootstrap with a token. Controller Manager signs it, and Kubelet can download it and reconnect using that
- Kubelet is unable to have it's server certificate signed in the same fashion, and must instead be manually signed, have another controller take care of it, or already be provided with the certificates.

## CLI Arguments

| Argument | Notes |
| -------- | ----- |
| `--rotate-certificates` | Generate a CSR to renew client cert before it expires (controller-manager needs to be able to sign it) |
| `--rotate-server-certificates` | Generate a CSR to renew server cert before it expires (controller-manager needs to be able to sign it) |