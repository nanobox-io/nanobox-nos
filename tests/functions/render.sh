#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
[ -z "${lib_dir}" ] && . ../../common.sh

# nos_template stdout
nos_set_evar engine_template_dir '/tmp'
echo "{{big_deal}}" > /tmp/nos_template.mustache
out=$(nos_template 'nos_template.mustache' '-' '{ "big_deal": "mustache"}')
if [[ "${out}" != "mustache" ]]; then
  echo "TEST ('nos_template stdout') FAILED!"
  false
fi

# nos_template file
nos_template 'nos_template.mustache' '/tmp/nos_template_out' '{ "big_deal": "mustache"}'
if [[ "$(cat /tmp/nos_template_out)" != "mustache" ]]; then
  echo "TEST ('nos_template file') FAILED!"
  false
fi

# nos_template_file
nos_set_evar engine_file_dir '/tmp'
nos_template_file 'nos_template.mustache' '/tmp/mustache.nos_template'
if [[ ! -a /tmp/mustache.nos_template ]]; then
  echo "TEST ('nos_template_file') FAILED!"
  false
fi

echo "ALL RENDER TESTS PASSED!"
