# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# TODO:
# set_evar -> set an environment variable for use in running container
# whitelist_evars -> sets evars from the payload evars that match a whitelist
# blacklist_evars -> sets evars from the payload evars that don't match a blacklist
# 
# NEED TO FIGURE OUT:
# templating
# simple find/replace within existing file

lib_dir="$(dirname $BASH_SOURCE)/lib"

# include components
. ${lib_dir}/evars.sh
. ${lib_dir}/helpers.sh
. ${lib_dir}/hooks.sh
. ${lib_dir}/payload.sh
. ${lib_dir}/output.sh