resource "tls_private_key" "service-account-ca" {
  algorithm   = "RSA"
  ecdsa_curve = "2048"
}

resource "tls_locally_signed_cert" "service-account-ca" {
  cert_request_pem   = "${tls_cert_request.service-account-ca.cert_request_pem}"
  ca_key_algorithm   = "RSA"
  ca_private_key_pem = "${tls_private_key.ca.private_key_pem}"
  ca_cert_pem        = "${tls_self_signed_cert.ca.cert_pem}"

  is_ca_certificate = true

  validity_period_hours = 8760

  allowed_uses = [
    "cert_signing",
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}

resource "tls_cert_request" "service-account-ca" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.service-account-ca.private_key_pem}"

  subject {
    common_name         = "service-accounts"
    organizational_unit = "Kubernetes Pros"
    organization        = "ACME Ltd"
    locality            = "Your City"
    country             = "NZ"
  }
}

resource "local_file" "service-account-ca_public" {
  content  = "${tls_locally_signed_cert.service-account-ca.cert_pem}"
  filename = "${path.module}/output/service-account-ca_public.pem"
}

resource "local_file" "service-account-ca_private" {
  content  = "${tls_private_key.service-account-ca.private_key_pem}"
  filename = "${path.module}/output/service-account-ca_private.pem"
}
