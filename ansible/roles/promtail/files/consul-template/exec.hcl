reload_signal = ""
kill_signal = ""

exec {
  command = "/usr/bin/promtail -config.file /etc/promtail.d/conf.yml"
  splay = "10s"
  reload_signal = "SIGHUP"
  kill_signal = "SIGINT"
}

template {
  source      = "/etc/promtail.d/consul-template/conf.yml.tpl"
  destination = "/etc/promtail.d/conf.yml"
}