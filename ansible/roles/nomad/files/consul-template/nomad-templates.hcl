template {
  source          = "/etc/nomad.d/nomad.hcl.tpl"
  destination     = "/etc/nomad.d/nomad.hcl"
  perms           = 0770
  command         = "systemctl reload nomad"
  command_timeout = "0s"
}

template {
  source          = "/etc/nomad.d/agent.crt.tpl"
  destination     = "/etc/nomad.d/agent.crt"
  perms           = 0774
  command         = "systemctl reload nomad"
  command_timeout = "0s"
}

template {
  source          = "/etc/nomad.d/agent.key.tpl"
  destination     = "/etc/nomad.d/agent.key"
  perms           = 0770
  command         = "systemctl reload nomad"
  command_timeout = "0s"

}

template {
  source          = "/etc/nomad.d/ca.crt.tpl"
  destination     = "/etc/nomad.d/ca.crt"
  perms           = 0774
  command         = "systemctl reload nomad"
  command_timeout = "0s"

}
