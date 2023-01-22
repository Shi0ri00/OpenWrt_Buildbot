#!/bin/bash

# Set default theme to luci-theme-argon
uci set luci.main.mediaurlbase='/luci-static/argon'
uci commit luci

# Disable IPV6 ula prefix
sed -i 's/^[^#].*option ula/#&/' /etc/config/network

# TTYD auto login
sed -i 's/\/bin\/login/\/bin\/login -f root/' /etc/init.d/ttyd

exit 0
