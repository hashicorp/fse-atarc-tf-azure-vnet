#!/bin/bash
#set -x # Uncomment to Debug

rm *.tf
/usr/local/bin/md-tangle ./README.md
/usr/local/bin/terraform fmt
