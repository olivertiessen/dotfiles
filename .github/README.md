# dotfiles

My shell and terminal setup: Bash with Oh My Bash (powerline prompt), Terminator, vim.

The files are not symlinked. They sit in your home folder as usual (`~/.bashrc`, ...), and this repo just watches them. The repo's data lives in `~/dotfiles`.

## Set up a new machine (Debian/Ubuntu)

```bash
# 1. Download the repo's data (no files are placed yet)
git clone --bare https://github.com/olivertiessen/dotfiles.git ~/dotfiles

# 2. A shortcut for git commands on this repo (the real one comes with .bashrc later)
alias dotfiles='git --git-dir=$HOME/dotfiles --work-tree=$HOME'

# 3. Don't list every file in your home folder as "untracked"
dotfiles config status.showUntrackedFiles no

# 4. Keep the LOCAL ONLY part of .bashrc out of commits (explained below)
echo '.bashrc filter=localtail' >> ~/dotfiles/info/attributes
dotfiles config filter.localtail.clean "sed '/^# ---- LOCAL ONLY/q'"

# 5. Put the files into your home folder (overwrites existing ones)
dotfiles checkout -f

# 6. Install terminator, Oh My Bash and the Nerd Font
~/.config/dotfiles/setup.sh
```

Then open a new terminal and set the font to "JetBrainsMono Nerd Font Mono" if Terminator doesn't pick it up.

## Changing things

Edit the files where they are, then commit:

```bash
dotfiles status                      # what changed?
dotfiles add ~/.bashrc               # pick the file(s)
dotfiles commit -m "what I changed"
dotfiles push
```

On another machine, get the changes with `dotfiles pull`.

## Settings for one machine only

`~/.bashrc` ends with a line starting `# ---- LOCAL ONLY`. Put things that only belong to that machine below it (proxy, ROS, paths). When you commit, everything below that line is cut out, so it never reaches GitHub. `dotfiles pull` leaves that section alone.

Only `dotfiles pull` is safe for this. A plain `git pull` or `dotfiles checkout -f` overwrites the whole `.bashrc`.
