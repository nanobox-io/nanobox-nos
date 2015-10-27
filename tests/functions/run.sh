#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
[ -z "${lib_dir}" ] && . ../../common.sh

MD5_COMMAND=$(which md5sum || echo md5)

# run_process
out=$(run_process "hello"   "true" 2>&1)
echo "$out" | grep HELLO &> /dev/null || (echo "TEST ('run_proc hello') FAILED!"; false)

# run_subprocess false
out=$(run_subprocess "exit bad"   "false" 2>&1)
echo "$out" | grep -i failed &> /dev/null || (echo "TEST ('run_sub exit bad') FAILED!"; false)

# run_subprocess true
out=$(run_subprocess "exit clean" "true" 2>&1)
echo "$out" | grep -i succ &> /dev/null || (echo "TEST ('run_sub exit clean') FAILED!"; false)

# run_hooks string
set_evar 'PL_boxfile_before_exec_type' 'string'
set_evar 'PL_boxfile_before_exec_value' 'echo "hola gato"'
out=$(run_hooks 'before' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "da6c1da50cf6a118c89b1fa872a0ae70" ]]; then
  echo "TEST ('run_hooks string') FAILED! Got ${out}"
  false
fi

# run_hooks array
set_evar 'PL_boxfile_after_exec_type' 'array'
set_evar 'PL_boxfile_after_exec_length' '2'
set_evar 'PL_boxfile_after_exec_0_type' 'string'
set_evar 'PL_boxfile_after_exec_0_value' 'true'
set_evar 'PL_boxfile_after_exec_1_type' 'string'
set_evar 'PL_boxfile_after_exec_1_value' 'false'
out=$(run_hooks 'after' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "5f3f681f93de9b6de659fddd5c18e340" ]]; then
  echo "TEST ('run_hooks array') FAILED! Got ${out}"
  false
fi

echo "ALL RUN TESTS PASSED!"
