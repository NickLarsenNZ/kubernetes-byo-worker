resource "tls_private_key" "admin" {
  algorithm   = "RSA"
  ecdsa_curve = "2048"
}

resource "tls_locally_signed_cert" "admin" {
  cert_request_pem   = "${tls_cert_request.admin.cert_request_pem}"
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

resource "tls_cert_request" "admin" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.admin.private_key_pem}"

  subject {
    common_name         = "kubernetes"
    organizational_unit = "Kubernetes Pros"
    organization        = "system:masters"
    locality            = "Your City"
    country             = "NZ"
  }
}

resource "local_file" "admin_public" {
  content  = "${tls_locally_signed_cert.admin.cert_pem}"
  filename = "${path.module}/output/admin_public.pem"
}

resource "local_file" "admin_private" {
  content  = "${tls_private_key.admin.private_key_pem}"
  filename = "${path.module}/output/admin_private.pem"
}