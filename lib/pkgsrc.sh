# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# nos_install(1+)
#
# $@ = list of packages by name
#
# A simple expressive shortcut to install a pkgsrc package via pkgin
nos_install() {
  nos_print_bullet "installing $(nos_package_label "$@")..."
  res=$(pkgin -y in "$@")

  if [[ ! "$?" = "0" ]]; then
    nos_print_fatal "failed to nos_install package(s)" "${res}"
    exit 1
  fi
}

# nos_install_verbose(1+)
# 
# $@ = list of packages by name
# 
# A simple expressive shortcut to install a pkgsrc package via pkgin,
# verbosely displaying output
nos_install_verbose() {
  nos_run_subprocess "installing $(nos_package_label "$@")" "pkgin -y in $@"
}

# nos_install_build(1)
#
# $1 = package name
#
# A simple expressive shortcut to install a pkgsrc package via pkgin
# for the build phase only
nos_install_build() {
  mkdir -p /var/db/nos
  echo $1 >> /var/db/nos/build.db
  nos_run_subprocess "installing ${1}" "pkgin -y in $1"
}

# nos_install_cleanup(0)
# 
# Uninstall all of the packages that were installed with "install_build"
nos_install_cleanup() {
  echo "Not implemented"
}

# nos_package_label(1+)
# 
# $@ = list of packages by name
# 
# Returns a string of packages separated by commas, with an "and" before
# the last item
nos_package_label() {
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
      # two?
      elif [[ $i -eq $count ]] && [[ $count -eq 2 ]]; then
        label="${label} and ${arg}"
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