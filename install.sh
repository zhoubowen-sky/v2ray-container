#!/bin/sh

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin

# 设置 ntp 时间服务器
yum install -y ntpdate
ntpdate -u cn.pool.ntp.org
timedatectl set-timezone Asia/Shanghai
echo "时间已调整为北京时区"

# 安装 v2ray 服务端
install -y zip unzip wget
wget https://install.direct/go.sh
bash go.sh
echo "v2ray 已完成安装"

systemctl stop firewalld
systemctl disable firewalld
systemctl start v2ray
systemctl enable v2ray
echo "v2ray 启动，防火墙已关闭"

# 修改配置信息
cp -rf config/config_server.json /etc/v2ray/config.json
systemctl restart v2ray


# 重启服务器
reboot
