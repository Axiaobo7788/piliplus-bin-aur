# piliplus-bin (AUR) maintenance helper

This repository contains the AUR packaging files for `piliplus-bin`.

## Auto-update (GitLab CI)

The pipeline uses an Arch Linux container to:

1. Query GitHub Releases for the upstream project.
2. Update `PKGBUILD` (`pkgver`, `pkgrel`, `source_x86_64`).
3. Run `updpkgsums` to refresh checksums.
4. Regenerate `.SRCINFO`.
5. Commit the changes.
6. Push to AUR via SSH.

### Required CI/CD variables

Set in GitLab: **Settings → CI/CD → Variables**

- `AUR_REPO`: `aur@aur.archlinux.org:piliplus-bin.git`
- `AUR_SSH_PRIVATE_KEY`: SSH private key contents used to push to AUR

### Optional: push commits back to GitLab

If you want the CI job to also push the commit to your GitLab repo:

- `PUSH_BACK_TO_GITLAB`: `1`
- `GITLAB_PUSH_TOKEN`: a Personal Access Token with `write_repository`

### Schedules

Create a schedule in GitLab: **Build → Pipeline schedules** (for example, every 6 hours).

### Manual run

You can also run locally on Arch:

- `scripts/aur_update.sh .`

It will update `PKGBUILD`, checksums, and `.SRCINFO` in-place.
