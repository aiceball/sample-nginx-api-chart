#!/bin/bash
set -eux
set -o pipefail

release_name=$1
namespace="${2:-default}"

helm uninstall -n $namespace $release_name
