locals {
  hostname_format = "${var.worker_prefix}%0${var.worker_index_zero_pad}d${var.worker_suffix}"
}

resource "tls_private_key" "worker" {
  count       = "${var.worker_count}"
  algorithm   = "RSA"
  ecdsa_curve = "2048"
}

resource "tls_locally_signed_cert" "worker" {
  count              = "${var.worker_count}"
  cert_request_pem   = "${tls_cert_request.worker.*.cert_request_pem[count.index]}"
  ca_key_algorithm   = "RSA"
  ca_private_key_pem = "${tls_private_key.ca.private_key_pem}"
  ca_cert_pem        = "${tls_self_signed_cert.ca.cert_pem}"

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
  ]
}

resource "tls_cert_request" "worker" {
  count           = "${var.worker_count}"
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.worker.*.private_key_pem[count.index]}"

  subject {
    common_name         = "system:node:${format(local.hostname_format, count.index + var.worker_index_start)}"
    organizational_unit = "Kubernetes Pros"
    organization        = "system:nodes"
    locality            = "Your City"
    country             = "NZ"
  }

  dns_names = [
    "${format(local.hostname_format, count.index + var.worker_index_start)}",
    "${format(local.hostname_format, count.index + var.worker_index_start)}.${var.worker_domain_name}",
  ]
}
