#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
[ -z "${lib_dir}" ] && . ../../common.sh

MD5_COMMAND=$(which md5sum || echo md5)

# nos_run_process
out=$(nos_run_process "hello"   "true" 2>&1)
echo "$out" | grep HELLO &> /dev/null || (echo "TEST ('run_proc hello') FAILED!"; false)

# nos_run_subprocess false
out=$(nos_run_subprocess "exit bad"   "false" 2>&1)
echo "$out" | grep -i failed &> /dev/null || (echo "TEST ('run_sub exit bad') FAILED!"; false)

# nos_run_subprocess true
out=$(nos_run_subprocess "exit clean" "true" 2>&1)
echo "$out" | grep -i succ &> /dev/null || (echo "TEST ('run_sub exit clean') FAILED!"; false)

echo "ALL RUN TESTS PASSED!"
