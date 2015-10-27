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

echo "ALL PAYLOAD TESTS PASSED!"
