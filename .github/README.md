# dotfiles

Bash (Oh My Bash, powerline), Terminator, vim. Bare git repo with `$HOME` as the work tree: no symlinks, files live where they're used.

## New machine

```bash
git clone --bare https://github.com/olivertiessen/dotfiles.git ~/dotfiles
alias dotfiles='git --git-dir=$HOME/dotfiles --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no
echo '.bashrc filter=localtail' >> ~/dotfiles/info/attributes
dotfiles config filter.localtail.clean "sed '/^# ---- LOCAL ONLY/q'"
dotfiles checkout -f        # overwrites existing dotfiles
~/.config/dotfiles/setup.sh
```

## Daily use

Edit files in place (`~/.bashrc`, ...), then:

```bash
dotfiles status
dotfiles add ~/.bashrc && dotfiles commit -m "..." && dotfiles push
```

Machine-specific settings (proxy, ROS, ...) go at the bottom of `~/.bashrc`, below the `LOCAL ONLY` line. A git filter strips everything below that line when you commit, so it never leaves the machine. `dotfiles pull` keeps that section when it updates `.bashrc`.
