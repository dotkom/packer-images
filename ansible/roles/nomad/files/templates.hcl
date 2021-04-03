template {
  source               = "/etc/nomad.d/ca.crt.tpl"
  destination          = "/etc/nomad.d/ca.crt"
  command              = "systemctl restart nomad"
}

template {
  source               = "/etc/nomad.d/agent.crt.tpl"
  destination          = "/etc/nomad.d/agent.crt"
  command              = "systemctl restart nomad"
}

template {
  source               = "/etc/nomad.d/agent.key.tpl"
  destination          = "/etc/nomad.d/agent.key"
  command              = "systemctl restart nomad"
}
