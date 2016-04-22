#!/bin/bash

UUID=$(cat /proc/sys/kernel/random/uuid)

pass "unable to start the $VERSION container" docker run --privileged=true -d --name $UUID nanobox/build-nos sleep 365d

defer docker kill $UUID

pass "evars test failed to pass" docker exec $UUID bash -c "cd /opt/nos/tests/functions; ./evars.sh"

pass "output tests failed to pass" docker exec $UUID bash -c "cd /opt/nos/tests/functions; ./output.sh"

pass "payload tests failed to pass" docker exec $UUID bash -c "cd /opt/nos/tests/functions; ./payload.sh"

pass "pkgsrc tests failed to pass" docker exec $UUID bash -c "cd /opt/nos/tests/functions; ./pkgsrc.sh"

pass "render tests failed to pass" docker exec $UUID bash -c "cd /opt/nos/tests/functions; ./render.sh"

pass "run tests failed to pass" docker exec $UUID bash -c "cd /opt/nos/tests/functions; ./run.sh"

pass "validate tests failed to pass" docker exec $UUID bash -c "cd /opt/nos/tests/functions; ./validate.sh"
