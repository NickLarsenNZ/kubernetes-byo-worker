resource "tls_private_key" "cm" {
  algorithm   = "RSA"
  ecdsa_curve = "2048"
}

resource "tls_locally_signed_cert" "cm" {
  cert_request_pem   = "${tls_cert_request.cm.cert_request_pem}"
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

resource "tls_cert_request" "cm" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.cm.private_key_pem}"

  subject {
    common_name         = "system:kube-controller-manager"
    organizational_unit = "Kubernetes Pros"
    organization        = "system:kube-controller-manager"
    locality            = "Your City"
    country             = "NZ"
  }
}

resource "local_file" "cm_public" {
  content  = "${tls_locally_signed_cert.cm.cert_pem}"
  filename = "${path.module}/output/cm_public.pem"
}

resource "local_file" "cm_private" {
  content  = "${tls_private_key.cm.private_key_pem}"
  filename = "${path.module}/output/cm_private.pem"
}

data "template_file" "cm_kubeconfig" {
  template = "${file("${path.module}/kubeconfig.tpl")}"

  vars = {
    ca_cert_base64     = "${base64encode(tls_self_signed_cert.ca.cert_pem)}"
    api_hostname       = "kube-apiserver"
    api_server_port    = "6443"
    client_cert_base64 = "${base64encode(tls_locally_signed_cert.cm.cert_pem)}"
    client_key_base64  = "${base64encode(tls_private_key.cm.private_key_pem)}"
  }
}

resource "local_file" "cm_kubeconfig" {
  content  = "${data.template_file.cm_kubeconfig.rendered}"
  filename = "${path.module}/output/cm_kubeconfig"
}
