#!/bin/bash

#预置HomeProxy列表
if [ -d *"homeproxy"* ]; then
	git clone --depth=5 --single-branch --branch "master" https://github.com/1715173329/IPCIDR-CHINA.git ./ip
	git clone --depth=1 --single-branch --branch "release" https://github.com/Loyalsoldier/v2ray-rules-dat.git ./list

	HP_PATCH="../homeproxy/root/etc/homeproxy/resources"

	cd ./ip
	echo $(git log -1 --pretty=format:'%s' -- ipv4.txt | grep -o "[0-9]*") > ipv4.ver
	echo $(git log -1 --pretty=format:'%s' -- ipv6.txt | grep -o "[0-9]*") > ipv6.ver
	cp -f ipv4.txt $HP_PATCH/china_ip4.txt
	cp -f ipv4.ver $HP_PATCH/china_ip4.ver
	cp -f ipv6.txt $HP_PATCH/china_ip6.txt
	cp -f ipv6.ver $HP_PATCH/china_ip6.ver

	cd ../list
	echo $(git log -1 --pretty=format:'%s' | grep -o "[0-9]*") > gfw.ver
	echo $(git log -1 --pretty=format:'%s' | grep -o "[0-9]*") > direct-list.ver
	cp -f gfw.txt $HP_PATCH/gfw_list.txt
	cp -f gfw.ver $HP_PATCH/gfw_list.ver
	cp -f direct-list.txt $HP_PATCH/china_list.txt
	cp -f direct-list.ver $HP_PATCH/china_list.ver

	cd ..
	rm -rf ./ip ./list
fi

#预置OpenClash内核和GEO数据
if [ -d *"OpenClash"* ]; then
	CORE_VER=https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/core_version
	CORE_TUN=https://github.com/vernesong/OpenClash/raw/core/dev/premium/clash-linux
	CORE_DEV=https://github.com/vernesong/OpenClash/raw/core/dev/dev/clash-linux
	CORE_MATE=https://github.com/vernesong/OpenClash/raw/core/dev/meta/clash-linux

	CORE_TYPE=$(echo $OWRT_TARGET | egrep -iq "64|86" && echo "amd64" || echo "arm64")
	TUN_VER=$(curl -sfL $CORE_VER | sed -n "2{s/\r$//;p;q}")

	GEO_MMDB=https://github.com/alecthw/mmdb_china_ip_list/raw/release/lite/Country.mmdb
	GEO_SITE=https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geosite.dat
	GEO_IP=https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geoip.dat
	META_DB=https://github.com/MetaCubeX/meta-rules-dat/raw/release/geoip.metadb

	cd ./OpenClash/luci-app-openclash/root/etc/openclash

	curl -sfL -o ./Country.mmdb $GEO_MMDB
	curl -sfL -o ./GeoSite.dat $GEO_SITE
	curl -sfL -o ./GeoIP.dat $GEO_IP
	curl -sfL -o ./GeoIP.metadb $META_DB

	mkdir ./core && cd ./core

	curl -sfL -o ./tun.gz "$CORE_TUN"-"$CORE_TYPE"-"$TUN_VER".gz
	gzip -d ./tun.gz && mv ./tun ./clash_tun

	curl -sfL -o ./meta.tar.gz "$CORE_MATE"-"$CORE_TYPE".tar.gz
	tar -zxf ./meta.tar.gz && mv ./clash ./clash_meta

	curl -sfL -o ./dev.tar.gz "$CORE_DEV"-"$CORE_TYPE".tar.gz
	tar -zxf ./dev.tar.gz

	chmod +x ./clash*
	rm -rf ./*.gz
fi
