server:
  http_listen_address: 0.0.0.0
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
  - job_name: 'nomad-logs'
    consul_sd_configs:
      - server: '127.0.0.1:8500'
    relabel_configs:
      - source_labels: [__meta_consul_service]
        target_label: job
      - source_labels: [__meta_consul_service_id]
        regex: '_nomad-task-([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})-.*'
        target_label: alloc
      - source_labels: [__meta_consul_service_id]
        regex: '_nomad-task-([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})-.*'
        target_label:  '__path__'
        replacement: '/opt/nomad/alloc/$1/alloc/logs/*std*.{?,??}'
