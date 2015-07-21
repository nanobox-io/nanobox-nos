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

# run_process(2)
#
# $1 = process label
# $2 = command
#
# A helper to run a process and format the output according to the styleguide
run_process() {
  print_process_start "${1}"
  $2 2>&1 | grep '\S' | sed -e 's/\r//g;s/^/   /'
  print_process_end
}

# run_subprocess(2)
#
# $1 = process label
# $2 = command
#
# # A helper to run a subprocess and format the output according to the styleguide
run_subprocess() {
  print_subtask_start "${1}"
  echo "   $ ${2}"
  $2 2>&1 | grep '\S' | sed -e 's/\r//g;s/^/   /'
  if [ $? -eq 0 ]; then
    print_subtask_success
  else
    print_subtask_fail
  fi
}

# validate_presence(1)
#
# $1 = field
#
# Validate that a field exists within the boxfile payload and has a value.
# If the check fails, a fatal error will be printed an a non-zero exit
# will be forced.
validate_presence() {
  if [ -z $(payload "$1") ]; then
    label=${1/boxfile_build/}
    print_fatal "value required" "Boxfile 'build' section requires ${label} to exist and have a value to continue"
    exit 1
  fi
}

# validate_in(2)
#
# $1 = field
# $2 = possible values
#
# Validates that if a field exists, the value present falls within a range
# of acceptable options.
validate_in() {
  field=$1
  options=$2
  pass=0

  for option in $options; do
    if [ "$(payload "${field}")" = "$option" ]; then
      pass=1
    fi
  done

  if [ $pass = 0 ]; then
    label=${field/boxfile_build/}
    message_opts=""

    for option in $options; do
      if [ -n $message_opts ]; then
        message_opts="${message_opts}, "
      fi
      message_opts="${message_opts}${option}"
    done

    message="Boxfile 'build' section attribute $label value must be one of the following: ${message_opts}"

    print_fatal "invalid value", "${message}"
    exit 1
  fi
}

# validate_not_in(2)
#
# $1 = field
# $2 = possible values
#
# Validates that if a field exists, the value present falls does not fall
# within a range of options.
validate_not_in() {
  field=$1
  options=$2
  pass=1

  for option in $options; do
    if [ "$(payload "${field}")" = "$option" ]; then
      pass=0
    fi
  done

  if [ $pass = 0 ]; then
    label=${field/boxfile_build/}
    message_opts=""

    for option in $options; do
      if [ -n $message_opts ]; then
        message_opts="${message_opts}, "
      fi
      message_opts="${message_opts}${option}"
    done

    message="Boxfile 'build' section attribute $label value must not be one of the following: ${message_opts}"

    print_fatal "invalid value", "${message}"
    exit 1
  fi
}
