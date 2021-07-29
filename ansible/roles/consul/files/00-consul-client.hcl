advertise_addr = "{{ GetPrivateIP }}"
client_addr = "0.0.0.0"
bind_addr = "0.0.0.0"
translate_wan_addrs = true

ports {
  grpc = 8502
}

auto_encrypt = {
  tls = true
}
verify_incoming        = false
verify_outgoing        = true
verify_server_hostname = true
ca_file                = "/etc/consul.d/ca.crt"

data_dir               = "/opt/consul"

acl {
  enabled                  = true
  default_policy           = "deny"
  enable_token_persistence = true
  enable_token_replication = true
}

enable_script_checks = false
disable_remote_exec = true
