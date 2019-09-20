apiVersion: v1
kind: Config
clusters:
- cluster:
    certificate-authority-data: ${ca_cert_base64}
    server: https://localhost:${api_server_port}
  name: from-scratch
contexts:
- context:
    cluster: from-scratch
    user: admin
  name: from-scratch
current-context: from-scratch
preferences: {}
users:
- name: admin
  user:
    client-certificate-data: ${client_cert_base64}
    client-key-data: ${client_key_base64}
