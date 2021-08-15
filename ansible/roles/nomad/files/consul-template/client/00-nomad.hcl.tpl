{{ with $vars := file "/etc/nomad.d/vars.yml" | parseYAML }}

datacenter = "{{ $vars.datacenter }}"
data_dir = "/opt/nomad"
bind_addr = "0.0.0.0"

leave_on_terminate = true

client {
  enabled          = true
}

tls {
  http = true
  rpc  = true

  ca_file   = "/etc/nomad.d/ca.crt"
  cert_file = "/etc/nomad.d/agent.crt"
  key_file  = "/etc/nomad.d/agent.key"

  verify_server_hostname = true
  verify_https_client    = true
}

plugin "raw_exec" {
  config {
    enabled = true
  }
}

telemetry {
  collection_interval = "1s"
  disable_hostname = true
  prometheus_metrics = true
  publish_allocation_metrics = true
  publish_node_metrics = true
}

vault {
  enabled          = true
  tls_skip_verify  = true
  address          = "https://vault.online.ntnu.no:8200"
  create_from_role = "nomad-cluster"
}

plugin "docker" {
  config {
    allow_privileged = true
  }
}

consul {
 address = "127.0.0.1:8501"
 ssl = true
 ca_file = "/etc/nomad.d/consul-ca.crt"
 cert_file = "/etc/nomad.d/consul-agent.crt"
 key_file = "/etc/nomad.d/consul-agent.key"
}

{{ end }}