#!/usr/bin/env bash
export CONSUL_HTTP_ADDR="http://localhost:8500"

export CONSUL_HTTP_TOKEN=$(cat /opt/consul/agent.token)
if (systemctl -q is-active consul.service)
then
    consul acl set-agent-token default $CONSUL_HTTP_TOKEN
else
    echo "Consul not active..."
    exit 1
fi

