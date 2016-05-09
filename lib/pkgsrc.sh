# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# nos_install(1+)
#
# $@ = list of packages by name
#
# A simple expressive shortcut to install a pkgsrc package via pkgin
nos_install() {
  nos_run_subprocess "installing packages" "pkgin -y in $(echo $@)"
}

# nos_uninstall(1+)
#
# $@ = list of packages by name
#
# A simple expressive shortcut to uninstall a pkgsrc package via pkgin
nos_uninstall() {
  nos_run_subprocess "uninstalling packages" "pkgin -y rm $(echo $@)"
}
