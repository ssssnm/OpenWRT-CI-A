#!/bin/bash

#精简git命令
CLONE="git clone --depth=1 --single-branch"

#Design Theme
$CLONE --branch $(echo $OWRT_URL | grep -iq "lede" && echo "main" || echo "js") https://github.com/gngpp/luci-theme-design.git
$CLONE https://github.com/gngpp/luci-app-design-config.git
#Argon Theme
$CLONE --branch $(echo $OWRT_URL | grep -iq "lede" && echo "18.06" || echo "master") https://github.com/jerrykuku/luci-theme-argon.git
$CLONE --branch $(echo $OWRT_URL | grep -iq "lede" && echo "18.06" || echo "master") https://github.com/jerrykuku/luci-app-argon-config.git

#Pass Wall
#$CLONE https://github.com/kenzok8/small-package.git
#$CLONE https://github.com/kenzok8/small.git
$CLONE https://github.com/xiaorouji/openwrt-passwall.git
$CLONE https://github.com/xiaorouji/openwrt-passwall2.git
$CLONE https://github.com/xiaorouji/openwrt-passwall-packages.git

#Open Clash
$CLONE --branch "dev" https://github.com/vernesong/OpenClash.git

#Hello World
[[ $OWRT_URL == *"lede"* ]] && $CLONE --branch "main" https://github.com/fw876/helloworld.git

#Home Proxy
[[ $OWRT_URL == *"immortalwrt"* ]] && $CLONE --branch "mdev" https://github.com/muink/homeproxy.git

#adguardhome
git clone --depth=1 --single-branch https://github.com/xiaoxiao29/luci-app-adguardhome.git

#ddns-go
#git clone --depth=1 --single-branch https://github.com/sirpdboy/luci-app-ddns-go.git

#ssr-plus
git clone --depth=1 --single-branch https://github.com/kenzok8/small.git

#git clone --depth=1 --single-branch https://github.com/kenzok8/small-package.git
#git clone --depth=1 --single-branch https://github.com/fw876/helloworld.git
