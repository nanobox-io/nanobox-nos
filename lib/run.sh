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
   >&2 siphon --prefix "  " -- bash -c "${2} 2>&1"
  nos_print_process_end
}
