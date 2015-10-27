#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
[ -z "${lib_dir}" ] && . ../../common.sh

MD5_COMMAND=$(which md5sum || echo md5)

# print_header even
out=$(print_header 'even' | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "47585ae041319e677d7a4ab04209e975" ]]; then
  echo "TEST ('print_header even') FAILED!"
  false
fi

# print_header odd
out=$(print_header 'odd' | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "c2921365b481cab4dd45128ebcb5cf68" ]]; then
  echo "TEST ('print_header odd') FAILED!"
  false
fi

# print_process_start even
out=$(print_process_start 'even' | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "0caeb0d0f0c5fd4199c67dc52109057d" ]]; then
  echo "TEST ('print_process_start even') FAILED!"
  false
fi

# print_process_start odd
out=$(print_process_start 'odd' | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "b56ba43a8b1559a4306babe325d8d379" ]]; then
  echo "TEST ('print_process_start odd') FAILED!"
  false
fi

# print_process_end
out=$(print_process_end)
if [[ "${out}" != "" ]]; then
  echo "TEST ('print_process_end') FAILED!"
  false
fi

# print_subtask_start even
out=$(print_subtask_start 'even' | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "9b5233b412f23518df8e34342dfaa8e6" ]]; then
  echo "TEST ('print_subtask_start even') FAILED!"
  false
fi

# print_subtask_start odd
out=$(print_subtask_start 'odd' | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "9abe963817e84bcaca9cc913a14f0045" ]]; then
  echo "TEST ('print_subtask_start odd') FAILED!"
  false
fi

# print_subtask_success
out=$(print_subtask_success | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "4b7d5e1d3ad7dcfdabe1d1f670bf50ce" ]]; then
  echo "TEST ('print_subtask_success') FAILED!"
  false
fi

# print_subtask_fail
out=$(print_subtask_fail | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "11b93f11b36979fce6a0334ba156cd4d" ]]; then
  echo "TEST ('print_subtask_fail') FAILED!"
  false
fi

# print_bullet
out=$(print_bullet 'Language Detected : Sailboatgun' | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "d399e5be6c8acebbc30c79a2e4b7b9f5" ]]; then
  echo "TEST ('print_bullet') FAILED!"
  false
fi

# print_bullet_info
out=$(print_bullet_info 'Language Detected : Sailboatgun' | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "1d94e090fc7050d3a9d2e7d7f3f16050" ]]; then
  echo "TEST ('print_bullet_info') FAILED!"
  false
fi

# print_bullet_sub
out=$(print_bullet_sub 'Language Detected : Sailboatgun' | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "9bd32ec265aa1ac3a5084a6241f91828" ]]; then
  echo "TEST ('print_bullet_sub') FAILED!"
  false
fi

# print_warning
out=$(print_warning 'Did you think to pray this morning, ere you left your room?' | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "6a15e6062dc5e15c4873078c07204f89" ]]; then
  echo "TEST ('print_warning') FAILED!"
  false
fi

# print_fatal
out=$(print_fatal 'no fuel' 'Next time, refuel when you see a petrol station, because english gas is better.' | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "8122460111e63f90d374bb553ddbdbe6" ]]; then
  echo "TEST ('print_fatal') FAILED!"
  false
fi

# print_block
out=$(print_block 'I am going to be a long string. I am not one yet, but I know what I can become, so I will keep trying until I reach (or surpass) my potential.' | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "ff8aaf3ee8deaf50527f1e48456f653e" ]]; then
  echo "TEST ('print_block') FAILED!"
  false
fi

# upcase
out=$(upcase '#cantstopshouting' | $MD5_COMMAND | cut -f 1 -d ' ')
if [[ "${out}" != "137d45d55c99229d9ef917a09e4f6926" ]]; then
  echo "TEST ('upcase') FAILED!"
  false
fi

echo "ALL OUTPUT TESTS PASSED!"
