#!/bin/bash

# Clear the login password
sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings

# 修改默认IP
sed -i 's/192.168.1.1/10.0.0.2/g' package/base-files/files/bin/config_generate

# 移除包
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/packages/net/v2ray-geodata

# 科学上网
git clone --depth=1 https://github.com/fw876/helloworld package/luci-app-ssr-plus
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/openwrt-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-package package/openwrt-passwall-package
svn export https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall package/luci-app-passwall
svn export https://github.com/xiaorouji/openwrt-passwall2/trunk/luci-app-passwall2 package/luci-app-passwall2
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash

# Theme
git clone --depth 1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# 晶晨宝盒
svn export https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic
sed -i "s|firmware_repo.*|firmware_repo'https://github.com/RustyCore856/OpenWrt'|g" package/luci-app-amlogic/root/etc/config/amlogic
# sed -i "s|kernel_path.*|kernel_path 'https://github.com/ophub/kernel'|g" package/luci-app-amlogic/root/etc/config/amlogic

# MosDNS
git clone https://github.com/sbwml/luci-app-mosdns package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# Alist
git clone https://github.com/sbwml/luci-app-alist package/alist

# 调整 ZeroTier 到 服务 菜单
sed -i '/"VPN"/d' feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua
sed -i 's/vpn/services/g' feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua
sed -i 's/vpn/services/g' feeds/luci/applications/luci-app-zerotier/luasrc/view/zerotier/zerotier_status.htm


./scripts/feeds update -a
./scripts/feeds install -a
