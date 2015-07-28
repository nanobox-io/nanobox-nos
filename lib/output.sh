# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# print_header(1)
#
# $1 = label
#
# Print a header, formatted to 70 characters, with the label
#
# Example:
#
# print_header "headline here"
#
# would produce:
# ::::::::::::::::::::::::::: HEADLINE HERE :::::::::::::::::::::::::::
print_header() {
  label=$(upcase "$1")
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

# print_process_start(1)
#
# $1 = label
#
# Print a header indicating the start of a process.
#
# Example:
#
# print_process_start "installing ruby-2.2"
#
# would produce:
# INSTALLING RUBY-2.2 ------------------------------------------------>
print_process_start() {
  label=$(upcase "$1")
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

# print_process_end()
#
# Creates a hard delineation after a process
print_process_end() {
  # end with a newline
  echo ""
}

# print_subtask_start(1)
#
# $1 = label
#
# Print a header indicating the start of a sub task
#
# Example:
#
# print_subtask_start "after build hook 1"
#
# would produce:
# AFTER BUILD HOOK 1 -------------------->
print_subtask_start() {
  label=$(upcase "$1")
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

# print_subtask_success(0)
#
# Print a footer indicating a successful sub task
#
# Example:
#
# print_subtask_success
#
# would produce:
#    [√] SUCCESS
print_subtask_success() {
  echo "   [√] SUCCESS"

  # end with a double newline
  echo ""
}

# print_subtask_fail(0)
#
# Print a footer indicating a failed sub task
#
# Example:
#
# print_subtask_fail
#
# would produce:
#    [!] FAILED
print_subtask_fail() {
  echo "   [!] FAILED"

  # end with a double newline
  echo ""
}

# print_bullet(1)
#
# $1 = message
#
# Print a line item in the form of a bullet point
#
# Example:
#
# print_bullet "Language Detected : Ruby"
#
# would produce:
# +> Language Detected : Ruby
print_bullet() {
  echo "+> $1"
}

# print_bullet_info(1)
#
# $1 = message
#
# Print a line item as followup info to a bullet point
#
# Example:
#
# print_bullet_info "Language Detected : Ruby"
#
# would produce:
#    Language Detected : Ruby
print_bullet_info() {
  echo "   $1"
}

# print_bullet_sub(1)
#
# $1 = message
#
# Print a line item as a sub or followup item to a bullet point
#
# Example:
#
# print_bullet_sub "Language Detected : Ruby"
#
# would produce:
#    - Language Detected : Ruby
print_bullet_sub() {
  echo "   - $1"
}

# print_warning(1)
#
# $1 = message
#
# Print a warning message, formatted to a 70 character block paragraph
#
# Example:
#
# print_warning "We've detected you may be using... (abbreviated for clarity)"
#
# would produce:
# -----------------------------  WARNING  -----------------------------
# We've detected you may be using sessions in a way that could cause
# unexpected behavior. Feel free to review the following guide for
# more information : bit.ly/2sA9b
print_warning() {
  # start with a newline
  # echo ""

  # print header
  echo "-----------------------------  WARNING  -----------------------------"

  print_block "$1"
}

# print_fatal(2)
#
# $1 = title
# $2 = message
#
# Example:
#
# print_fatal "deploy stream disconnected", "Oh snap... (abbreviated for clarity)"
#
# would produce:
# ! DEPLOY STREAM DISCONNECTED !
#
# Oh snap the deploy stream just disconnected. No worries, you can
# visit the dashboard to view the complete output stream.
print_fatal() {
  label=$(upcase "$1")
  # start with a newline
  # echo ""

  # print header
  echo "! ${label} !"

  # print a spacer
  echo ""

  # print message
  print_block "$2"
}

# print_block(1)
#
# $1 = message
#
# Print a message formatted as a block of text, wrapped at 70 characters
#
# Example:
#
# print_block "We've detected you may be using... (abbreviated for clarity)"
#
# would produce:
# We've detected you may be using sessions in a way that could cause
# unexpected behavior. Feel free to review the following guide for
# more information : bit.ly/2sA9b
print_block() {
  message=$1
  message_len=${#1}
  last=$(expr $message_len - 1)
  max_line_len=70

  word=""
  i=0
  j=0

  # start a loop that will iterate until we reach the end of the message
  until [ $i = $message_len ]; do
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
    elif [ $i = $last ]; then
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

# upcase(1)
#
# $1 = string
#
# Uppercase a string
#
# Example:
#
# upcase "hello world"
#
# would produce:
# HELLO WORLD
upcase() {
  echo $1 | tr [a-z] [A-Z]
}
