
vault {
  address      = "https://vault.online.ntnu.no:8200"
  unwrap_token = false
  renew_token  = true
}

template {
  source      = "/etc/consul_template/templates/gossip.key.tpl"
  destination = "/opt/consul/gossip/gossip.key"
  perms       = 0700
  command     = "/etc/consul_template/scripts/rotate_key.sh"
}