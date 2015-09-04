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
  type="PL_${1}_type"

  case "${!type}" in
    "map" )
      eval "PL_${1}_value=()"
      nodes_var="PL_${1}_nodes"
      list=${!nodes_var}
      nodes=(${list}//,/ })
      for node in "${nodes[@]}"; do
        node_var="PL_${1}_${node}_value"
        key=node
        val=${!node_var}
        eval "PL_${1}_value+=(\"${key}=${val}\")"
      done
      echo "PL_${1}_value"
      ;;
    "array" )
      eval "PL_${1}_value=()"
      len_var="PL_${1}_length"
      length=${!len_var}
      for (( i=0; i < $length; i++ ))
      do
        val="PL_${1}_${i}_value"
        eval "PL_${1}_value+=(\"${!val}\")"
      done
      echo "PL_${1}_value"
      ;;
    * )
      val="PL_${1}_value"
      echo "${!val}"      
      ;;
  esac
}