template {
  source      = "/etc/consul.d/consul-template/00-consul.hcl.tpl"
  destination = "/etc/consul.d/00-consul.hcl"
}

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

template {
  source      = "/etc/consul.d/consul-template/agent.token.tpl"
  destination = "/opt/consul/agent.token"
  command     = "/etc/consul.d/set-agent-token.sh"
}
