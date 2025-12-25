#!/usr/bin/env bash

# Tool - Description of tool
#
# Usage:
#
# Author  : <NAME> <EMAIL>
# Version :
# License :

set -euo pipefail   # strict mode
IFS=$'\n\t'

# --- Core path definition ---
readonly SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
readonly SCRIPT_NAME=$(basename "${BASH_SOURCE[0]}")

# --- Color definition ---
setup_colors() {
	if [[ -t 1 || -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
		readonly RED='\033[0;31m'
		readonly GREEN='\033[0;32m'
		readonly YELLOW='\033[0;33m'
		readonly BLUE='\033[0;34m'
		readonly MAGENTA='\033[0;35m'
		readonly CYAN='\033[0;36m'
		readonly WHITE='\033[0;37m'
		readonly BOLD='\033[1m'
		readonly NC='\033[0m'
	else
		readonly RED='' GREEN='' YELLOW='' BLUE='' MAGENTA='' CYAN='' WHITE='' BOLD='' NC=''
	fi
}

# --- Logging function ---
log() { echo -e "${BLUE}[$(date +'%Y-%m-%dT%H:%M:%S%z')]${NC} $*"; }
info() { echo -e "${GREEN}[INFO]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*" >&2; }
error() { echo -e "${RED}[ERROR]${NC} $*" >&2; }

# --- Helper function ---
show_help() {
	cat << EOF
Usage: ${SCRIPT_NAME} [OPTION] [ARGS]

Description:
	...

Options:
	-h, --help      show help message

Arguments:

Example:

EOF
}

# --- cleanup function ---
cleanup() {
	# 1. get exit status code
	local exit_code=$?

	# 2. disable trap
	trap - SIGINT SIGTERM EXIT

	# 3. clean temp files...


	# 4. give exit hint
	if [ "$exit_code" -ne 0 ]; then
		error "Script exit abnormally!"
	fi

	# 5. exit
	exit "$exit_code"
}
trap cleanup SIGINT SIGTERM EXIT

# --- Arguments parse ---
parse_params() {
	# flags
	# VERBOSE=false

	while [[ $# -gt 0 ]]; do
		case "$1" in
			-h|--help)
				show_help
				exit 0
				;;
			# ...
			# shift
			# ;;
			-?*)
				error "Unknown option: $1"
				show_help
				exit 1
				;;
		esac
	done
}

# --- main logic ---
main() {
	setup_colors
	parse_params "$@"

	info "${BOLD}Script started.${NC}"
	# ...

	info "${BOLD}Script completed successfully.${NC}"
}

# start script
main "$@"
