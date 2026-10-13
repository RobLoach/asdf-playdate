#!/usr/bin/env bash

exec shellcheck -s bash -x \
  bin/* scripts/*.bash setup.bash -P lib/
