{{ $contents := file "/etc/ssh/ssh_host_rsa_key.pub" | trimSpace }}
{{ $pair := printf "public_key=%s" $contents }}
{{ with secret "ssh-host-signer/sign/default" "cert_type=host" $pair }}
{{ .Data.signed_key }}
{{ end }}