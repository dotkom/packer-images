template {
  source      = "/etc/consul.d/templates/ca.pem.tpl"
  destination = "/etc/consul.d/ssl/ca.pub"
  error_on_missing_key = true
}

template {
  source      = "/etc/consul.d/templates/consul.hcl.tpl"
  destination = "/etc/consul.d/consul.hcl"
  error_on_missing_key = true
}