{{- with $vars := file "/etc/consul.d/vars.yml" | parseYAML -}}
{{- with secret (printf "consul/creds/%s" $vars.acl_role) -}}
{{- .Data.token -}}
{{- end -}}
{{- end -}}