template {
  source      = "/etc/consul.d/ca.crt.tpl"
  destination = "/etc/consul.d/ca.crt"
  command     = "consul reload"
}

template {
  source      = "/etc/consul.d/consul.hcl.tpl"
  destination = "/etc/consul.d/consul.hcl"
}