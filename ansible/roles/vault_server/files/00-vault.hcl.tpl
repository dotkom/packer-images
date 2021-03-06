{{ with $vars := file "/etc/vault.d/vars.yml" | parseYAML }}

listener "tcp" {
    address = "0.0.0.0:8200"
    tls_cert_file = "/etc/letsencrypt/live/vault.online.ntnu.no/fullchain.pem"
    tls_key_file = "/etc/letsencrypt/live/vault.online.ntnu.no/privkey.pem"
}

telemetry {
  prometheus_retention_time = "30s"
  disable_hostname = true
}

seal "awskms"  {
  region     = "{{ $vars.aws_region }}"
  kms_key_id = "{{ $vars.kms_key_id }}"
}

storage "postgresql" {
  connection_url = "postgres://vault:{{ $vars.db_password }}@{{ $vars.db_address }}/vault"
  ha_enabled = true
}

service_registration "consul" {
  address = "127.0.0.1:8500"
  service_address = ""
}

api_addr = "https://0.0.0.0:8200"
cluster_addr = "https://0.0.0.0:8201"
ui = true

{{ end }}