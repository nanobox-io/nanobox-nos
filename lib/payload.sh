# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# nos_eval_payload(0)
# 
# Extracts the JSON payload into SHON format and evals the result as
# local variables prefixed with PL_
nos_eval_payload() {
  eval $(echo $1 | shon | sed -e "s/^/PL_/")
}

# payload(1)
# 
# $1 = key
# 
# A simple getter for fetching a payload value
nos_payload() {
  key="PL_${1}_type"
  type=${!key}

  if [[ "$type" = "array" ]]; then
    list=()
    length="PL_${1}_length"
    for (( i=0; $i < $length; i++ )); do
      val="PL_${1}_${i}_value"
      list+=("${!val}")
    done
    echo "${list[@]}"
  else
    val="PL_${1}_value"
    echo "${!val}"
  fi
}
