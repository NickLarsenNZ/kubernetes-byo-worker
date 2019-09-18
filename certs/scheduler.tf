resource "tls_private_key" "scheduler" {
    algorithm   = "RSA"
    ecdsa_curve = "2048"
}

resource "tls_locally_signed_cert" "scheduler" {
  cert_request_pem   = "${tls_cert_request.scheduler.cert_request_pem}"
  ca_key_algorithm   = "RSA"
  ca_private_key_pem = "${tls_private_key.ca.private_key_pem}"
  ca_cert_pem        = "${tls_self_signed_cert.ca.cert_pem}"

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}

resource "tls_cert_request" "scheduler" {
    key_algorithm   = "RSA"
    private_key_pem = "${tls_private_key.scheduler.private_key_pem}"

    subject {
        common_name  = "system:kube-scheduler"
        organizational_unit = "Kubernetes Pros"
        organization = "system:kube-scheduler"
        locality = "Your City"
        country = "NZ"
    }
}
