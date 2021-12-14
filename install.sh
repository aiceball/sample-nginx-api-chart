#!/bin/bash
set -eux
set -o pipefail

release_name=$1
namespace="${2:-default}"

helm template -n $namespace $release_name core-api/
echo "Deploy?"
read -r
helm upgrade --install -n $namespace $release_name core-api/
