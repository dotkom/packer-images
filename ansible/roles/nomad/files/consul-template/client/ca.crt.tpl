{{ with secret "pki_int/issue/nomad-client" "common_name=client.global.nomad" "ttl=24h" "alt_names=localhost" "ip_sans=127.0.0.1"}}
{{- .Data.issuing_ca -}}
{{ end }}
