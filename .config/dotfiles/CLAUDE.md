# Dotfiles repo

This is a bare git repo: the git data is in `~/dotfiles` and the work tree is `$HOME`. The files live where programs expect them (`~/.bashrc`, ...), with no copies or symlinks. `~/dotfiles` is not a normal repo, so plain `git` there reports "not a git repository".

Read `~/.github/README.md` for the full explanation. `~/.config/dotfiles/setup.sh` and the tool list in the README are the source of truth for what is installed and on which OS; do not assume from memory.

## Rules

- Use the `dotfiles` function from `~/.bashrc` instead of `git` (it wraps `git --git-dir=$HOME/dotfiles --work-tree=$HOME`). Publish with `dotfiles sync "message"`.
- Everything in `$HOME` is ignored. Start tracking a new file with `dotfiles add -f <file>`.
- Never run `dotfiles checkout -f`, `git pull` or `git reset --hard` here. They overwrite `~/.bashrc`, including the machine-local part.
- `~/.bashrc` ends with a `# ---- LOCAL ONLY` line. Everything below it belongs to that machine and is never committed (a git clean filter cuts it). Do not edit, move or delete it, and after any change to `.bashrc` check that it is still there.
- `dotfiles sync` and `dotfiles pull` keep that section. Use `--rebase --autostash` when pulling.
- Machine-specific settings (proxy, ROS paths) go below the marker. Shared settings go above it and must work on machines without the optional tools, e.g. `command -v tool >/dev/null && ...`.
- When adding a tool, update both `setup.sh` and the tool list in the README.
- Do not commit, push or install packages without being asked.
