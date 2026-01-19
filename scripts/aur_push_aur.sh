#!/usr/bin/env bash
set -euo pipefail

package_dir="${1:-.}"
branch="${2:-master}"
src_ref="${3:-HEAD}"

: "${AUR_REPO:?Set AUR_REPO, e.g. aur@aur.archlinux.org:piliplus-bin.git}"
: "${AUR_SSH_PRIVATE_KEY:?Set AUR_SSH_PRIVATE_KEY (private key contents)}"

mkdir -p ~/.ssh
chmod 700 ~/.ssh

echo "$AUR_SSH_PRIVATE_KEY" > ~/.ssh/aur
chmod 600 ~/.ssh/aur

# Preload host key to avoid interactive prompt.
ssh-keyscan -H aur.archlinux.org >> ~/.ssh/known_hosts 2>/dev/null

export GIT_SSH_COMMAND="ssh -i ~/.ssh/aur -o IdentitiesOnly=yes -o StrictHostKeyChecking=yes"

pushd "$package_dir" >/dev/null

if ! git remote get-url aur >/dev/null 2>&1; then
  git remote add aur "$AUR_REPO"
else
  git remote set-url aur "$AUR_REPO"
fi

# Sync only the minimal AUR files, without pushing CI/scripts to AUR.
tmp_worktree="$(mktemp -d)"
tmp_branch="aur-sync-$(date +%s)"

cleanup() {
  set +e
  git worktree remove -f "$tmp_worktree" >/dev/null 2>&1 || true
  git branch -D "$tmp_branch" >/dev/null 2>&1 || true
  rm -rf "$tmp_worktree" >/dev/null 2>&1 || true
}
trap cleanup EXIT

git fetch -q aur "$branch" || true

if git show-ref --verify --quiet "refs/remotes/aur/${branch}"; then
  git worktree add -f -b "$tmp_branch" "$tmp_worktree" "aur/${branch}"
else
  git worktree add -f --orphan "$tmp_branch" "$tmp_worktree"
fi

pushd "$tmp_worktree" >/dev/null

git rm -r --ignore-unmatch . >/dev/null 2>&1 || true

for f in PKGBUILD .SRCINFO .gitignore; do
  if git -C "$package_dir" cat-file -e "${src_ref}:${f}" 2>/dev/null; then
    git -C "$package_dir" show "${src_ref}:${f}" > "$f"
  elif [[ -f "$package_dir/$f" ]]; then
    cp -f "$package_dir/$f" "$f"
  fi
done

git add PKGBUILD .SRCINFO .gitignore || true

ver="$(grep -E '^pkgver=' PKGBUILD 2>/dev/null | cut -d= -f2 || true)"
if [[ -n "$ver" ]]; then
  msg="Update to ${ver}"
else
  msg="Update package"
fi

if git diff --cached --quiet; then
  echo "No AUR file changes to push."
else
  git commit -m "$msg"
  git push aur "HEAD:${branch}"
fi

popd >/dev/null

popd >/dev/null

echo "Pushed to AUR: $AUR_REPO ($branch)"