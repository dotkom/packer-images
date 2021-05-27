
listener "tcp" {
    address = "0.0.0.0:8200"
    tls_cert_file = "/etc/letsencrypt/live/vault.online.ntnu.no/fullchain.pem"
    tls_key_file = "/etc/letsencrypt/live/vault.online.ntnu.no/privkey.pem"
}

seal "awskms" {
    region = "eu-north-1"
    kms_key_id = "73a0cb28-b711-4f2b-85d4-5145e2c0a8e8"
}

storage "dynamodb" {
    ha_enabled = "true"
    region = "eu-north-1"
    table = "vault-data"
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

