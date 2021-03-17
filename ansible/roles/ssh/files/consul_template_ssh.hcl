template {
  source      = "/etc/ssh/trusted-user-ca-keys.pem.tpl"
  destination = "/etc/ssh/trusted-user-ca-keys.pub"
  error_on_missing_key = true
}

template {
  source      = "/etc/ssh/ssh_host_rsa_key-cert.pub.tpl"
  destination = "/etc/ssh/ssh_host_rsa_key-cert.pub"
  error_on_missing_key = true
}