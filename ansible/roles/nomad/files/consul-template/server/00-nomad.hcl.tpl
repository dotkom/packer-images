{{ with $vars := file "/etc/nomad.d/vars.yml" | parseYAML }}

datacenter = "{{ $vars.datacenter }}"
data_dir = "/opt/nomad"
bind_addr = "0.0.0.0"

leave_on_terminate = true

server {
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

acl {
  enabled = true
  token_ttl = "30s"
  policy_ttl = "60s"
}

telemetry {
  collection_interval = "1s"
  disable_hostname = true
  prometheus_metrics = true
  publish_allocation_metrics = true
  publish_node_metrics = true
}

plugin "docker" {
  config {
    allow_privileged = true
  }
}

vault {
  enabled          = true
  tls_skip_verify  = true
  address          = "https://vault.online.ntnu.no:8200"
  create_from_role = "nomad-cluster"
  token = "{{ env "VAULT_TOKEN" }}"
}

server = {
  {{ if $vars.bootstrap }}
  bootstrap_expect =  {{ $vars.bootstrap_expect }}
  {{ end }}
  encrypt = "{{ with secret "secret/data/nomad/encrypt" }}{{ .Data.data.key }}{{ end }}"
}

consul {
 address = "127.0.0.1:8501"
 ssl = true
 ca_file = "/etc/nomad.d/consul-ca.crt"
 cert_file = "/etc/nomad.d/consul-agent.crt"
 key_file = "/etc/nomad.d/consul-agent.key"
}

{{ end }}