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

echo "ALL EVARS TESTS PASSED!"
