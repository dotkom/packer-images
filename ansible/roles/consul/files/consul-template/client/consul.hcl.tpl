datacenter             = "{{ with $d := file "/etc/consul.d/runtime-config-vars" | parseJSON }}{{ $d.datacenter }}{{ end }}"
primary_datacenter     = "{{ with $d := file "/etc/consul.d/runtime-config-vars" | parseJSON }}{{ $d.primary_datacenter }}{{ end }}"

advertise_addr = "{{ sockaddr "GetPrivateIP" }}"
client_addr = "0.0.0.0"
bind_addr = "0.0.0.0"
translate_wan_addrs = true
retry_join = "{{ with $d := file "/etc/consul.d/runtime-config-vars" | parseJSON }}{{ $d.retry_join | toJSON}}{{ end }}"

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

encrypt = "{{ with secret "secret/data/consul/encrypt" }}{{ .Data.data.key }}{{ end }}"


data_dir               = "/opt/consul"


acl {
  enabled                  = true
  default_policy           = "deny"
  enable_token_persistence = true
  enable_token_replication = true
  tokens = {
    default = "{{ with $d := file "/etc/consul.d/runtime-config-vars" | parseJSON }}{{ $acl_role := printf "secret/data/consul/acl/%s" $d.acl_role }}{{ with secret $acl_role }} {{ .Data.data.token }}{{end}}{{ end }}"
  }
}

enable_script_checks = false
disable_remote_exec = true
