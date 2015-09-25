# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# install(1+)
#
# $@ = list of packages by name
#
# A simple expressive shortcut to install a pkgsrc package via pkgin
install() {
  print_bullet "Installing $(package_label "$@")..."
  res=$(pkgin -y in "$@")

  if [[ ! "$?" = "0" ]]; then
    print_fatal "failed to install package(s)" "${res}"
    exit 1
  fi
}

# install_verbose(1+)
# 
# $@ = list of packages by name
# 
# A simple expressive shortcut to install a pkgsrc package via pkgin,
# verbosely displaying output
install_verbose() {
  run_subprocess "Installing $(package_label "$@")" "pkgin -y in $@" 
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
  run_subprocess "Installing ${1}" "pkgin -y in $1"
}

# install_cleanup(0)
# 
# Uninstall all of the packages that were installed with "install_build"
install_cleanup() {
  echo "Not implemented"
}

# package_label(1+)
# 
# $@ = list of packages by name
# 
# Returns a string of packages separated by commas, with an "and" before
# the last item
package_label() {
  count=$#
  label=""

  if [[ $count -eq 1 ]]; then
    label=$1
  else
    i=1
    for arg in "$@"; do
      # first?
      if [[ $i -eq 1 ]]; then
        label=$arg
      # last?
      elif [[ $i -eq $count ]]; then
        label="${label}, and ${arg}"
      # middle ?
      else
        label="${label}, ${arg}"
      fi
      let i++
    done
  fi

  echo $label
}