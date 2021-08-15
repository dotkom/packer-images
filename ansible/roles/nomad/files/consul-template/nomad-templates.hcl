template {
  source          = "/etc/nomad.d/00-nomad.hcl.tpl"
  destination     = "/etc/nomad.d/00-nomad.hcl"
  perms = 664
}

template {
  source          = "/etc/nomad.d/consul-template/agent.crt.tpl"
  destination     = "/etc/nomad.d/agent.crt"
  perms           = 0774
  command         = "systemctl reload nomad"
  command_timeout = 0
}

template {
  source          = "/etc/nomad.d/consul-template/agent.key.tpl"
  destination     = "/etc/nomad.d/agent.key"
  perms           = 0770
  command         = "systemctl reload nomad"
  command_timeout = 0
}

template {
  source          = "/etc/nomad.d/consul-template/ca.crt.tpl"
  destination     = "/etc/nomad.d/ca.crt"
  perms           = 0774
  command         = "systemctl reload nomad"
  command_timeout = 0
}

template {
  source          = "/etc/consul.d/consul-template/agent.crt.tpl"
  destination     = "/etc/nomad.d/consul-agent.crt"
  perms           = 0774
  command         = "systemctl reload nomad"
  command_timeout = 0
}

template {
  source          = "/etc/consul.d/consul-template/agent.key.tpl"
  destination     = "/etc/nomad.d/consul-agent.key"
  perms           = 0770
  command         = "systemctl reload nomad"
  command_timeout = 0
}

template {
  source          = "/etc/consul.d/consul-template/ca.crt.tpl"
  destination     = "/etc/nomad.d/consul-ca.crt"
  perms           = 0774
  command         = "systemctl reload nomad"
  command_timeout = 0
}
