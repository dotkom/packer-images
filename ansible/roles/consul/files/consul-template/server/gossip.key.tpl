{{ with secret "secret/data/consul/encrypt" }}
{{ .Data.data.key }}
{{ end }}
