#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
[ -z "${lib_dir}" ] && . ../../common.sh

MD5_COMMAND=$(which md5sum || echo md5)

# nos_run_process
out=$(nos_run_process "hello"   "true" 2>&1)
echo "$out" | grep HELLO &> /dev/null || (echo "TEST ('run_process hello') FAILED!"; false)

echo "ALL RUN TESTS PASSED!"
