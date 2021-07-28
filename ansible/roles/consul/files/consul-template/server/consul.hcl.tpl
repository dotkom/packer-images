server                 = true
bootstrap_expect = {{ with $d := file "/etc/consul.d/runtime-config-vars" | parseJSON }}{{ $d.bootstrap_expect }}{{ end }}

datacenter             = "{{ with $d := file "/etc/consul.d/runtime-config-vars" | parseJSON }}{{ $d.datacenter }}{{ end }}"
primary_datacenter     = "{{ with $d := file "/etc/consul.d/runtime-config-vars" | parseJSON }}{{ $d.primary_datacenter }}{{ end }}"


advertise_addr = "{{ sockaddr "GetPrivateIP" }}"
client_addr = "0.0.0.0"
bind_addr = "0.0.0.0"
translate_wan_addrs = true
ports {
  https = 8501
  grpc = 8502
}
retry_join_wan = {{ with $d := file "/etc/consul.d/runtime-config-vars" | parseJSON }}{{ $d.retry_join_wan | toJSON}}{{ end }}
retry_join = {{ with $d := file "/etc/consul.d/runtime-config-vars" | parseJSON }}{{ $d.retry_join | toJSON}}{{ end }}

verify_outgoing        = true
verify_server_hostname = true
verify_incoming        = true
key_file               = "/etc/consul.d/agent.key"
cert_file              = "/etc/consul.d/agent.crt"
ca_file                = "/etc/consul.d/ca.crt"
auto_encrypt {
  allow_tls = true
}
encrypt = "{{ with secret "secret/data/consul/encrypt" }}{{ .Data.data.key }}{{ end }}"




ui_config {
  enabled = true
  metrics_provider = "prometheus"
  metrics_proxy {
    base_url = "http://prometheus.service.consul:9999"
  }
}
advertise_addr_wan = "{{ sockaddr "GetPublicIP" }}"

telemetry { 
  disable_compat_1.9 = true 
  disable_hostname = true
  prometheus_retention_time = "30s"
}

rpc {
  enable_streaming = true
}

connect {
  enabled = true
}

data_dir               = "/opt/consul"

acl {
  enabled                  = true
  default_policy           = "deny"
  enable_token_persistence = true
  enable_token_replication = true
  tokens = {
    master = "{{ with secret "secret/data/consul/acl/master" }}{{ .Data.data.token }}{{ end }}"
    default = "{{ with $d := file "/etc/consul.d/runtime-config-vars" | parseJSON }}{{ $acl_role := printf "secret/data/consul/acl/%s" $d.acl_role }}{{ with secret $acl_role }} {{ .Data.data.token }}{{end}}{{ end }}"
  }
}

enable_script_checks = false
disable_remote_exec = true
