#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
skill_dir="$(cd "${script_dir}/.." && pwd)"
metadata_file="${skill_dir}/.install-metadata"

source_url="https://github.com/markun777/figma-to-code-skills.git"
source_ref="main"
installed_commit=""
refresh_command="curl -fsSL https://raw.githubusercontent.com/markun777/figma-to-code-skills/main/scripts/install-from-github.sh | bash"

if [[ -f "${metadata_file}" ]]; then
  # shellcheck disable=SC1090
  source "${metadata_file}"
fi

if [[ -z "${installed_commit}" || "${installed_commit}" == "unknown" ]]; then
  echo "No install commit recorded for ${skill_dir}."
  echo "Refresh with:"
  echo "  ${refresh_command}"
  exit 3
fi

latest_commit="$(git ls-remote "${source_url}" "refs/heads/${source_ref}" | awk '{print $1}')"

if [[ -z "${latest_commit}" ]]; then
  echo "Could not resolve latest commit for ${source_url} ${source_ref}."
  exit 1
fi

echo "Installed commit: ${installed_commit}"
echo "Latest ${source_ref}:    ${latest_commit}"

if [[ "${installed_commit}" == "${latest_commit}" ]]; then
  echo "figma-to-code-process is up to date."
  exit 0
fi

echo "Update available for figma-to-code-process."
echo "Refresh from a local source repo with:"
echo "  scripts/install-figma-to-code-process.sh --all"
echo "Or refresh from GitHub with:"
echo "  ${refresh_command}"
exit 2
