{{ with $vars := file "/etc/consul.d/vars.yml" | parseYAML }}

advertise_addr = "{{ sockaddr "GetPrivateIP" }}"
client_addr = "127.0.0.1 {{ sockaddr "GetInterfaceIP \"docker0\"" }}"

translate_wan_addrs = true

encrypt = "{{ with secret "secret/data/consul/encrypt" }}{{ .Data.data.key }}{{ end }}"
node_name = "{{ $vars.node_name }}"
datacenter         = "{{ $vars.datacenter }}"
primary_datacenter = "{{ $vars.primary_datacenter }}"
retry_join         = {{ $vars.retry_join | toJSON}}

ports {
  grpc = 8502
}

verify_outgoing        = true
verify_server_hostname = true
verify_incoming        = true
key_file               = "/etc/consul.d/agent.key"
cert_file              = "/etc/consul.d/agent.crt"
ca_file                = "/etc/consul.d/ca.crt"

data_dir               = "/opt/consul"

telemetry {
  disable_compat_1.9 = true
  disable_hostname = true
  prometheus_retention_time = "30s"
}

acl {
  enabled = true
  default_policy = "deny"
  enable_token_replication = true
}


enable_script_checks = false
disable_remote_exec = true
{{ end }}