#/bin/bash
if [ "$RENEWED_LINEAGE" == "/etc/letsencrypt/live/vault.online.ntnu.no" ]; then
    systemctl restart vault
fi