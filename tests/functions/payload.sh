#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
[ -z "${lib_dir}" ] && . ../../common.sh

# nos_eval_payload
nos_eval_payload '{"foo":"bar", "play": ["ground","school","dough"]}'
[ -n "${PL_foo_value}" ] || (echo "TEST ('nos_eval_payload') FAILED!"; false)

# nos_payload array
play=$(nos_payload 'play')
if [[ "${play}" != 'ground school dough' ]]; then
  echo "TEST ('nos_payload array') FAILED!"
  false
fi

# nos_payload string
foo=$(nos_payload 'foo')
if [[ "${foo}" != 'bar' ]]; then
  echo "TEST ('nos_payload string') FAILED!"
  false
fi

# nos_app_name
export "PL_app_value=test-app"
if [[ "$(nos_app_name)" != "test-app" ]]; then
  echo "TEST ('nos_app_name') FAILED!"
  false
fi

# nos_live_dir
export "PL_live_dir_value=test-live"
if [[ "$(nos_live_dir)" != "test-live" ]]; then
  echo "TEST ('nos_live_dir') FAILED!"
  false
fi

# nos_deploy_dir
export "PL_deploy_dir_value=test-deploy"
if [[ "$(nos_deploy_dir)" != "test-deploy" ]]; then
  echo "TEST ('nos_deploy_dir') FAILED!"
  false
fi

# nos_etc_dir
export "PL_etc_dir_value=test-etc"
if [[ "$(nos_etc_dir)" != "test-etc" ]]; then
  echo "TEST ('nos_etc_dir') FAILED!"
  false
fi

# nos_code_dir
export "PL_code_dir_value=test-code"
if [[ "$(nos_code_dir)" != "test-code" ]]; then
  echo "TEST ('nos_code_dir') FAILED!"
  false
fi

# nos_cache_dir
export "PL_cache_dir_value=test-cache"
if [[ "$(nos_cache_dir)" != "test-cache" ]]; then
  echo "TEST ('nos_cache_dir') FAILED!"
  false
fi

echo "ALL PAYLOAD TESTS PASSED!"
