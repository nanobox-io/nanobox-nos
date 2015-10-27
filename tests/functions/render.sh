#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
[ -z "${lib_dir}" ] && . ../../common.sh

# template stdout
set_evar engine_template_dir '/tmp'
echo "{{big_deal}}" > /tmp/template.mustache
out=$(template 'template.mustache' '-' '{ "big_deal": "mustache"}')
if [[ "${out}" != "mustache" ]]; then
  echo "TEST ('template stdout') FAILED!"
  false
fi

# template file
template 'template.mustache' '/tmp/template_out' '{ "big_deal": "mustache"}'
if [[ "$(cat /tmp/template_out)" != "mustache" ]]; then
  echo "TEST ('template file') FAILED!"
  false
fi

# template_file
set_evar engine_file_dir '/tmp'
template_file 'template.mustache' '/tmp/mustache.template'
if [[ ! -a /tmp/mustache.template ]]; then
  echo "TEST ('template_file') FAILED!"
  false
fi

echo "ALL RENDER TESTS PASSED!"
