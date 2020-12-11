#!/bin/bash
set -e

echo "Retrieving Network Inventory..."
python3 /mnt/scripts/zerotier.py --refresh

echo "Restarting dnsmasq service..."
if hash systemctl 2>/dev/null; then
  systemctl restart dnsmasq
elif hash service 2>/dev/null; then
  service dnsmasq restart
elif hash rc-service 2>/dev/null; then
  rc-service dnsmasq restart
else
  killall -HUP dnsmasq
fi
