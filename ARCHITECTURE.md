# Architecture

```
Laptop (WireGuard: admin/dev1/dev2)
   | UDP 51820, split-tunnel (10.20.0.0/24, 10.10.0.0/24)
   v
[vpn-gw]  NAT(internet) + Bridged(LAN) + Internal "priv-net" 10.10.0.1/24
   wg0: 10.20.0.1/24 | ip_forward=1 | MASQUERADE priv-net -> internet
   UFW: 51820/udp public; 22/tcp admin-only
   |
   v  Internal Network "priv-net" (no route out except via vpn-gw)
[gitlab]  10.10.0.10/24 (+legacy 10.10.0.2/24), Internal NIC only
   GitLab CE :443, Docker-executor Runner
   UFW: 443/22 tcp allowed only from 10.20.0.0/24 + 10.10.0.1
```

**Request path:** laptop → WireGuard tunnel → `vpn-gw` (`wg0`) → forwarded → `priv-net` → `gitlab`:443/22.
