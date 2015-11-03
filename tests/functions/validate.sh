#!/bin/bash -e
# exit on error to make sure they get resolved

# get common functionality
[ -z "${lib_dir}" ] && . ../../common.sh

# nos_validate_presence not found
(nos_validate_presence 'holy_grail' &> /dev/null) && (echo "TEST ('nos_validate_presence missing') FAILED!"; false) || true

# nos_validate_presence found
nos_set_evar 'PL_keep_value' 'trying'
nos_validate_presence 'keep' || (echo "TEST ('nos_validate_presence present') FAILED!"; false)

# nos_validate_in not found
(nos_validate_in 'stop' 'playing slacking sleeping wishing' &> /dev/null) && (echo "TEST ('nos_validate_in missing') FAILED!"; false) || true

# nos_validate_in found
nos_validate_in 'keep' 'working sweating exhausting trying' || (echo "TEST ('nos_validate_in present') FAILED!"; false)

# nos_validate_not_in not found
(nos_validate_not_in 'keep' 'working sweating exhausting trying' &> /dev/null) && (echo "TEST ('nos_validate_not_in present') FAILED!"; false) || true

# nos_validate_not_in found
nos_validate_not_in 'stop' 'playing slacking sleeping wishing' || (echo "TEST ('nos_validate_not_in missing') FAILED!"; false)

echo "ALL VALIDATE TESTS PASSED!"
