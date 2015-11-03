#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
[ -z "${lib_dir}" ] && . ../../common.sh

create_tmp_vars() {
  [[ ! -d /tmp/vars ]] && mkdir -p /tmp/vars
  true
}

clean_tmp_vars() {
  [[ -d /tmp/vars ]] && rm -rf /tmp/vars
  true
}

# nos_set_evar
create_tmp_vars
nos_set_evar 'foo' 'bar'
if [ "${foo}" != "bar" ]; then
  echo "TEST ('nos_set_evar') FAILED!"
  false
fi
clean_tmp_vars

# nos_persist_evar
create_tmp_vars
nos_set_evar 'PL_env_dir_value' '/tmp/vars'
nos_persist_evar 'foo' 'bar'
if [ "$(cat /tmp/vars/foo)" != "bar" ]; then
  echo "TEST ('nos_persist_evar') FAILED!"
  false
fi
clean_tmp_vars

# nos_set_evars
create_tmp_vars
nos_set_evar 'PL_env_nodes' 'bar,free'
nos_set_evar 'PL_env_bar_value' 'foo'
nos_set_evar 'PL_env_free_value' 'food'
nos_set_evars
if [ "${bar}" != "foo" ] || [ "${free}" != "food" ]; then
  echo "TEST ('nos_set_evars') FAILED!"
  false
fi
clean_tmp_vars

# nos_persist_evars
create_tmp_vars
nos_persist_evars
if [ "$(cat /tmp/vars/bar)" != "foo" ] || [ "$(cat /tmp/vars/free)" != "food" ]; then
  echo "TEST ('nos_persist_evars') FAILED!"
  false
fi
clean_tmp_vars

# nos_set_evars_whitelist
create_tmp_vars
nos_set_evar 'PL_env_nodes' 'apple,orange,play,swing'
nos_set_evar 'PL_env_apple_value' 'apple'
nos_set_evar 'PL_env_orange_value' 'orange'
nos_set_evar 'PL_env_play_value' 'ground'
nos_set_evar 'PL_env_swing_value' 'set'
nos_set_evars_whitelist 'play|swing'
if [ "${play}" != "ground" ] || [ "${swing}" != "set" ] || [ -n "${apple}" ] || [ -n "${orange}" ]; then
  echo "TEST ('nos_set_evars_whitelist') FAILED!"
  false
fi
clean_tmp_vars

# nos_persist_evars_whitelist
create_tmp_vars
nos_persist_evars_whitelist 'play|swing'
if [ "$(cat /tmp/vars/play)" != "ground" ] || [ "$(cat /tmp/vars/swing)" != "set" ] || [ -a /tmp/vars/apple ] || [ -a /tmp/vars/orange ]; then
  echo "TEST ('nos_persist_evars_whitelist') FAILED!"
  false
fi
clean_tmp_vars

# nos_set_evars_blacklist
create_tmp_vars
nos_set_evar 'play' ''
nos_set_evar 'swing' ''
nos_set_evars_blacklist 'play|swing'
if [ "${apple}" != "apple" ] || [ "${orange}" != "orange" ] || [ -n "${play}" ] || [ -n "${swing}" ]; then
  echo "TEST ('nos_set_evars_blacklist') FAILED!"
  false
fi
clean_tmp_vars

# nos_persist_evars_blacklist
create_tmp_vars
nos_persist_evars_blacklist 'play|swing'
if [ "$(cat /tmp/vars/apple)" != "apple" ] || [ "$(cat /tmp/vars/orange)" != "orange" ] || [ -a /tmp/vars/play ] || [ -a /tmp/vars/swing ]; then
  echo "TEST ('nos_persist_evars_blacklist') FAILED!"
  false
fi
clean_tmp_vars

# nos_environment
nos_set_evar 'platform' 'local'
if [ "$(nos_environment)" != "development" ]; then
  echo "TEST ('nos_environment') FAILED!"
  false
fi

echo "ALL EVARS TESTS PASSED!"
