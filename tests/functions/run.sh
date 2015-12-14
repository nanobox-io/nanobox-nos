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

# nos_run_hooks string
nos_set_evar 'PL_boxfile_before_exec_type' 'string'
nos_set_evar 'PL_boxfile_before_exec_value' 'echo "hola gato"'
out=$(nos_run_hooks 'before' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "da6c1da50cf6a118c89b1fa872a0ae70" ]]; then
  echo "TEST ('nos_run_hooks string') FAILED! Got ${out}"
  false
fi

# nos_run_hooks array
nos_set_evar 'PL_boxfile_after_exec_type' 'array'
nos_set_evar 'PL_boxfile_after_exec_length' '2'
nos_set_evar 'PL_boxfile_after_exec_0_type' 'string'
nos_set_evar 'PL_boxfile_after_exec_0_value' 'true'
nos_set_evar 'PL_boxfile_after_exec_1_type' 'string'
nos_set_evar 'PL_boxfile_after_exec_1_value' 'false'
out=$(nos_run_hooks 'after' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "5f3f681f93de9b6de659fddd5c18e340" ]]; then
  echo "TEST ('nos_run_hooks array') FAILED! Got ${out}"
  false
fi

# nos_run_hooks exec
nos_set_evar 'PL_boxfile_exec_type' 'string'
nos_set_evar 'PL_boxfile_exec_value' 'true'
out=$(nos_run_hooks 'exec' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "890417029e6827e90132559566069a81" ]]; then
  echo "TEST ('nos_run_hooks exec') FAILED! Got ${out}"
  false
fi

echo "ALL RUN TESTS PASSED!"
