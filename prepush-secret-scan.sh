#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
patterns='(thk_live_[A-Za-z0-9_-]{8,}|github_pat_[A-Za-z0-9_]{8,}|ghp_[A-Za-z0-9]{20,}|sk-[A-Za-z0-9_-]{16,}|(api[_-]?key|access[_-]?token|password)[[:space:]]*[:=][[:space:]]*["'"'][^"'"']{8,}["'"'])'
files=$(git ls-files 2>/dev/null || find . -type f -not -path './.git/*')
if [ -n "$files" ] && printf '%s\n' "$files" | xargs grep -nEI "$patterns"; then
  echo 'REFUSED: possible credential material found.' >&2
  exit 1
fi
echo 'PASS: no credential material detected.'
