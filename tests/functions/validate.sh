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

echo "ALL VALIDATE TESTS PASSED!"
