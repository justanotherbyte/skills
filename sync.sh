#!/usr/bin/env bash
# Fetch the latest upstream skills into .sources/ (sparse, shallow) and symlink them into skills/.
set -euo pipefail
cd "$(dirname "$0")"

# skill name | GitHub repo | path inside the repo
SKILLS="
grill-me|mattpocock/skills|skills/productivity/grill-me
grilling|mattpocock/skills|skills/productivity/grilling
teardown|jakubkrehel/skills|skills/teardown
impeccable|pbakaus/impeccable|.claude/skills/impeccable
sol-loop|t3dotgg/tstack|skills/sol-loop
unslop|cursor/plugins|pstack/skills/unslop
architect|cursor/plugins|pstack/skills/architect
"

mkdir -p .sources skills
for repo in $(echo "$SKILLS" | cut -d'|' -f2 | sort -u); do
  dir=".sources/${repo//\//__}"
  paths=$(echo "$SKILLS" | awk -F'|' -v r="$repo" '$2==r {print $3}')
  if [ -d "$dir/.git" ]; then
    git -C "$dir" pull --quiet --depth 1 --ff-only
  else
    git clone --quiet --depth 1 --filter=blob:none --sparse "https://github.com/$repo.git" "$dir"
  fi
  git -C "$dir" sparse-checkout set --no-cone $paths
  echo "$repo @ $(git -C "$dir" rev-parse --short HEAD)"
done

echo "$SKILLS" | while IFS='|' read -r name repo path; do
  [ -n "$name" ] || continue
  ln -sfn "../.sources/${repo//\//__}/$path" "skills/$name"
  [ -f "skills/$name/SKILL.md" ] || { echo "missing: skills/$name/SKILL.md" >&2; exit 1; }
done
