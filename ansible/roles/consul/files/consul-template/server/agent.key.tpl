{{- with $vars := file "/etc/consul.d/vars.yml" | parseYAML }}
{{- with secret "pki_int/issue/consul-server" (printf "common_name=server.%s.consul" $vars.datacenter) "ttl=24h" "alt_names=localhost,*.consul.online.ntnu.no,consul.online.ntnu.no" "ip_sans=127.0.0.1" -}}
{{- .Data.private_key -}}
{{- end -}}
{{- end }}