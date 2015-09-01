# Nos
A bash library and framework to expedite Nanobox engine development.

## Installation

No installation is required, Nanobox build containers have Nos pre-installed.

## Usage

To use Nos, simply source the common.sh script and initialize the framework.

```bash
#!/bin/bash

# source the Nos framework
. /opt/nos/common.sh

# initialize Nos with the original arguments
nos_init $@
```

## API

- [Payload](#Payload)
    - [payload](#payload(1))
- [Validation](#Validation)
    - [validate_presence](#validate_presence(1))


#### Payload

##### payload(1)

    $1 = key

    A simple getter for fetching a payload value

#### Validation

##### validate_presence(1)

    $1 = field
    
    Validate that a field exists within the boxfile payload and has a value.
    If the check fails, a fatal error will be printed an a non-zero exit
    will be forced.

##### validate_in(2)

    $1 = field
    $2 = possible values
    
    Validates that if a field exists, the value present falls within a range
    of acceptable options.
    
##### validate_not_in(2)

    $1 = field
    $2 = possible values
    
    Validates that if a field exists, the value present falls does not fall
    within a range of options.
    
#### Printing Output

##### print_header(1)
    
    $1 = label
    
    Print a header, formatted to 70 characters, with the label
    
    Example:
    
    print_header "headline here"
    
    would produce:
    ::::::::::::::::::::::::::: HEADLINE HERE :::::::::::::::::::::::::::

##### print_process_start(1)
    
    $1 = label
    
    Print a header indicating the start of a process.
    
    Example:
    
    print_process_start "installing ruby-2.2"
    
    would produce:
    INSTALLING RUBY-2.2 ------------------------------------------------>

##### print_process_end()
    
    Creates a hard delineation after a process

##### print_subtask_start(1)
    
    $1 = label
    
    Print a header indicating the start of a sub task
    
    Example:
    
    print_subtask_start "after build hook 1"
    
    would produce:
    AFTER BUILD HOOK 1 -------------------->

##### print_subtask_success(0)
    
    Print a footer indicating a successful sub task
    
    Example:
    
    print_subtask_success
    
    would produce:
       [√] SUCCESS

##### print_subtask_fail(0)
    
    Print a footer indicating a failed sub task
    
    Example:
    
    print_subtask_fail
    
    would produce:
       [!] FAILED

##### print_bullet(1)
    
    $1 = message
    
    Print a line item in the form of a bullet point
    
    Example:
    
    print_bullet "Language Detected : Ruby"
    
    would produce:
    +> Language Detected : Ruby

##### print_bullet_info(1)
    
    $1 = message
    
    Print a line item as followup info to a bullet point
    
    Example:
    
    print_bullet_info "Language Detected : Ruby"
    
    would produce:
       Language Detected : Ruby

##### print_bullet_sub(1)
    
    $1 = message
    
    Print a line item as a sub or followup item to a bullet point
    
    Example:
    
    print_bullet_sub "Language Detected : Ruby"
    
    would produce:
       - Language Detected : Ruby

##### print_warning(1)
    
    $1 = message
    
    Print a warning message, formatted to a 70 character block paragraph
    
    Example:
    
    print_warning "We've detected you may be using... (abbreviated for clarity)"
    
    would produce:
    -----------------------------  WARNING  -----------------------------
    We've detected you may be using sessions in a way that could cause
    unexpected behavior. Feel free to review the following guide for
    more information : bit.ly/2sA9b

##### print_fatal(2)
    
    $1 = title
    $2 = message
    
    Example:
    
    print_fatal "deploy stream disconnected", "Oh snap... (abbreviated for clarity)"
    
    would produce:
    ! DEPLOY STREAM DISCONNECTED !
    
    Oh snap the deploy stream just disconnected. No worries, you can
    visit the dashboard to view the complete output stream.

##### print_block(1)
    
    $1 = message
    
    Print a message formatted as a block of text, wrapped at 70 characters
    
    Example:
    
    print_block "We've detected you may be using... (abbreviated for clarity)"
    
    would produce:
    We've detected you may be using sessions in a way that could cause
    unexpected behavior. Feel free to review the following guide for
    more information : bit.ly/2sA9b

#### Installing Packages

##### install(1)
    
    $1 = package name
    
    A simple expressive shortcut to install a pkgsrc package via pkgin
    
#### Running Commands

##### run_process(2)
  
    $1 = process label
    $2 = command
    
    A helper to run a process and format the output according to the styleguide

##### run_subprocess(2)
    
    $1 = process label
    $2 = command
    
    A helper to run a subprocess and format the output according to the styleguide
    
#### Environment Variables

##### set_evar(2)
    
    $1 = key
    $2 = value
    
    Sets an environment variable in the running process

##### persist_evar(2)
    
    $1 = key
    $2 = value
    
    Persists an environment variable which will be available to the process that
    the code runs in after a successful deploy.

##### set_evars(0)
    
    Sets all environment variables from the payload in the running process.

##### persist_evars(0)
    
    Persists all environment variables from the payload to be available to the
    process that the code runs in.

##### set_evars_whitelist(1)
    
    $1 = whitelist regex
    
    Sets an environment variable in the running process, from the payload,
    according the the whitelist.

##### persist_evars_whitelist(1)
    
    $1 = whitelist regex
    
    Persists environment variables from the payload to be available to the
    process that the code runs in, according the the whitelist.

##### set_evars_blacklist(1)
    
    $1 = blacklist regex
    
    Sets an environment variable in the running process, from the payload,
    according the the blacklist.

##### persist_evars_blacklist(1)
    
    $1 = blacklist regex
    
    Persists environment variables from the payload to be available to the
    process that the code runs in, according the the blacklist.
    
#### Running Hooks

##### run_hooks(1)
    
    Iterate through commands in the Boxfile and run them.
    
    $1 = key
    
    A key correlates to a node in the Boxfile within the 'build' node.
    
    Example:
    
    Boxfile ->
      build:
        before: 'ls -lah'
        after:
          - 'rm -rf /some/dir'
          - 'mkdir -p /some/nested/dir'
    
    Usage ->
      1) run_hooks "before"
      2) run_hooks "after"
      
