template {
  source      = "/etc/consul.d/consul-template/ca.crt.tpl"
  destination = "/etc/consul.d/ca.crt"
  command     = "consul reload"
  command_timeout = 0
}

template {
  source      = "/etc/consul.d/consul-template/agent.crt.tpl"
  destination = "/etc/consul.d/agent.crt"
  command     = "consul reload"
  command_timeout = 0
}

template {
  source      = "/etc/consul.d/consul-template/agent.key.tpl"
  destination = "/etc/consul.d/agent.key"
  command     = "consul reload"
  command_timeout = 0
}

template {
  source      = "/etc/consul.d/consul-template/gossip.key.tpl"
  destination = "/opt/consul/gossip.key"
  command     = "/etc/consul.d/rotate_consul_key.sh"
}
