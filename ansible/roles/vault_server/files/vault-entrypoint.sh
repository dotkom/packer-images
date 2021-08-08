#!/bin/bash
consul-template -once -template "/etc/vault.d/00-vault.hcl.tpl:/etc/vault.d/00-vault.hcl"
vault server -config=/etc/vault.d/