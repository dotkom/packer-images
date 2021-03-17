{{ with secret "ssh-client-signer/config/ca" }}
{{ .Data.public_key }}
{{ end }}