#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RUN_DIR="${ROOT_DIR}/.run"
JAVA_HOME="${NIMBUS_JAVA_HOME:-/opt/homebrew/Cellar/openjdk/25.0.1/libexec/openjdk.jdk/Contents/Home}"
JAR="${ROOT_DIR}/backend/nimbus-server/target/nimbus-server.jar"

mkdir -p "${RUN_DIR}"
[[ -f "${JAR}" ]] || { echo "缺少 nimbus-server.jar，请先执行 scripts/build-local.sh" >&2; exit 1; }

cleanup() {
  trap - INT TERM EXIT
  kill "${pid}" 2>/dev/null || true
  wait "${pid}" 2>/dev/null || true
}
trap cleanup INT TERM EXIT

"${JAVA_HOME}/bin/java" ${JAVA_OPTS:--Xms512m -Xmx1024m} \
  -jar "${JAR}" --spring.profiles.active=local \
  >"${RUN_DIR}/nimbus-server.log" 2>&1 &
pid=$!
echo "${pid}" > "${RUN_DIR}/nimbus-server.pid"
echo "Nimbus 后端已托管（PID ${pid}，端口 58080）"
wait "${pid}"
