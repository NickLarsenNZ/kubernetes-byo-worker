data "template_file" "kubeconfig" {
  template = "${file("${path.module}/kubeconfig.tpl")}"

  vars = {
    ca_cert_base64     = "${base64encode(tls_self_signed_cert.ca.cert_pem)}"
    api_server_port    = "${var.apiserver_port}"
    client_cert_base64 = "${base64encode(tls_locally_signed_cert.admin.cert_pem)}"
    client_key_base64  = "${base64encode(tls_private_key.admin.private_key_pem)}"
  }
}

resource "local_file" "kubeconfig" {
  content  = "${data.template_file.kubeconfig.rendered}"
  filename = "${path.module}/output/kubeconfig"
}
