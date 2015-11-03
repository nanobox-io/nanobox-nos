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

echo "ALL PAYLOAD TESTS PASSED!"
