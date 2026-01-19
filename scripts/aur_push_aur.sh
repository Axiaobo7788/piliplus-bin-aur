#!/usr/bin/env bash
set -euo pipefail

package_dir="${1:-.}"
branch="${2:-master}"

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
fi

git push aur "HEAD:${branch}"

popd >/dev/null

echo "Pushed to AUR: $AUR_REPO ($branch)"