#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
[ -z "${lib_dir}" ] && . ../../common.sh

MD5_COMMAND=$(which md5sum || echo md5)

# ensure nos_print_header goes to stderr
out=$(nos_print_header 'even' 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_header goes to stderr') FAILED!"
  false
fi

# nos_print_header even
out=$(nos_print_header 'even' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "47585ae041319e677d7a4ab04209e975" ]]; then
  echo "TEST ('nos_print_header even') FAILED!"
  false
fi

# nos_print_header odd
out=$(nos_print_header 'odd' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "c2921365b481cab4dd45128ebcb5cf68" ]]; then
  echo "TEST ('nos_print_header odd') FAILED!"
  false
fi

# ensure nos_print_process_start goes to stderr
out=$(nos_print_process_start 'even' 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_process_start goes to stderr') FAILED!"
  false
fi

# nos_print_process_start even
out=$(nos_print_process_start 'even' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "0caeb0d0f0c5fd4199c67dc52109057d" ]]; then
  echo "TEST ('nos_print_process_start even') FAILED!"
  false
fi

# nos_print_process_start odd
out=$(nos_print_process_start 'odd' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "b56ba43a8b1559a4306babe325d8d379" ]]; then
  echo "TEST ('nos_print_process_start odd') FAILED!"
  false
fi

# ensure nos_print_process_end goes to stderr
out=$(nos_print_process_end 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_process_end goes to stderr') FAILED!"
  false
fi

# nos_print_process_end
out=$(nos_print_process_end 2>&1)
if [[ "${out}" != "" ]]; then
  echo "TEST ('nos_print_process_end') FAILED!"
  false
fi

# ensure nos_print_subtask_start goes to stderr
out=$(nos_print_subtask_start 'even' 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_subtask_start goes to stderr') FAILED!"
  false
fi

# nos_print_subtask_start even
out=$(nos_print_subtask_start 'even' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "9b5233b412f23518df8e34342dfaa8e6" ]]; then
  echo "TEST ('nos_print_subtask_start even') FAILED!"
  false
fi

# nos_print_subtask_start odd
out=$(nos_print_subtask_start 'odd' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "9abe963817e84bcaca9cc913a14f0045" ]]; then
  echo "TEST ('nos_print_subtask_start odd') FAILED!"
  false
fi

# ensure nos_print_subtask_success goes to stderr
out=$(nos_print_subtask_success 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_subtask_success goes to stderr') FAILED!"
  false
fi

# nos_print_subtask_success
out=$(nos_print_subtask_success 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "5966ed2bfbf4caf218a68b85f56eb352" ]]; then
  echo "TEST ('nos_print_subtask_success') FAILED!"
  false
fi

# ensure nos_print_subtask_fail goes to stderr
out=$(nos_print_subtask_fail 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_subtask_fail goes to stderr') FAILED!"
  false
fi

# nos_print_subtask_fail
out=$(nos_print_subtask_fail 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "19446708ec603da6ee7d3d88147ba095" ]]; then
  echo "TEST ('nos_print_subtask_fail') FAILED!"
  false
fi

# ensure nos_print_bullet goes to stderr
out=$(nos_print_bullet 'Language Detected : Sailboatgun' 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_bullet goes to stderr') FAILED!"
  false
fi

# nos_print_bullet
out=$(nos_print_bullet 'Language Detected : Sailboatgun' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "d399e5be6c8acebbc30c79a2e4b7b9f5" ]]; then
  echo "TEST ('nos_print_bullet') FAILED!"
  false
fi

# ensure nos_print_bullet_info goes to stderr
out=$(nos_print_bullet_info 'Language Detected : Sailboatgun' 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_bullet_info goes to stderr') FAILED!"
  false
fi

# nos_print_bullet_info
out=$(nos_print_bullet_info 'Language Detected : Sailboatgun' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "1d94e090fc7050d3a9d2e7d7f3f16050" ]]; then
  echo "TEST ('nos_print_bullet_info') FAILED!"
  false
fi

# ensure nos_print_bullet_sub goes to stderr
out=$(nos_print_bullet_sub 'Language Detected : Sailboatgun' 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_bullet_sub goes to stderr') FAILED!"
  false
fi

# nos_print_bullet_sub
out=$(nos_print_bullet_sub 'Language Detected : Sailboatgun' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "9bd32ec265aa1ac3a5084a6241f91828" ]]; then
  echo "TEST ('nos_print_bullet_sub') FAILED!"
  false
fi

# ensure nos_print_warning goes to stderr
out=$(nos_print_warning 'Did you think to pray this morning, ere you left your room?' 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_warning goes to stderr') FAILED!"
  false
fi

# nos_print_warning
out=$(nos_print_warning 'Did you think to pray this morning, ere you left your room?' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "6a15e6062dc5e15c4873078c07204f89" ]]; then
  echo "TEST ('nos_print_warning') FAILED!"
  false
fi

# ensure nos_print_fatal goes to stderr
out=$(nos_print_fatal 'no fuel' 'Next time, refuel when you see a petrol station, because english gas is better.' 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_fatal goes to stderr') FAILED!"
  false
fi

# nos_print_fatal
out=$(nos_print_fatal 'no fuel' 'Next time, refuel when you see a petrol station, because english gas is better.' 2>&1 | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "8122460111e63f90d374bb553ddbdbe6" ]]; then
  echo "TEST ('nos_print_fatal') FAILED!"
  false
fi

# nos_print_block
out=$(nos_print_block 'I am going to be a long string. I am not one yet, but I know what I can become, so I will keep trying until I reach (or surpass) my potential.' | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "ff8aaf3ee8deaf50527f1e48456f653e" ]]; then
  echo "TEST ('nos_print_block') FAILED!"
  false
fi

# nos_upcase
out=$(nos_upcase '#cantstopshouting' | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "137d45d55c99229d9ef917a09e4f6926" ]]; then
  echo "TEST ('nos_upcase') FAILED!"
  false
fi

# nos_join
out=$(nos_join '|' 'check' 'sum')
if [[ "${out}" != "check|sum" ]]; then
  echo "TEST ('nos_join') FAILED!"
  false
fi

echo "ALL OUTPUT TESTS PASSED!"
