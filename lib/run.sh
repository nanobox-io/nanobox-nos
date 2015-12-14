# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# nos_run_process(2)
#
# $1 = process label
# $2 = command
#
# A helper to run a process and format the output according to the styleguide
nos_run_process() {
  nos_print_process_start "${1}"
  $2 2>&1 | (grep '\S' || echo "") | sed -e 's/\r//g;s/^/   /'
  nos_print_process_end
}

# nos_run_subprocess(2)
#
# $1 = process label
# $2 = command
#
# # A helper to run a subprocess and format the output according to the styleguide
nos_run_subprocess() {
  nos_print_subtask_start "${1}"
  echo "   $ ${2}"
  ($2 2>&1) | (grep '\S' || echo "") | sed -e 's/\r//g;s/^/   /'
  if [ ${PIPESTATUS[0]} -eq 0 ]; then
    nos_print_subtask_success
  else
    nos_print_subtask_fail
  fi
}

# nos_run_hooks(1)
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
#   1) nos_run_hooks "before"
#   2) nos_run_hooks "after"
nos_run_hooks() {
  if [ "${1}" = "exec" ]; then
    exec_type="PL_boxfile_exec_type"
  else
    exec_type="PL_boxfile_${1}_exec_type"
  fi
  case ${!exec_type} in
    "string" )
      cmd=PL_boxfile_${1}_exec_value
      (cd $PL_code_dir_value; nos_run_subprocess "${1/_/ }" "${!cmd}")
      ;;
    "array" )
      length=PL_boxfile_${1}_exec_length
      for (( index=0; $index < $length; index++ )); do
        cmd_type="PL_boxfile_${1}_exec_${index}_type"
        if [ "${!cmd_type}" = "string" ]; then
          cmd="PL_boxfile_${1}_exec_${index}_value"
          (cd $PL_code_dir_value; nos_run_subprocess "${1/_/ } ${index}" "${!cmd}")
        fi
      done
      ;;
  esac
}
