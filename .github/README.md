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

# 6. Put the files into your home folder (overwrites existing ones)
dotfiles checkout -f

# 7. Install terminator, Oh My Bash and the Nerd Font
~/.config/dotfiles/setup.sh
```

Then open a new terminal and set the font to "JetBrainsMono Nerd Font Mono" if Terminator doesn't pick it up.

## Changing things

Edit the files where they are, then commit:

```bash
dotfiles status                      # what changed?
dotfiles add -u                      # stage changes to files already tracked
dotfiles commit -m "what I changed"
dotfiles push
```

On another machine, get the changes with `dotfiles pull`.

To start tracking a new file: `dotfiles add -f ~/.config/something`. The `-f` is needed because everything in your home folder is ignored by default; that is what makes `dotfiles add .` safe.

## Settings for one machine only

`~/.bashrc` ends with a line starting `# ---- LOCAL ONLY`. Put things that only belong to that machine below it (proxy, ROS, paths). When you commit, everything below that line is cut out, so it never reaches GitHub. `dotfiles pull` leaves that section alone.

Only `dotfiles pull` is safe for this. A plain `git pull` or `dotfiles checkout -f` overwrites the whole `.bashrc`.
