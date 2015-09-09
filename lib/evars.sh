# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# set_evar(2)
#
# $1 = key
# $2 = value
#
# Sets an environment variable in the running process
set_evar() {
  env_dir=$(payload 'env_dir')
  export "${2}=${1}"
}

# persist_evar(2)
#
# $1 = key
# $2 = value
#
# Persists an environment variable which will be available to the process that
# the code runs in after a successful deploy.
persist_evar() {
  env_dir=$(payload 'env_dir')
  echo $2 > ${env_dir}/$1
}

# set_evars(0)
#
# Sets all environment variables from the payload in the running process.
set_evars() {
  evars=(${PL_env_nodes//,/ })
  for evar in "${evars[@]}"; do
    echo $evar | grep -E $1 && set_evar $evar $(payload "env_${evar}")
  done
}

# persist_evars(0)
#
# Persists all environment variables from the payload to be available to the
# process that the code runs in.
persist_evars() {
  evars=(${PL_env_nodes//,/ })
  for evar in "${evars[@]}"; do
    echo $evar | persist_evar $evar $(payload "env_${evar}")
  done
}

# set_evars_whitelist(1)
#
# $1 = whitelist regex
#
# Sets an environment variable in the running process, from the payload,
# according the the whitelist.
set_evars_whitelist() {
  evars=(${PL_env_nodes//,/ })
  for evar in "${evars[@]}"; do
    echo $evar | grep -E $1 && set_evar $evar $(payload "env_${evar}")
  done
}

# persist_evars_whitelist(1)
#
# $1 = whitelist regex
#
# Persists environment variables from the payload to be available to the
# process that the code runs in, according the the whitelist.
persist_evars_whitelist() {
  evars=(${PL_env_nodes//,/ })
  for evar in "${evars[@]}"; do
    echo $evar | grep -E $1 && persist_evar $evar $(payload "env_${evar}")
  done
}

# set_evars_blacklist(1)
#
# $1 = blacklist regex
#
# Sets an environment variable in the running process, from the payload,
# according the the blacklist.
set_evars_blacklist() {
  evars=(${PL_env_nodes//,/ })
  for evar in "${evars[@]}"; do
    echo $evar | grep -E $1 || set_evar $evar $(payload "env_${evar}")
  done
}

# persist_evars_blacklist(1)
#
# $1 = blacklist regex
#
# Persists environment variables from the payload to be available to the
# process that the code runs in, according the the blacklist.
persist_evars_blacklist() {
  evars=(${PL_env_nodes//,/ })
  for evar in "${evars[@]}"; do
    echo $evar | grep -E $1 || persist_evar $evar $(payload "env_${evar}")
  done
}
