#!/bin/bash
# tryravuna.com HTTPS cert watch — relaunched Nov 13 after the /tmp watcher
# was lost in a runtime restart. Polls every 15 min for up to 12 hours.
# Exits 0 with CERT-LIVE the first time https answers 200.
for i in $(seq 1 48); do
  code=$(curl -s -o /dev/null -w '%{http_code}' https://tryravuna.com --max-time 20)
  echo "$(date -u +%FT%TZ) poll $i: https=$code"
  if [ "$code" = "200" ]; then
    echo "CERT-LIVE"
    exit 0
  fi
  sleep 900
done
echo "CERT-STILL-PENDING after 12h"
exit 1
