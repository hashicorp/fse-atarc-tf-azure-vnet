#!/bin/bash
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

#set -x # Uncomment to Debug

rm *.tf
/usr/local/bin/md-tangle ./README.md
/usr/local/bin/terraform fmt
