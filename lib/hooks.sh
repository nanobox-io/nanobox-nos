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
#     before_exec: 'ls -lah'
#     after_exec:
#       - 'rm -rf /some/dir'
#       - 'mkdir -p /some/nested/dir'
# 
# Usage ->
#   1) run_hooks "before_exec"
#   2) run_hooks "after_exec"
run_hooks() {
  exec_type="PL_boxfile_${1}_exec_type"
  case ${!exec_type} in
    "string" )
      print_subtask_start ${1/_/ }
      cmd=PL_boxfile_${1}_exec_value
      echo "$ ${!cmd}"
      (cd $PL_code_dir_value; ${!cmd})
      if [ $? -eq 0 ]; then
        print_subtask_success
      else
        print_subtask_fail
      fi
      ;;
    "array" )
      for index in $(seq $PL_boxfile_${1}_exec_length); do
        cmd_type="PL_boxfile_${1}_exec_${index}_type"
        if [ "${!cmd_type}" = "string"]; then
          print_subtask_start "${1/_/ } ${index}"
          cmd="PL_boxfile_${1}_exec_${index}_value"
          echo "$ ${!cmd}"
          (cd $PL_code_dir_value; ${!cmd})
          if [ $? -eq 0 ]; then
            print_subtask_success
          else
            print_subtask_fail
          fi
        fi
      done
      ;;
  esac
}