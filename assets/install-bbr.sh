#!/bin/bash
# Desc: tested on CentOS7

yum install -y epel-release elrepo-release

yum --enablerepo=elrepo-kernel -y install kernel-ml

cat >> /etc/sysctl.conf <<EOF
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr

net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
EOF

idx=$(awk -F "'" '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg | grep -iv Rescue | head -n 1 | cut -d' ' -f1)

grub2-set-default $idx

reboot

