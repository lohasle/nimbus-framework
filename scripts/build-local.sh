#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
JAVA_HOME="${NIMBUS_JAVA_HOME:-/opt/homebrew/Cellar/openjdk/25.0.1/libexec/openjdk.jdk/Contents/Home}"

export JAVA_HOME
export PATH="${JAVA_HOME}/bin:${PATH}"
cd "${ROOT_DIR}/backend"
mvn -s settings.xml clean package "$@"
