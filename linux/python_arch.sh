#!/bin/bash
# Copyright (c) 2010 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# This figures out the architecture of the version of Python we are building
# pyautolib against.
#
#  python_arch.sh /usr/lib/libpython2.5.so.1.0
#  python_arch.sh /path/to/sysroot/usr/lib/libpython2.4.so.1.0
#

set -e

python=$(readlink -f "$1")
file_out=$(file "$python")

set +e

echo $file_out | grep -qs "ARM"
if [ $? -eq 0 ]; then
  echo arm
  exit 0
fi

echo $file_out | grep -qs "x86-64"
if [ $? -eq 0 ]; then
  echo x64
  exit 0
fi

echo $file_out | grep -qs "Intel 80386"
if [ $? -eq 0 ]; then
  echo ia32
  exit 0
fi

exit 1
