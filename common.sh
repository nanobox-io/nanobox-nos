# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

lib_dir="$(dirname $BASH_SOURCE)/lib"

# include components
. ${lib_dir}/evars.sh
. ${lib_dir}/hooks.sh
. ${lib_dir}/payload.sh
. ${lib_dir}/output.sh
. ${lib_dir}/helpers.sh