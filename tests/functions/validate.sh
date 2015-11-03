#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
[ -z "${lib_dir}" ] && . ../../common.sh

# validate_presence not found
(validate_presence 'holy_grail' &> /dev/null) && (echo "TEST ('validate_presence missing') FAILED!"; false) || true

# validate_presence found
set_evar 'PL_keep_value' 'trying'
validate_presence 'keep' || (echo "TEST ('validate_presence present') FAILED!"; false)

# validate_in not found
(validate_in 'stop' 'playing slacking sleeping wishing' &> /dev/null) && (echo "TEST ('validate_in missing') FAILED!"; false) || true

# validate_in found
validate_in 'keep' 'working sweating exhausting trying' || (echo "TEST ('validate_in present') FAILED!"; false)

# validate_not_in not found
(validate_not_in 'keep' 'working sweating exhausting trying' &> /dev/null) && (echo "TEST ('validate_not_in present') FAILED!"; false) || true

# validate_not_in found
validate_not_in 'stop' 'playing slacking sleeping wishing' || (echo "TEST ('validate_not_in missing') FAILED!"; false)

# nos_valid_integer
validate_not_in 'stop' 'playing slacking sleeping wishing' || (echo "TEST ('validate_not_in missing') FAILED!"; false)

# nos_valid_integer
nos_valid_integer 1 || (echo "TEST ('nos_valid_integer') FAILED!"; false)

# nos_valid_file
nos_valid_file 'file' || (echo "TEST ('nos_valid_file') FAILED!"; false)

# nos_valid_folder
nos_valid_folder 'folder/' || (echo "TEST ('nos_valid_folder') FAILED!"; false)

# nos_valid_boolean
nos_valid_boolean 'true' || (echo "TEST ('nos_valid_boolean') FAILED!"; false)

# nos_valid_byte
nos_valid_byte '1b' || (echo "TEST ('nos_valid_byte') FAILED!"; false)

# nos_valid_string
nos_valid_string 'string' || (echo "TEST ('nos_valid_string') FAILED!"; false)

# nos_validate
if [[ "$(nos_validate '' 'string' 'default-value')" != "default-value" ]]; then
  echo "TEST ('nos_validate default') FAILED!"
  false
fi

if [[ "$(nos_validate 'non-default' 'string' 'default-value')" != "non-default" ]]; then
  echo "TEST ('nos_validate non-default') FAILED!"
  false
fi

echo "ALL VALIDATE TESTS PASSED!"
