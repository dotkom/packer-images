server:
  http_listen_address: 127.0.0.1
  http_listen_port: 9080

positions:
  filename: /opt/promtail/positions.yaml

clients:
{{ range service "loki|any" }}
  - url: http://{{ .Address }}:{{ .Port }}/loki/api/v1/push
{{ end }}

scrape_configs:
  - job_name: journal
    journal:
      max_age: 12h
      labels:
        job: systemd-journal
    relabel_configs:
      - source_labels: ['__journal__systemd_unit']
        target_label: 'unit'
  - job_name: docker
    loki_push_api:
      server:
        http_listen_address: 127.0.0.1
        http_listen_port: 9081
      labels:
        pushserver: docker