{{- with $vars := file "/etc/consul.d/vars.yml" | parseYAML -}}
{{- $vars.acl_token }}
{{- end -}}