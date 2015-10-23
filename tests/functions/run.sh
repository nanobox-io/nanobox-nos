#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
. ../../common.sh

out=$(run_process "hello"   "true")
echo "$out" | grep HELLO &> /dev/null || (echo "TEST ('run proc hello') FAILED!"; false)

out=$(run_subprocess "exit bad"   "false")
echo "$out" | grep -i failed &> /dev/null || (echo "TEST ('run sub exit bad') FAILED!"; false)

out=$(run_subprocess "exit clean" "true")
echo "$out" | grep -i succ &> /dev/null || (echo "TEST ('run sub exit clean') FAILED!"; false)

echo "ALL TESTS PASSED!"