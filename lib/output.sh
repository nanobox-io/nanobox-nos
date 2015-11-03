# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# nos_print_header(1)
#
# $1 = label
#
# Print a header, formatted to 70 characters, with the label
#
# Example:
#
# nos_print_header "headline here"
#
# would produce:
# ::::::::::::::::::::::::::: HEADLINE HERE :::::::::::::::::::::::::::
nos_print_header() {
  >&2 echo "$(_nos_print_header "$1")"
}

_nos_print_header() {
  label=$(nos_upcase "$1")
  max_length=70
  middle=$(expr ${#label} + 2)
  remainder=$(expr $max_length - $middle)
  left=$(expr $remainder / 2)

  if [[ $(expr $remainder % 2) = 0 ]]; then
    right=$left
  else
    right=$(expr $left + 1)
  fi

  # start with a newline
  # echo ""

  # print the left column
  counter=$left
  until [ $counter = 0 ]; do
    let counter--
    echo -n ":"
  done

  # print a space
  echo -n " "

  # print the label
  echo -n $label

  # print a space
  echo -n " "

  # print the right column
  counter=$right
  until [ $counter = 0 ]; do
    let counter--
    echo -n ":"
  done

  # end with two newlines
  echo ""
  # echo ""
}

# nos_print_process_start(1)
#
# $1 = label
#
# Print a header indicating the start of a process.
#
# Example:
#
# nos_print_process_start "installing ruby-2.2"
#
# would produce:
# INSTALLING RUBY-2.2 ------------------------------------------------>
nos_print_process_start() {
  >&2 echo "$(_nos_print_process_start "$1")"
}

_nos_print_process_start() {
  label=$(nos_upcase "$1")
  max_length=70
  left=$(expr ${#label} + 1)
  right=1
  middle=$(expr $max_length - $(expr $left + $right))

  # start with a newline
  echo ""

  # print label
  echo -n $label

  # print a space
  echo -n " "

  # print middle column
  counter=$middle
  until [ $counter = 0 ]; do
    let counter--
    echo -n "-"
  done

  # print the right column
  echo -n ">"

  # end with a
  echo ""
}

# nos_print_process_end()
#
# Creates a hard delineation after a process
nos_print_process_end() {
  >&2 echo "$(_nos_print_process_end)"
}

_nos_print_process_end() {
  # end with a newline
  echo ""
}

# nos_print_subtask_start(1)
#
# $1 = label
#
# Print a header indicating the start of a sub task
#
# Example:
#
# nos_print_subtask_start "after build hook 1"
#
# would produce:
# AFTER BUILD HOOK 1 -------------------->
nos_print_subtask_start() {
  >&2 echo "$(_nos_print_subtask_start "$1")"
}

_nos_print_subtask_start() {
  label=$(nos_upcase "$1")
  max_length=40
  left=$(expr ${#label} + 1)
  right=1
  middle=$(expr $max_length - $(expr $left + $right))

  # start with a newline
  echo ""

  # print label
  echo -n $label

  # print a space
  echo -n " "

  # print middle column
  counter=$middle
  until [ $counter = 0 ]; do
    let counter--
    echo -n "-"
  done

  # print the right column
  echo -n ">"

  # end with a newline
  echo ""
}

# nos_print_subtask_success(0)
#
# Print a footer indicating a successful sub task
#
# Example:
#
# nos_print_subtask_success
#
# would produce:
#    [√] SUCCESS
nos_print_subtask_success() {
  >&2 echo "$(_nos_print_subtask_success)"
}

_nos_print_subtask_success() {
  echo "   [√] SUCCESS"

  # end with a double newline
  echo ""
}

# nos_print_subtask_fail(0)
#
# Print a footer indicating a failed sub task
#
# Example:
#
# nos_print_subtask_fail
#
# would produce:
#    [!] FAILED
nos_print_subtask_fail() {
  >&2 echo "$(_nos_print_subtask_fail)"
}

_nos_print_subtask_fail() {
  echo "   [!] FAILED"

  # end with a double newline
  echo ""
}

# nos_print_bullet(1)
#
# $1 = message
#
# Print a line item in the form of a bullet point
#
# Example:
#
# nos_print_bullet "Language Detected : Ruby"
#
# would produce:
# +> Language Detected : Ruby
nos_print_bullet() {
  >&2 echo "$(_nos_print_bullet "$1")"
}

_nos_print_bullet() {
  echo "+> $1"
}

# nos_print_bullet_info(1)
#
# $1 = message
#
# Print a line item as followup info to a bullet point
#
# Example:
#
# nos_print_bullet_info "Language Detected : Ruby"
#
# would produce:
#    Language Detected : Ruby
nos_print_bullet_info() {
  >&2 echo "$(_nos_print_bullet_info "$1")"
}

_nos_print_bullet_info() {
  echo "   $1"
}

# nos_print_bullet_sub(1)
#
# $1 = message
#
# Print a line item as a sub or followup item to a bullet point
#
# Example:
#
# nos_print_bullet_sub "Language Detected : Ruby"
#
# would produce:
#    - Language Detected : Ruby
nos_print_bullet_sub() {
  >&2 echo "$(_nos_print_bullet_sub "$1")"
}

_nos_print_bullet_sub() {
  echo "   - $1"
}

# nos_print_warning(1)
#
# $1 = message
#
# Print a warning message, formatted to a 70 character block paragraph
#
# Example:
#
# nos_print_warning "We've detected you may be using... (abbreviated for clarity)"
#
# would produce:
# -----------------------------  WARNING  -----------------------------
# We've detected you may be using sessions in a way that could cause
# unexpected behavior. Feel free to review the following guide for
# more information : bit.ly/2sA9b
nos_print_warning() {
  >&2 echo "$(_nos_print_warning "$1")"
}

_nos_print_warning() {
  # start with a newline
  # echo ""

  # print header
  echo "-----------------------------  WARNING  -----------------------------"

  nos_print_block "$1"
}

# nos_print_fatal(2)
#
# $1 = title
# $2 = message
#
# Example:
#
# nos_print_fatal "deploy stream disconnected", "Oh snap... (abbreviated for clarity)"
#
# would produce:
# ! DEPLOY STREAM DISCONNECTED !
#
# Oh snap the deploy stream just disconnected. No worries, you can
# visit the dashboard to view the complete output stream.
nos_print_fatal() {
  >&2 echo "$(_nos_print_fatal "$1" "$2")"
}

_nos_print_fatal() {
  label=$(nos_upcase "$1")
  # start with a newline
  # echo ""

  # print header
  echo "! ${label} !"

  # print a spacer
  echo ""

  # print message
  nos_print_block "$2"
}

# nos_print_block(1)
#
# $1 = message
#
# Print a message formatted as a block of text, wrapped at 70 characters
#
# Example:
#
# nos_print_block "We've detected you may be using... (abbreviated for clarity)"
#
# would produce:
# We've detected you may be using sessions in a way that could cause
# unexpected behavior. Feel free to review the following guide for
# more information : bit.ly/2sA9b
nos_print_block() {
  message=$1
  message_len=${#1}
  max_line_len=70

  word=""
  i=0
  j=0

  # start a loop that will iterate until we reach the end of the message
  until [ $i -gt $message_len ]; do
    # extract character
    char=${message:${i}:1}

    if [ "$char" = " " ]; then
      if [ $j -ge $max_line_len ]; then
        # terminate the current line
        echo ""
        echo -n "${word} "
        j=$(expr ${#word} + 1)
        word=""
      else
        echo -n "${word} "
        word=""
      fi
    elif [ $i = $message_len ]; then
      if [ $j -ge $max_line_len ]; then
        # terminate the current line
        echo ""
      fi
      echo $word
    else
      word="${word}${char}"
    fi

    # increment message counter
    let i+=1
    # increment line counter
    let j+=1
  done

  # print an extra newline
  # echo ""
}

# nos_upcase(1)
#
# $1 = string
#
# Uppercase a string
#
# Example:
#
# nos_upcase "hello world"
#
# would produce:
# HELLO WORLD
nos_upcase() {
  echo $1 | tr [a-z] [A-Z]
}
