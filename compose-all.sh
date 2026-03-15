#!/usr/bin/env bash

set -eu

for dir in stacks/*; do
  (cd $dir && sudo docker compose $@)
done
