#!/bin/bash

# load uuid and path 
source params.txt

yum install -y unzip wget net-tools epel-release  openssl

pkg_url="https://github.com/v2fly/v2ray-core/releases/download/v4.34.0/v2ray-linux-64.zip"
tmp_dir=/tmp/v2ray

mkdir -p $tmp_dir
wget $pkg_url -O v2ray.zip
unzip v2ray.zip -d $tmp_dir

cp $tmp_dir/v2ray /usr/local/bin
cp $tmp_dir/v2ctl /usr/local/bin
cp $tmp_dir/geoip.dat /usr/local/bin
cp $tmp_dir/geosite.dat /usr/local/bin
cp -f "$tmp_dir/systemd/system/v2ray.service" "/lib/systemd/system/"

logDir=/var/log/v2ray
mkdir -p $logDir
touch $logDir/access.log
touch $logDir/error.log
chown -R nobody $logDir


# generate config
config_dir=/usr/local/etc/v2ray
mkdir -p $config_dir
sed "s/v2ray_uuid/$uuid/" ./assets/config.json >  $config_dir/config.json


# setup nginx
yum install -y nginx

domain=$(/usr/sbin/ifconfig eth0 | grep 'inet ' | awk '{print $2}')
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout  /etc/nginx/server.key -out  /etc/nginx/server.crt -subj "/C=US/ST=Zhejiang/L=Hangzhou/O=haha/OU=haha/CN=$domain"

sed "s#v2ray_path#$path#" ./assets/nginx.conf > /etc/nginx/nginx.conf


# start services
systemctl enable nginx
systemctl enable v2ray
systemctl start nginx
systemctl start v2ray


