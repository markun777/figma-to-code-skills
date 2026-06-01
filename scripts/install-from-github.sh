#!/usr/bin/env bash
set -euo pipefail

repo_url="${FIGMA_TO_CODE_SKILLS_REPO:-https://github.com/markun777/figma-to-code-skills.git}"
repo_ref="${FIGMA_TO_CODE_SKILLS_REF:-main}"
tmp_root="${TMPDIR:-/tmp}"
work_dir="$(mktemp -d "${tmp_root%/}/figma-to-code-skills-install.XXXXXX")"

cleanup() {
  rm -rf "${work_dir}"
}
trap cleanup EXIT

git clone --depth 1 --branch "${repo_ref}" "${repo_url}" "${work_dir}/repo" >/dev/null
"${work_dir}/repo/scripts/install-figma-to-code-process.sh" "$@"

