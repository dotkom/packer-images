template {
  source      = "/etc/consul.d/ca.crt.tpl"
  destination = "/etc/consul.d/ca.crt"
  command     = "consul reload"
  command_timeout = 0
}

template {
  source      = "/etc/consul.d/consul.hcl.tpl"
  destination = "/etc/consul.d/consul.hcl"
}

template {
  source      = "/etc/consul.d/agent.crt.tpl"
  destination = "/etc/consul.d/agent.crt"
  command     = "consul reload"
  command_timeout = 0

}

template {
  source      = "/etc/consul.d/agent.key.tpl"
  destination = "/etc/consul.d/agent.key"
  command     = "consul reload"
  command_timeout = 0
}

template {
  source      = "/etc/consul.d/agent.key.tpl"
  destination = "/etc/consul.d/agent.key"
  command     = "consul reload"
  command_timeout = 0
}

template {
  source      = "/etc/consul.d/gossip.key.tpl"
  destination = "/opt/consul/gossip/gossip.key"
  command     = "/etc/consul.d/rotate_consul_key.sh"
}