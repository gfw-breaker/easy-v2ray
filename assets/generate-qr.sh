#!/bin/bash

yum install qrencode

path=/ray
port=443
ip=$(ifconfig eth0 | grep 'inet ' | awk '{print $2'} | sed 's/addr://')
uuid=$(cat /usr/local/etc/v2ray/config.json | grep '"id"' | cut -d'"' -f4 | head -n1)


cat > /tmp/vmess.json <<EOF
{
  "v":"2",
  "ps":"$ip:$port",
  "add":"$ip",
  "port":"$port",
  "id":"$uuid",
  "aid":"0",
  "net":"ws",
  "type":"none",
  "host":"$ip",
  "path":"$path",
  "allowInsecure":true,
  "mux":"1",
  "tfo":"1",
  "tls":"tls"
}
EOF

link="vmess://$(cat /tmp/vmess.json | base64 -w 0)"

qrencode -o /usr/share/nginx/html/qr.png -s8 $link

