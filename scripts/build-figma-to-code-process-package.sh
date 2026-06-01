#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"
package_dir="${repo_root}/packages/figma-to-code-process"

mkdir -p "${package_dir}/references/source-skills"
mkdir -p "${package_dir}/references/cases"
mkdir -p "${package_dir}/assets"

cp "${repo_root}/inventory/workflow-outline.md" "${package_dir}/references/workflow-outline.md"
cp "${repo_root}/inventory/tech-stack-profile.md" "${package_dir}/references/tech-stack-profile.md"
cp "${repo_root}/inventory/product-restoration-preflight.md" "${package_dir}/references/product-restoration-preflight.md"
cp "${repo_root}/inventory/quality-gates.md" "${package_dir}/references/quality-gates.md"
cp "${repo_root}/inventory/official-skills-alignment.md" "${package_dir}/references/official-skills-alignment.md"
cp "${repo_root}/skills/README.md" "${package_dir}/references/source-skills/index.md"

for skill_readme in "${repo_root}"/skills/*/README.md; do
  skill_name="$(basename "$(dirname "${skill_readme}")")"
  cp "${skill_readme}" "${package_dir}/references/source-skills/${skill_name}.md"
done

for case_file in "${repo_root}"/cases/*.md; do
  cp "${case_file}" "${package_dir}/references/cases/$(basename "${case_file}")"
done

rm -rf "${package_dir}/assets/product-restoration-template"
cp -R "${repo_root}/templates/product-restoration" "${package_dir}/assets/product-restoration-template"

echo "Built ${package_dir}"

