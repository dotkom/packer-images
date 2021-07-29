
listener "tcp" {
    address = "0.0.0.0:8200"
    tls_cert_file = "/etc/letsencrypt/live/vault.online.ntnu.no/fullchain.pem"
    tls_key_file = "/etc/letsencrypt/live/vault.online.ntnu.no/privkey.pem"
}

service_registration "consul" {
    service_address = ""
}

telemetry {
  prometheus_retention_time = "30s"
  disable_hostname = true
}

api_addr = "https://0.0.0.0:8200"
cluster_addr = "https://0.0.0.0:8201"
ui = true

