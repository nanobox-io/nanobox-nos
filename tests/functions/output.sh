#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
[ -z "${lib_dir}" ] && . ../../common.sh

MD5_COMMAND=$(which md5sum || echo md5)

# ensure nos_print_process_start goes to stderr
out=$(nos_print_process_start 'even' 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_process_start goes to stderr') FAILED!"
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

# ensure nos_print_bullet goes to stderr
out=$(nos_print_bullet 'Language Detected : Sailboatgun' 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_bullet goes to stderr') FAILED!"
  false
fi

# ensure nos_print_bullet_info goes to stderr
out=$(nos_print_bullet_info 'Language Detected : Sailboatgun' 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_bullet_info goes to stderr') FAILED!"
  false
fi

# ensure nos_print_bullet_sub goes to stderr
out=$(nos_print_bullet_sub 'Language Detected : Sailboatgun' 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_bullet_sub goes to stderr') FAILED!"
  false
fi

# ensure nos_print_warning goes to stderr
out=$(nos_print_warning 'Did you think to pray this morning, ere you left your room?' 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_warning goes to stderr') FAILED!"
  false
fi

# ensure nos_print_fatal goes to stderr
out=$(nos_print_fatal 'no fuel' 'Next time, refuel when you see a petrol station, because english gas is better.' 2>/dev/null)
if [[ -n "${out}" ]]; then
  echo "TEST ('nos_print_fatal goes to stderr') FAILED!"
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
