# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# nos_validate_presence(1)
#
# $1 = field
#
# Validate that a field exists within the boxfile payload and has a value.
# If the check fails, a fatal error will be printed an a non-zero exit
# will be forced.
nos_validate_presence() {
  if [ -z $(nos_payload "$1") ]; then
    label=${1/boxfile_build/}
    nos_print_fatal "value required" "Boxfile 'build' section requires '${label}' to exist and have a value to continue"
    exit 1
  fi
}

# nos_validate_in(2)
#
# $1 = field
# $2 = possible values
#
# Validates that if a field exists, the value present falls within a range
# of acceptable options.
nos_validate_in() {
  field=$1
  options=$2
  pass=0

  for option in $options; do
    if [ "$(nos_payload "${field}")" = "$option" ]; then
      pass=1
    fi
  done

  if [ $pass = 0 ]; then
    label=${field/boxfile_build/}
    message_opts=""

    for option in $options; do
      if [ -n "$message_opts" ]; then
        message_opts="${message_opts}, "
      fi
      message_opts="${message_opts}${option}"
    done

    message="Boxfile 'build' section attribute '$label' value must be one of the following: ${message_opts}"

    nos_print_fatal "invalid value", "${message}"
    exit 1
  fi
}

# nos_validate_not_in(2)
#
# $1 = field
# $2 = possible values
#
# Validates that if a field exists, the value present falls does not fall
# within a range of options.
nos_validate_not_in() {
  field=$1
  options=$2
  pass=1

  for option in $options; do
    if [ "$(nos_payload "${field}")" = "$option" ]; then
      pass=0
    fi
  done

  if [ $pass = 0 ]; then
    label=${field/boxfile_build/}
    message_opts=""

    for option in $options; do
      if [ -n "$message_opts" ]; then
        message_opts="${message_opts}, "
      fi
      message_opts="${message_opts}${option}"
    done

    message="Boxfile 'build' section attribute '$label' value must NOT be one of the following: ${message_opts}"

    nos_print_fatal "invalid value", "${message}"
    exit 1
  fi
}

# nos_valid_integer(1)
#
# $1 = value
#
# Validates that a value is an integer.
nos_valid_integer() {
  [[ "$1" =~ ^[0-9]+$ ]] && return 1
  return 0
}

# nos_valid_file(1)
#
# $1 = value
#
# Validates that a value is a file.
nos_valid_file() {
  [[ "$1" =~ ^\/?[^\/]+(\/[^\/]+)*$ ]] && return 1
  return 0
}

# nos_valid_folder(1)
#
# $1 = value
#
# Validates that a value is a folder.
nos_valid_folder() {
  [[ "$1" =~ ^\/?[^\/]+(\/[^\/]+)*\/?$ ]] && return 1
  return 0
}

# nos_valid_boolean(1)
#
# $1 = value
#
# Validates that a value is a boolean.
nos_valid_boolean() {
  [[ "$1" = 'true' ]] && return 1
  [[ "$1" = 'false' ]] && return 1
  [[ "$1" =~ ^[Oo]n$ ]] && return 1
  [[ "$1" =~ ^[Oo]ff$ ]] && return 1
  [[ $1 -eq 1 ]] && return 1
  [[ $1 -eq 0 ]] && return 1
  return 0
}

# nos_valid_byte(1)
#
# $1 = value
#
# Validates that a value is a byte.
nos_valid_byte() {
  [[ "$1" =~ ^[0-9]+[BbKkMmGgTt]?$ ]] && return 1
  return 0
}

# nos_valid_string(1)
#
# $1 = value
#
# Validates that a value is a string.
nos_valid_string() {
  return 1
}

# nos_validate(3)
#
# $1 = value
# $2 = type
# $3 = default
#
# Validates that a value is a certain type and sets a default value if one
# is not set.
nos_validate() {
  [[ -z $1 ]] && echo $3 && return
  $(eval nos_valid_$2 $1)
  [[ $? -eq 1 ]] && echo $1 && return
  >&2 echo "Error: value \"$1\" is invalid $2"
  exit 1
}
