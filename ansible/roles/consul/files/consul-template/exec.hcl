reload_signal = ""
kill_signal = ""

exec {
  command = "/usr/bin/consul agent -config-dir=/etc/consul.d/"
  splay = "10s"
  reload_signal = "SIGHUP"
  kill_signal = "SIGINT"
}

template {
  source      = "/etc/consul.d/consul-template/00-consul.hcl.tpl"
  destination = "/etc/consul.d/00-consul.hcl"
}

template {
  source      = "/etc/consul.d/consul-template/ca.crt.tpl"
  destination = "/etc/consul.d/ca.crt"
}

template {
  source      = "/etc/consul.d/consul-template/agent.crt.tpl"
  destination = "/etc/consul.d/agent.crt"
}

template {
  source      = "/etc/consul.d/consul-template/agent.key.tpl"
  destination = "/etc/consul.d/agent.key"
}