# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# run_hooks(1)
# 
# Iterate through commands in the Boxfile and run them.
# 
# $1 = key
#
# A key correlates to a node in the Boxfile within the 'build' node.
# 
# Example:
# 
# Boxfile ->
#   build:
#     before: 'ls -lah'
#     after:
#       - 'rm -rf /some/dir'
#       - 'mkdir -p /some/nested/dir'
# 
# Usage ->
#   1) run_hooks "before"
#   2) run_hooks "after"
run_hooks() {
  exec_type="PL_boxfile_${1}_exec_type"
  case ${!exec_type} in
    "string" )
      cmd=PL_boxfile_${1}_exec_value
      (cd $PL_code_dir_value; run_subprocess "${1/_/ }" "${!cmd}")
      ;;
    "array" )
      for index in $(seq $PL_boxfile_${1}_exec_length); do
        cmd_type="PL_boxfile_${1}_exec_${index}_type"
        if [ "${!cmd_type}" = "string"]; then
          cmd="PL_boxfile_${1}_exec_${index}_value"
          (cd $PL_code_dir_value; run_subprocess "${1/_/ } ${index}" "${!cmd}")
        fi
      done
      ;;
  esac
}