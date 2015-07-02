# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# install(1)
# 
# $1 = package name
# 
# A simple expressive shortcut to install a pkgsrc package via pkgin
install() {
  pkgin -y in $1
}
