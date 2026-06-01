#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"
package_dir="${repo_root}/packages/figma-to-code-process"
install_codex=1
install_claude=1
install_generic=1
dry_run=0

usage() {
  cat <<'USAGE'
Install the Figma-to-code process package for local coding agents.

Usage:
  scripts/install-figma-to-code-process.sh [options]

Options:
  --codex-only       Install only to ~/.codex/skills
  --claude-only      Install only to ~/.claude/skills and ~/.claude/commands
  --generic-only     Install only to ~/.agent-skills
  --all              Install to Codex, Claude Code, and generic locations
  --dry-run          Print destinations without copying
  -h, --help         Show this help
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --codex-only)
      install_codex=1
      install_claude=0
      install_generic=0
      ;;
    --claude-only)
      install_codex=0
      install_claude=1
      install_generic=0
      ;;
    --generic-only)
      install_codex=0
      install_claude=0
      install_generic=1
      ;;
    --all)
      install_codex=1
      install_claude=1
      install_generic=1
      ;;
    --dry-run)
      dry_run=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

if [[ ! -f "${package_dir}/SKILL.md" ]]; then
  echo "Package not found: ${package_dir}" >&2
  exit 1
fi

copy_package() {
  local destination="$1"
  case "${destination}" in
    */figma-to-code-process) ;;
    *)
      echo "Refusing unsafe destination: ${destination}" >&2
      exit 1
      ;;
  esac

  if [[ "${dry_run}" -eq 1 ]]; then
    echo "[dry-run] install package -> ${destination}"
    return
  fi

  mkdir -p "$(dirname "${destination}")"
  rm -rf "${destination}"
  cp -R "${package_dir}" "${destination}"
  echo "Installed package -> ${destination}"
}

write_claude_command() {
  local command_dir="${HOME}/.claude/commands"
  local command_file="${command_dir}/figma-to-code.md"

  if [[ "${dry_run}" -eq 1 ]]; then
    echo "[dry-run] install Claude Code command -> ${command_file}"
    return
  fi

  mkdir -p "${command_dir}"
  cat > "${command_file}" <<'COMMAND'
Use the installed Figma-to-code process package.

1. Read ~/.claude/skills/figma-to-code-process/SKILL.md.
2. Follow it as the single workflow entry point.
3. Load only the referenced phase files needed for the current task.
COMMAND
  echo "Installed Claude Code command -> ${command_file}"
}

if [[ "${install_codex}" -eq 1 ]]; then
  copy_package "${CODEX_HOME:-${HOME}/.codex}/skills/figma-to-code-process"
fi

if [[ "${install_claude}" -eq 1 ]]; then
  copy_package "${HOME}/.claude/skills/figma-to-code-process"
  write_claude_command
fi

if [[ "${install_generic}" -eq 1 ]]; then
  copy_package "${HOME}/.agent-skills/figma-to-code-process"
fi

echo "Done. Invoke the package as figma-to-code-process."

