# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# initialize globals, to be set during nos_init
engine_root=""
engine_bin_script_dir=""
engine_template_dir=""
engine_file_dir=""
engine_lib_dir=""

# include components
lib_dir="$(dirname $BASH_SOURCE)/lib"
components=( evars output payload pkgsrc render run validate )
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
  engine_root="${current_dir}/../"
  engine_bin_script_dir="${current_dir}/$(basename $0)"
  engine_template_dir="${current_dir}/../templates"
  engine_file_dir="${current_dir}/../files"
  engine_lib_dir="${current_dir}/../lib"

  # initialize payload
  nos_eval_payload "$1"
}
