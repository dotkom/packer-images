#!/bin/bash
CERT=$(aws secretsmanager get-secret-value --secret-id letsencrypt/online.ntnu.no --region eu-north-1 --query SecretString --output text)

echo $CERT | tr '\r\n' ' ' | jq -r '.issuerCertificate' > /etc/vault.d/ca.crt
echo $CERT | tr '\r\n' ' ' | jq -r '.certificate' > /etc/vault.d/agent.crt
echo $CERT | tr '\r\n' ' ' | jq -r '.privateKey' > /etc/vault.d/agent.pem

