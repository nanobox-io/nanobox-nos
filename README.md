# Nos ![Build Status Image](https://travis-ci.org/nanobox-io/nanobox-nos.svg)
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
nos_init "$@"
```

For an overview of how and when to use Nos, please refer to the [Nanobox Common Tasks](http://docs.nanobox.io/engines/common-tasks/) guide.

## API

- [Payload](#payload)
    - [nos_payload](#nos_payload1)
- [Validation](#validation)
    - [nos_validate_presence](#nos_validate_presence1)
    - [nos_validate_in](#nos_validate_in2)
    - [nos_validate_not_in](#nos_validate_not_in2)
- [Printing Output](#printing-output)
    - [nos_print_header](#nos_print_header1)
    - [nos_print_process_start](#nos_print_process_start1)
    - [nos_print_process_end](#nos_print_process_end)
    - [nos_print_subtask_start](#nos_print_subtask_start1)
    - [nos_print_subtask_success](#nos_print_subtask_success0)
    - [nos_print_subtask_fail](#nos_print_subtask_fail0)
    - [nos_print_bullet](#nos_print_bullet1)
    - [nos_print_bullet_info](#nos_print_bullet_info1)
    - [nos_print_bullet_sub](#nos_print_bullet_sub1)
    - [nos_print_warning](#nos_print_warning1)
    - [nos_print_fatal](#nos_print_fatal2)
    - [nos_print_block](#nos_print_block1)
- [Installing Packages](#installing-packages)
    - [nos_install](#nos_install1)
    - [nos_install_verbose](#nos_install_verbose1)
- [Running Commands](#running-commands)
    - [nos_run_process](#nos_run_process2)
    - [nos_run_subprocess](#nos_run_subprocess2)
- [Environment Variables](#environment-variables)
    - [nos_set_evar](#nos_set_evar2)
    - [nos_persist_evar](#nos_persist_evar2)
    - [nos_set_evars](#nos_set_evars0)
    - [nos_persist_evars](#nos_persist_evars0)
    - [nos_set_evars_whitelist](#nos_set_evars_whitelist1)
    - [nos_persist_evars_whitelist](#nos_persist_evars_whitelist1)
    - [nos_set_evars_blacklist](#nos_set_evars_blacklist1)
    - [nos_persist_evars_blacklist](#nos_persist_evars_blacklist1)
- [Running Hooks](#running-hooks)
    - [nos_run_hooks](#nos_run_hooks1)
- [Templates](#templates)
    - [nos_template](#nos_template1)
    - [nos_template_file](#nos_template_file1)

#### Payload

##### nos_payload(1)

    $1 = key

    A simple getter for fetching a payload value

#### Validation

##### nos_validate_presence(1)

    $1 = field
    
    Validate that a field exists within the boxfile payload and has a value.
    If the check fails, a fatal error will be printed an a non-zero exit
    will be forced.

##### nos_validate_in(2)

    $1 = field
    $2 = possible values
    
    Validates that if a field exists, the value present falls within a range
    of acceptable options.
    
##### nos_validate_not_in(2)

    $1 = field
    $2 = possible values
    
    Validates that if a field exists, the value present falls does not fall
    within a range of options.
    
#### Printing Output

##### nos_print_header(1)
    
    $1 = label
    
    Print a header, formatted to 70 characters, with the label
    
    Example:
    
    nos_print_header "headline here"
    
    would produce:
    ::::::::::::::::::::::::::: HEADLINE HERE :::::::::::::::::::::::::::

##### nos_print_process_start(1)
    
    $1 = label
    
    Print a header indicating the start of a process.
    
    Example:
    
    nos_print_process_start "installing ruby-2.2"
    
    would produce:
    INSTALLING RUBY-2.2 ------------------------------------------------>

##### nos_print_process_end()
    
    Creates a hard delineation after a process

##### nos_print_subtask_start(1)
    
    $1 = label
    
    Print a header indicating the start of a sub task
    
    Example:
    
    nos_print_subtask_start "after build hook 1"
    
    would produce:
    AFTER BUILD HOOK 1 -------------------->

##### nos_print_subtask_success(0)
    
    Print a footer indicating a successful sub task
    
    Example:
    
    nos_print_subtask_success
    
    would produce:
       [√] SUCCESS

##### nos_print_subtask_fail(0)
    
    Print a footer indicating a failed sub task
    
    Example:
    
    nos_print_subtask_fail
    
    would produce:
       [!] FAILED

##### nos_print_bullet(1)
    
    $1 = message
    
    Print a line item in the form of a bullet point
    
    Example:
    
    nos_print_bullet "Language Detected : Ruby"
    
    would produce:
    +> Language Detected : Ruby

##### nos_print_bullet_info(1)
    
    $1 = message
    
    Print a line item as followup info to a bullet point
    
    Example:
    
    nos_print_bullet_info "Language Detected : Ruby"
    
    would produce:
       Language Detected : Ruby

##### nos_print_bullet_sub(1)
    
    $1 = message
    
    Print a line item as a sub or followup item to a bullet point
    
    Example:
    
    nos_print_bullet_sub "Language Detected : Ruby"
    
    would produce:
       - Language Detected : Ruby

##### nos_print_warning(1)
    
    $1 = message
    
    Print a warning message, formatted to a 70 character block paragraph
    
    Example:
    
    nos_print_warning "We've detected you may be using... (abbreviated for clarity)"
    
    would produce:
    -----------------------------  WARNING  -----------------------------
    We've detected you may be using sessions in a way that could cause
    unexpected behavior. Feel free to review the following guide for
    more information : bit.ly/2sA9b

##### nos_print_fatal(2)
    
    $1 = title
    $2 = message
    
    Example:
    
    nos_print_fatal "deploy stream disconnected", "Oh snap... (abbreviated for clarity)"
    
    would produce:
    ! DEPLOY STREAM DISCONNECTED !
    
    Oh snap the deploy stream just disconnected. No worries, you can
    visit the dashboard to view the complete output stream.

##### nos_print_block(1)
    
    $1 = message
    
    Print a message formatted as a block of text, wrapped at 70 characters
    
    Example:
    
    nos_print_block "We've detected you may be using... (abbreviated for clarity)"
    
    would produce:
    We've detected you may be using sessions in a way that could cause
    unexpected behavior. Feel free to review the following guide for
    more information : bit.ly/2sA9b

#### Installing Packages

##### nos_install(1)
    
    $1 = package name
    
    A simple expressive shortcut to install a pkgsrc package via pkgin
    
##### nos_install_verbose(1)
    
    $1 = package name
    
    A simple expressive shortcut to install a pkgsrc package via pkgin,
    with verbose output

#### Running Commands

##### nos_run_process(2)
  
    $1 = process label
    $2 = command
    
    A helper to run a process and format the output according to the styleguide

##### nos_run_subprocess(2)
    
    $1 = process label
    $2 = command
    
    A helper to run a subprocess and format the output according to the styleguide
    
#### Environment Variables

##### nos_set_evar(2)
    
    $1 = key
    $2 = value
    
    Sets an environment variable in the running process

##### nos_persist_evar(2)
    
    $1 = key
    $2 = value
    
    Persists an environment variable which will be available to the process that
    the code runs in after a successful deploy.

##### nos_set_evars(0)
    
    Sets all environment variables from the payload in the running process.

##### nos_persist_evars(0)
    
    Persists all environment variables from the payload to be available to the
    process that the code runs in.

##### nos_set_evars_whitelist(1)
    
    $1 = whitelist regex
    
    Sets an environment variable in the running process, from the payload,
    according the the whitelist.

##### nos_persist_evars_whitelist(1)
    
    $1 = whitelist regex
    
    Persists environment variables from the payload to be available to the
    process that the code runs in, according the the whitelist.

##### nos_set_evars_blacklist(1)
    
    $1 = blacklist regex
    
    Sets an environment variable in the running process, from the payload,
    according the the blacklist.

##### nos_persist_evars_blacklist(1)
    
    $1 = blacklist regex
    
    Persists environment variables from the payload to be available to the
    process that the code runs in, according the the blacklist.
    
#### Running Hooks

##### nos_run_hooks(1)
    
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
      1) nos_run_hooks "before"
      2) nos_run_hooks "after"
      
#### Templates

##### nos_template(3)
    
    $1 = source
    $2 = destination
    $3 = JSON|YAML payload
    
    Renders a mustache template from the templates directory and persists the
    result at (destination). The payload provided is passed to mustache.

##### nos_template_file(2)
    
    $1 = source
    $2 = destination
    
    Copies a file from the files directory to the specified destination.
