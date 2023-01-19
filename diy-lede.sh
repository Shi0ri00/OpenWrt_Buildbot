#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-script.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================

# Clear the login password
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings

# 修改默认IP
sed -i 's/192.168.1.1/10.0.0.2/g' package/base-files/files/bin/config_generate

# 移除重复软件包
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/packages/net/v2ray-geodata

# 科学上网
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
git clone https://github.com/xiaorouji/openwrt-passwall.git -b packages package/passwall_package
git clone https://github.com/xiaorouji/openwrt-passwall.git -b luci package/passwall
cp -rf package/passwall_package/* package/passwall
rm -rf package/passwall_package
git clone https://github.com/xiaorouji/openwrt-passwall2 package/passwall2

# Themes
git clone --depth 1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
git clone --depth 1 https://github.com/thinktip/luci-theme-neobird package/luci-theme-neobird

# 晶晨宝盒
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic
sed -i "s|https.*/OpenWrt|https://github.com/RustyCore856/OpenWrt|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|opt/kernel|https://github.com/ophub/kernel/tree/main/pub/stable|g" package/luci-app-amlogic/root/etc/config/amlogic

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
