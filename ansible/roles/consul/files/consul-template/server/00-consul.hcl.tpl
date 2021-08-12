{{ with $vars := file "/etc/consul.d/vars.yml" | parseYAML }}
server                 = true
advertise_addr = "{{ sockaddr "GetPrivateIP" }}"
client_addr = "0.0.0.0"
bind_addr = "0.0.0.0"
translate_wan_addrs = true


bootstrap_expect = {{ $vars.bootstrap_expect }}

encrypt = "{{ with secret "secret/data/consul/encrypt" }}{{ .Data.data.key }}{{ end }}"
node_name = "{{ $vars.node_name }}"
datacenter = "{{ $vars.datacenter }}"
primary_datacenter = "{{ $vars.primary_datacenter }}"
retry_join = {{ $vars.retry_join | toJSON}}
retry_join_wan = {{ $vars.retry_join_wan | toJSON}}

ports {
  https = 8501
  grpc = 8502
}

verify_outgoing        = true
verify_server_hostname = true
verify_incoming        = true
key_file               = "/etc/consul.d/agent.key"
cert_file              = "/etc/consul.d/agent.crt"
ca_file                = "/etc/consul.d/ca.crt"

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
}
enable_script_checks = false
disable_remote_exec = true
{{ end }}