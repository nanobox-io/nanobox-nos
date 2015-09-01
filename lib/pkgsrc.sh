# install(1)
#
# $1 = package name
#
# A simple expressive shortcut to install a pkgsrc package via pkgin
install() {
  run_subprocess "installing ${1}" "pkgin -y in $1"
}

