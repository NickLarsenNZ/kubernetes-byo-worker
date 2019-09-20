resource "tls_private_key" "ca" {
  algorithm   = "RSA"
  ecdsa_curve = "2048"
}

resource "tls_self_signed_cert" "ca" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.ca.private_key_pem}"

  is_ca_certificate = true

  subject {
    common_name         = "kubernetes"
    organizational_unit = "Kubernetes Pros"
    organization        = "ACME Ltd"
    locality            = "Your City"
    country             = "NZ"
  }

  validity_period_hours = 8760

  allowed_uses = [
    "cert_signing",
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
  ]
}

resource "local_file" "ca_public" {
  content  = "${tls_self_signed_cert.ca.cert_pem}"
  filename = "${path.module}/output/ca_public.pem"
}

resource "local_file" "ca_private" {
  content  = "${tls_private_key.ca.private_key_pem}"
  filename = "${path.module}/output/ca_private.pem"
}
