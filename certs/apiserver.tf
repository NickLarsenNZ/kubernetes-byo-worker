resource "tls_private_key" "apiserver" {
  algorithm   = "RSA"
  ecdsa_curve = "2048"
}

resource "tls_locally_signed_cert" "apiserver" {
  cert_request_pem   = "${tls_cert_request.apiserver.cert_request_pem}"
  ca_key_algorithm   = "RSA"
  ca_private_key_pem = "${tls_private_key.ca.private_key_pem}"
  ca_cert_pem        = "${tls_self_signed_cert.ca.cert_pem}"

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "tls_cert_request" "apiserver" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.apiserver.private_key_pem}"

  subject {
    common_name         = "kubernetes"
    organizational_unit = "Kubernetes Pros"
    organization        = "ACME Ltd"
    locality            = "Your City"
    country             = "NZ"
  }

  dns_names = [
    "${var.apiserver_fqdn}",
    "kubernetes",
    "kubernetes.default",
    "kubernetes.default.svc",
    "kubernetes.default.svc.cluster",
    "kubernetes.svc.cluster.local",
  ]

  ip_addresses = [
    "127.0.0.1",
    "10.32.0.1",
    "10.240.0.10",
    "10.240.0.11",
    "10.240.0.12",
  ]
}

resource "local_file" "apiserver_public" {
  content  = "${tls_locally_signed_cert.apiserver.cert_pem}"
  filename = "${path.module}/output/apiserver_public.pem"
}

resource "local_file" "apiserver_private" {
  content  = "${tls_private_key.apiserver.private_key_pem}"
  filename = "${path.module}/output/apiserver_private.pem"
}
