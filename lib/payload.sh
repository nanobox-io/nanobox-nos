# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# eval_payload(0)
# 
# Extracts the JSON payload into SHON format and evals the result as
# local variables prefixed with PL_
eval_payload() {
  eval $(echo $1 | shon | sed -e "s/^/PL_/")
}

# payload(1)
# 
# $1 = key
# 
# A simple getter for fetching a payload value
payload() {
  val="PL_${1}_value"
  echo "${!val}"
}