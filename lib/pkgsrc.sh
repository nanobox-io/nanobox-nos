# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# nos_install(1+)
#
# $@ = list of packages by name
#
# A simple expressive shortcut to install a pkgsrc package via pkgin
nos_install() {
  nos_run_subprocess "installing $(nos_package_label "$@")" "pkgin -y in $@"
}

# nos_uninstall(1+)
#
# $@ = list of packages by name
#
# A simple expressive shortcut to uninstall a pkgsrc package via pkgin
nos_uninstall() {
  nos_run_subprocess "uninstalling $(nos_package_label "$@")" "pkgin -y rm $@"
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
