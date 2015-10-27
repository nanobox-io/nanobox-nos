#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
[ -z "${lib_dir}" ] && . ../../common.sh

# set_evar
set_evar 'foo' 'bar'
if [ "${foo}" != "bar" ]; then
  echo "TEST ('set_evar') FAILED!"
  false
fi

# persist_evar
[ -d /tmp/vars ] || mkdir /tmp/vars
set_evar 'PL_env_dir_value' '/tmp/vars'
persist_evar 'foo' 'bar'
if [ "$(cat /tmp/vars/foo)" != "bar" ]; then
  echo "TEST ('persist_evar') FAILED!"
  false
fi

# set_evars
set_evar 'PL_env_nodes' 'bar,free'
set_evar 'PL_env_bar_value' 'foo'
set_evar 'PL_env_free_value' 'food'
set_evars
if [ "${bar}" != "foo" ] || [ "${free}" != "food" ]; then
  echo "TEST ('set_evars') FAILED!"
  false
fi

# persist_evars
persist_evars
if [ "$(cat /tmp/vars/bar)" != "foo" ] || [ "$(cat /tmp/vars/free)" != "food" ]; then
  echo "TEST ('persist_evars') FAILED!"
  false
fi

# set_evars_whitelist
set_evar 'PL_env_nodes' 'apple,orange,play,swing'
set_evar 'PL_env_apple_value' 'apple'
set_evar 'PL_env_orange_value' 'orange'
set_evar 'PL_env_play_value' 'ground'
set_evar 'PL_env_swing_value' 'set'
set_evars_whitelist 'play|swing'
if [ "${play}" != "ground" ] || [ "${swing}" != "set" ] || [ -n "${apple}" ] || [ -n "${orange}" ]; then
  echo "TEST ('set_evars_whitelist') FAILED!"
  false
fi

# persist_evars_whitelist
persist_evars_whitelist 'play|swing'
if [ "$(cat /tmp/vars/play)" != "ground" ] || [ "$(cat /tmp/vars/swing)" != "set" ] || [ -a /tmp/vars/apple ] || [ -a /tmp/vars/orange ]; then
  echo "TEST ('persist_evars_whitelist') FAILED!"
  false
fi

# set_evars_blacklist
set_evar 'play' ''
set_evar 'swing' ''
set_evars_blacklist 'play|swing'
if [ "${apple}" != "apple" ] || [ "${orange}" != "orange" ] || [ -n "${play}" ] || [ -n "${swing}" ]; then
  echo "TEST ('set_evars_blacklist') FAILED!"
  false
fi

# persist_evars_blacklist
rm /tmp/vars/play /tmp/vars/swing
persist_evars_blacklist 'play|swing'
if [ "$(cat /tmp/vars/apple)" != "apple" ] || [ "$(cat /tmp/vars/orange)" != "orange" ] || [ -a /tmp/vars/play ] || [ -a /tmp/vars/swing ]; then
  echo "TEST ('persist_evars_blacklist') FAILED!"
  false
fi

echo "ALL EVARS TESTS PASSED!"
