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

# nos_set_evars(0)
#
# Sets all environment variables from the payload in the running process.
nos_set_evars() {
  evars=(${PL_env_nodes//,/ })
  for evar in "${evars[@]}"; do
    nos_set_evar $evar $(nos_payload "env_${evar}")
  done
}

# nos_persist_evars(0)
#
# Persists all environment variables from the payload to be available to the
# process that the code runs in.
nos_persist_evars() {
  evars=(${PL_env_nodes//,/ })
  for evar in "${evars[@]}"; do
    nos_persist_evar $evar $(nos_payload "env_${evar}")
  done
}

# nos_set_evars_whitelist(1)
#
# $1 = whitelist regex
#
# Sets an environment variable in the running process, from the payload,
# according the the whitelist.
nos_set_evars_whitelist() {
  evars=(${PL_env_nodes//,/ })
  for evar in "${evars[@]}"; do
    echo $evar | grep -E "${1}" &> /dev/null && nos_set_evar $evar $(nos_payload "env_${evar}")
  done
}

# nos_persist_evars_whitelist(1)
#
# $1 = whitelist regex
#
# Persists environment variables from the payload to be available to the
# process that the code runs in, according the the whitelist.
nos_persist_evars_whitelist() {
  evars=(${PL_env_nodes//,/ })
  for evar in "${evars[@]}"; do
    echo $evar | grep -E "${1}" &> /dev/null && nos_persist_evar $evar $(nos_payload "env_${evar}")
  done
}

# nos_set_evars_blacklist(1)
#
# $1 = blacklist regex
#
# Sets an environment variable in the running process, from the payload,
# according the the blacklist.
nos_set_evars_blacklist() {
  evars=(${PL_env_nodes//,/ })
  for evar in "${evars[@]}"; do
    echo $evar | grep -E "${1}" &> /dev/null || nos_set_evar $evar $(nos_payload "env_${evar}")
  done
}

# nos_persist_evars_blacklist(1)
#
# $1 = blacklist regex
#
# Persists environment variables from the payload to be available to the
# process that the code runs in, according the the blacklist.
nos_persist_evars_blacklist() {
  evars=(${PL_env_nodes//,/ })
  for evar in "${evars[@]}"; do
    echo $evar | grep -E "${1}" &> /dev/null || nos_persist_evar $evar $(nos_payload "env_${evar}")
  done
}
