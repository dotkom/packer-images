{{ with secret "pki_int/issue/consul" "common_name=consul" "ttl=24h"}}
{{ .Data.issuing_ca }}
{{ end }}
