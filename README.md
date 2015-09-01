# nanobox-nos
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

#### Payload

##### payload(1)

    $1 = key

    A simple getter for fetching a payload value
