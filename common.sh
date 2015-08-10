# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# initialize globals, to be set during nos_init
NOS_bin_script=""
NOS_engine_root=""
NOS_template_dir=""
NOS_file_dir=""
NOS_lib_dir=""

# include components
lib_dir="$(dirname $BASH_SOURCE)/lib"
components=( evars hooks payload output helpers render)
for component in "${components[@]}"
do
  . ${lib_dir}/${component}.sh
done

# nos_init(2)
#
# $0 = original filename
# $1 = original payload
#
# Initialized nos with the arguments provided to the original script
nos_init() {
  # pwd should be the bin script directory!
  current_dir=$(pwd)

  # initialize globals
  NOS_bin_script="${current_dir}/$(basename $0)"
  NOS_engine_root="${current_dir}/../"
  NOS_template_dir="${current_dir}/../templates"
  NOS_file_dir="${current_dir}/../files"
  NOS_lib_dir="${current_dir}/../lib"

  # initialize payload
  eval_payload $1
}
