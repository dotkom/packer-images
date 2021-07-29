server                 = true
advertise_addr = "{{ GetPrivateIP }}"
client_addr = "0.0.0.0"
bind_addr = "0.0.0.0"
translate_wan_addrs = true

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

auto_encrypt {
  allow_tls = true
}

ui_config {
  enabled = true
  metrics_provider = "prometheus"
  metrics_proxy {
    base_url = "http://prometheus.service.consul:9999"
  }
}
advertise_addr_wan = "{{ GetPublicIP }}"

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
