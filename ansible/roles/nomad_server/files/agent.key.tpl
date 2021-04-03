{{ with secret "pki_int/issue/nomad-server" "common_name=server.global.nomad" "ttl=24h" "alt_names=localhost,*.nomad.online.ntnu.no,nomad.online.ntnu.no" "ip_sans=127.0.0.1"}}
{{- .Data.private_key -}}
{{ end }}