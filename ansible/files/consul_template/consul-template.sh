#!/usr/bin/env bash
export VAULT_TOKEN=$(vault unwrap -field=token $(jq -r '.token' /tmp/vault/agent/token))
/usr/bin/consul-template -config=/etc/consul_template.d