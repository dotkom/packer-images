{{- with $d := file "/etc/consul.d/runtime-config-vars" | parseJSON }}{{ $common_name := printf "common_name=server.%s.consul" $d.datacenter -}}
{{- with secret "pki_int/issue/consul-server" $common_name "ttl=24h" "alt_names=localhost,*.consul.online.ntnu.no,consul.online.ntnu.no" "ip_sans=127.0.0.1" -}}
{{- .Data.certificate -}}
{{- end -}}
{{- end }}