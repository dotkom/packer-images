
vault {
  address      = "https://vault.online.ntnu.no:8200"
  unwrap_token = false
  renew_token  = false
  vault_agent_token_file = "/etc/consul_template.d/vault_token"
}

template {
  source      = "/etc/consul_template.d/templates/ssh_host_key.tpl"
  destination = "/etc/ssh/ssh_host_rsa_key-cert.pub"
  perms       = 0640
}