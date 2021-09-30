{{ with $vars := file "/etc/consul.d/vars.yml" | parseYAML }}
server                 = true
advertise_addr = "{{ sockaddr "GetPrivateIP" }}"
client_addr = "0.0.0.0"
translate_wan_addrs = true

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
    add_headers = [{
      name = "Authorization"
      value = "{{ with $auth := secret "secret/data/traefik/basicauth"}}{{ base64Encode (printf "%s:%s" $auth.Data.data.username $auth.Data.data.password) | printf "Basic %s"}}{{ end }}"
    }]
  }
}
advertise_addr_wan = "{{ sockaddr "GetPublicIP" }}"

enable_central_service_config = true

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

auto_encrypt {
  allow_tls = true
}

data_dir               = "/opt/consul"

enable_script_checks = false
disable_remote_exec = true

acl {
  enabled = true
  default_policy = "deny"
  enable_token_replication = true
  enable_token_persistence = true
}

config_entries {
  bootstrap = [
    {
      kind = "proxy-defaults"
      name = "global"
      config {
        protocol = "http"
        envoy_prometheus_bind_addr = "0.0.0.0:9102"
      }
    }
  ]
}
{{ end }}