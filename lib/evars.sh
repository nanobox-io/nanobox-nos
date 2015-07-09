# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# set_evar(2)
# 
# $1 = key
# $2 = value
# 
# Sets an environment variable which will be available to the process that
# the code runs in after a successful deploy.
set_evar() {
  env_dir=$(payload 'env_dir')
  echo $2 > ${env_dir}/$1
}

# whitelist_evars(1)
# 
# $1 = whitelist regex
# 
# Sets environment variables which will be available to the process that
# the code runs in, from the payload, according the the whitelist.
whitelist_evars() {
  evars=(${PL_env_nodes//,/ })
  for evar in "${evars[@]}"; do
    echo $evar | grep -E $1 && set_evar $evar $(payload "env_${evar}")
  done
}

# blacklist_evars(1)
# 
# $1 = blacklist regex
# 
# Sets environment variables which will be available to the process that
# the code runs in, from the payload, according the the blacklist.
blacklist_evars() {
  evars=(${PL_env_nodes//,/ })
  for evar in "${evars[@]}"; do
    echo $evar | grep -E $1 || set_evar $evar $(payload "env_${evar}")
  done
}