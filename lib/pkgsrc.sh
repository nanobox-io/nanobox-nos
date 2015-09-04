# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# install(1)
#
# $1 = package name
#
# A simple expressive shortcut to install a pkgsrc package via pkgin
install() {
  run_subprocess "installing ${1}" "pkgin -y in $1"
}

# install_build(1)
#
# $1 = package name
#
# A simple expressive shortcut to install a pkgsrc package via pkgin
# for the build phase only
install_build() {
  mkdir -p /var/db/nos
  echo $1 >> /var/db/nos/build.db
  run_subprocess "installing ${1}" "pkgin -y in $1"
}

# install_cleanup(0)
# 
# Uninstall all of the packages that were installed with "install_build"
install_cleanup() {
  
}