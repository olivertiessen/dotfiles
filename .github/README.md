# dotfiles

My shell and terminal setup: Bash with Oh My Bash (powerline prompt), Terminator, vim.

## What this does

A bare git repo with your home folder as its work tree. Git's data lives in `~/dotfiles`, and the files stay where programs expect them (`~/.bashrc`, ...). There are no copies and no symlinks, and everything in `$HOME` is ignored except the tracked files.

## Why not GNU Stow?

Stow keeps the real files in the repo and symlinks them into your home folder, so you edit through links that tools can silently replace with plain files. Here the files in `~` are the real ones, and the only requirement is git. The trade-off is that a bare repo is less obvious than a folder of symlinks, and it relies on the ignore rule plus two custom pieces (the `dotfiles` function and the `.bashrc` filter).

## Set up a new machine (Debian/Ubuntu)

```bash
# 1. Download the repo's data (no files are placed yet)
git clone --bare https://github.com/olivertiessen/dotfiles.git ~/dotfiles

# 2. A shortcut for git commands on this repo (the real one comes with .bashrc later)
alias dotfiles='git --git-dir=$HOME/dotfiles --work-tree=$HOME'

# 3. Don't list every file in your home folder as "untracked"
dotfiles config status.showUntrackedFiles no

# 4. Ignore everything in your home folder, so `dotfiles add .` can't grab random files
echo '/*' >> ~/dotfiles/info/exclude

# 5. Keep the LOCAL ONLY part of .bashrc out of commits (explained below)
echo '.bashrc filter=localtail' >> ~/dotfiles/info/attributes
dotfiles config filter.localtail.clean "sed '/^# ---- LOCAL ONLY/q'"

# 6. Put the files into your home folder (overwrites existing ones),
#    so first save the current .bashrc: anything machine-specific in it
#    (proxy, paths) can be copied below the LOCAL ONLY line afterwards
[ -f ~/.bashrc ] && cp ~/.bashrc ~/.bashrc.pre-dotfiles.bak
dotfiles checkout -f

# 7. `git clone --bare` doesn't set up branch tracking the way a normal clone
#    does, so the first `dotfiles push` would otherwise fail with
#    "the current branch main has no upstream branch" — fix it now:
dotfiles branch --set-upstream-to=origin/main main

# 8. Install terminator, Oh My Bash and the Nerd Font
~/.config/dotfiles/setup.sh
```

Then open a new terminal and set the font to "JetBrainsMono Nerd Font Mono" if Terminator doesn't pick it up.

## Changing things

Edit the files where they are, then publish with one command:

```bash
dotfiles sync "what I changed"
```

`sync` stages changes to files already tracked, commits them (skipped if nothing changed; with no message it uses "Update dotfiles"), runs `pull --rebase --autostash` so changes from another machine are replayed under yours, and pushes. It keeps the LOCAL ONLY part of `.bashrc` (see below).

The same thing step by step:

```bash
dotfiles status                      # what changed?
dotfiles add -u                      # stage changes to files already tracked
dotfiles commit -m "what I changed"
dotfiles pull --rebase --autostash   # fetch and replay your commits on top
dotfiles push
```

On a machine where you only want the latest changes, use `dotfiles pull --rebase --autostash`. A plain `dotfiles pull` fails when both machines have new commits. Without `--autostash` it fails because `.bashrc` always looks modified (the LOCAL ONLY filter).

To start tracking a new file: `dotfiles add -f ~/.config/something`, then `dotfiles sync`. The `-f` is needed because everything in your home folder is ignored by default; that is what makes `dotfiles add .` safe.

## Settings for one machine only

`~/.bashrc` ends with a line starting `# ---- LOCAL ONLY`. Put things that only belong to that machine below it (proxy, ROS, paths). When you commit, everything below that line is cut out, so it never reaches GitHub. `dotfiles pull` and `dotfiles sync` leave that section alone.

Only those two are safe for this. A plain `git pull` or `dotfiles checkout -f` overwrites the whole `.bashrc`.

`dotfiles sync` also keeps a safety copy of that section in `~/.bashrc.localtail.bak` (not tracked by git) each time it runs. If the section ever goes missing, `sync` puts it back from the copy and prints a message; you can also restore it by hand with `cat ~/.bashrc.localtail.bak >> ~/.bashrc` (after the marker line). The copy is overwritten on every sync, so it only protects against a sync losing the section, not against deleting it yourself.
