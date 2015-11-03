#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
[ -z "${lib_dir}" ] && . ../../common.sh

# nos_package_label
out=$(nos_package_label 'swings' 'slides' 'bars')
if [[ "${out}" != "swings, slides, and bars" ]]; then
  echo "TEST ('nos_package_label 3') FAILED!"
  false
fi

out=$(nos_package_label 'grass' 'tree')
if [[ "${out}" != "grass and tree" ]]; then
  echo "TEST ('nos_package_label 2') FAILED!"
  false
fi

out=$(nos_package_label 'deer')
if [[ "${out}" != "deer" ]]; then
  echo "TEST ('nos_package_label 1') FAILED!"
  false
fi

echo "ALL PKGSRC TESTS PASSED!"
