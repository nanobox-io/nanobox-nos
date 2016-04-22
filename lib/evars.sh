# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# nos_set_evar(2)
#
# $1 = key
# $2 = value
#
# Sets an environment variable in the running process
nos_set_evar() {
  export "${1}=${2}"
}

# nos_persist_evar(2)
#
# $1 = key
# $2 = value
#
# Persists an environment variable which will be available to the process that
# the code runs in after a successful deploy.
nos_persist_evar() {
  env_dir=$(nos_payload 'env_dir')
  echo $2 > ${env_dir}/$1
}
