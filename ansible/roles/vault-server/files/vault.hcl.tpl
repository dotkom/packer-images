
listener "tcp" {
    address = "0.0.0.0:8200"
    tls_cert_file = "/etc/vault.d/agent.crt"
    tls_key_file = "/etc/vault.d/agent.pem"
    tls_client_ca_file = "/etc/vault.d/ca.crt"
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

api_addr = "https://{{ sockaddr "GetPublicIP" }}:8200"
cluster_addr = "https://{{ sockaddr "GetPrivateIP" }}:8201"
ui = true

