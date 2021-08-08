{{- with secret "pki_int/issue/consul-client" "common_name=client.consul" "ttl=24h" "alt_names=localhost" "ip_sans=127.0.0.1" -}}
{{- .Data.private_key -}}
{{- end -}}