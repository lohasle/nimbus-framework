#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PID_FILE="${ROOT_DIR}/.run/nimbus-server.pid"
pid="-"
process_state="未运行"
port_state="未监听"

if [[ -f "${PID_FILE}" ]]; then
  pid="$(<"${PID_FILE}")"
  kill -0 "${pid}" 2>/dev/null && process_state="运行中"
fi
nc -z 127.0.0.1 58080 2>/dev/null && port_state="已监听"
printf 'nimbus-server  PID=%s  %s / %s\n' "${pid}" "${process_state}" "${port_state}"
