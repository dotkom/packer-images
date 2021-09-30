#!/usr/bin/env bash
export CONSUL_HTTP_ADDR="https://localhost:8501"

export CONSUL_HTTP_SSL=true
export CONSUL_CACERT=/etc/consul.d/ca.crt
export CONSUL_CLIENT_CERT=/etc/consul.d/agent.crt
export CONSUL_CLIENT_KEY=/etc/consul.d/agent.key
export CONSUL_HTTP_TOKEN=$(cat /opt/consul/agent.token)

if (systemctl -q is-active consul.service)
then
    consul acl set-agent-token default $CONSUL_HTTP_TOKEN
    systemctl restart consul
else
    echo "Consul not active..."
    exit 1
fi
