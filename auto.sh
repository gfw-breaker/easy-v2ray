#!/bin/bash
# author: gfw-breaker

path=/ray
uuid=3579436c-b37e-11eb-8529-0242ac130003

yum install -y git
git clone https://github.com/gfw-breaker/easy-v2ray.git

# install 
cd easy-v2ray
cat > params.txt <<EOF
path=$path
uuid=$uuid
EOF

bash assets/install-v2ray.sh
bash assets/install-bbr.sh


