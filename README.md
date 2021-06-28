### V2Ray (Vmess + TLS + WebSocket) 服务器简易搭建教程（不需要申请域名及证书）

---

#### 特点
搭建简单，无需Linux知识，无需登录服务器；默认使用websocket传输方式，服务器IP被GFW屏蔽的机率很小；自动安装BBR，低网络延迟

---

#### 搭建步骤

有众多公有云平台可供选择搭建v2ray服务器，下面以Vultr和DigitalOcean为例：

#### [Vultr平台](https://my.vultr.com/)

1. 创建 [Startup Script](https://my.vultr.com/startup/), 内容为如下脚本。其中 path 和 uuid 的值可以自行进行修改，但不能去掉/符号（客户端配置项要与此一致）

```
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
```

2. 创建 [New Instance](https://my.vultr.com/deploy/) ,在 Server Type 中选择 CentOS 7 x64 Without SELinux, 在 Startup Script 中选择刚创建好的脚本，点击 Deploy Now 进行部署

3. 等待几分钟后获取服务器IP，用浏览器测试该IP是否可用（初始启动时间可能存在差异，可以多试几次）。如IP地址为143.198.73.11, 则输入 https://143.198.73.11 （请注意是https，不是http）。若浏览器有服务器证书安全警告，则表示服务器可用。

#### [DigitalOcean平台](https://cloud.digitalocean.com/)

1. 创建新 [Droplet](https://cloud.digitalocean.com/droplets/new), 在 Choose an Image 中选择 CentOS 7.6 x64

2. 填写 UserData（内容与Vultr步骤中相同）

&nbsp;&nbsp; <img src="http://gfw-breaker.win/videos/imgs/easy-v2ray/droplet-userData.png" width="600px"/>

3. 填写密码，点击 Create Droplet 开始创建

4. 检测服务器IP是否可用 （与Vultr步骤相同）

---

#### 客户端配置

Windows 平台推荐使用 V2rayN，配置如下：

<img src="http://gfw-breaker.win/videos/imgs/easy-v2ray/v2rayN.png" width="600px"/>

iPhone 推荐使用 shadowrocket,配置如下：

<img src="http://gfw-breaker.win/videos/imgs/easy-v2ray/rocket1.PNG" width="300px"/> <img src="http://gfw-breaker.win/videos/imgs/easy-v2ray/rocket2.PNG" width="300px"/>

---

#### 免费V2RAY账号（友情提示：已屏蔽部分色情网站）, 用Ray客户端扫描下列二维码（务必将allowInsecure选项改为true）即可使用：

<img src="http://gfw-breaker.win/videos/imgs/v2ray-2.png" width="400px"/>

---



