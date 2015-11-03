#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
[ -z "${lib_dir}" ] && . ../../common.sh

# eval_payload
eval_payload '{"foo":"bar", "play": ["ground","school","dough"]}'
[ -n "${PL_foo_value}" ] || (echo "TEST ('eval_payload') FAILED!"; false)

# payload array
play=$(payload 'play')
if [[ "${play}" != 'ground school dough' ]]; then
  echo "TEST ('payload array') FAILED!"
  false
fi

# payload string
foo=$(payload 'foo')
if [[ "${foo}" != 'bar' ]]; then
  echo "TEST ('payload string') FAILED!"
  false
fi

# nos_app_name
nos_set_evar 'PL_app_value' 'test-app'
if [[ "$(nos_app_name)" != "test-app" ]]; then
  echo "TEST ('nos_app_name') FAILED!"
  false
fi

# nos_live_dir
nos_set_evar 'PL_live_dir_value' 'test-live'
if [[ "$(nos_live_dir)" != "test-live" ]]; then
  echo "TEST ('nos_live_dir') FAILED!"
  false
fi

# nos_deploy_dir
nos_set_evar 'PL_deploy_dir_value' 'test-deploy'
if [[ "$(nos_deploy_dir)" != "test-deploy" ]]; then
  echo "TEST ('nos_deploy_dir') FAILED!"
  false
fi

# nos_etc_dir
nos_set_evar 'PL_etc_dir_value' 'test-etc'
if [[ "$(nos_etc_dir)" != "test-etc" ]]; then
  echo "TEST ('nos_etc_dir') FAILED!"
  false
fi

# nos_code_dir
nos_set_evar 'PL_code_dir_value' 'test-code'
if [[ "$(nos_code_dir)" != "test-code" ]]; then
  echo "TEST ('nos_code_dir') FAILED!"
  false
fi

echo "ALL PAYLOAD TESTS PASSED!"
