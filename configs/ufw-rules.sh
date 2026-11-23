#!/bin/bash
# --- run on vpn-gw ---
ufw default deny incoming
ufw default allow outgoing
ufw default deny routed
ufw allow 51820/udp
ufw allow from 10.20.0.2 to any port 22 proto tcp
ufw route allow from 10.20.0.0/24 to 10.10.0.10 port 443 proto tcp
ufw route allow from 10.20.0.0/24 to 10.10.0.10 port 22 proto tcp
ufw route allow in on enp0s9 out on enp0s8
ufw --force enable

# --- run on gitlab ---
ufw default deny incoming
ufw default allow outgoing
ufw allow from 10.20.0.0/24 to any port 443 proto tcp
ufw allow from 10.20.0.0/24 to any port 22 proto tcp
ufw allow from 10.10.0.1 to any port 22 proto tcp
ufw allow from 172.17.0.0/16 to any port 443 proto tcp
ufw --force enable
