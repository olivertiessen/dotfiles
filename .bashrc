# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Path to your oh-my-bash installation.
export OSH="$HOME/.oh-my-bash"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="powerline"

# If you set OSH_THEME to "random", you can ignore themes you don't like.
# OMB_THEME_RANDOM_IGNORED=("powerbash10k" "wanelo")
# You can also specify the list from which a theme is randomly selected:
# OMB_THEME_RANDOM_CANDIDATES=("font" "powerline-light" "minimal")

# Uncomment the following line to use case-sensitive completion.
# OMB_CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# OMB_HYPHEN_SENSITIVE="false"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you don't want the repository to be considered dirty
# if there are untracked files.
# SCM_GIT_DISABLE_UNTRACKED_DIRTY="true"

# Uncomment the following line if you want to completely ignore the presence
# of untracked files in the repository.
# SCM_GIT_IGNORE_UNTRACKED="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.  One of the following values can
# be used to specify the timestamp format.
# * 'mm/dd/yyyy'     # mm/dd/yyyy + time
# * 'dd.mm.yyyy'     # dd.mm.yyyy + time
# * 'yyyy-mm-dd'     # yyyy-mm-dd + time
# * '[mm/dd/yyyy]'   # [mm/dd/yyyy] + [time] with colors
# * '[dd.mm.yyyy]'   # [dd.mm.yyyy] + [time] with colors
# * '[yyyy-mm-dd]'   # [yyyy-mm-dd] + [time] with colors
# If not set, the default value is 'yyyy-mm-dd'.
# HIST_STAMPS='yyyy-mm-dd'

# Uncomment the following line if you do not want OMB to overwrite the existing
# aliases by the default OMB aliases defined in lib/*.sh
# OMB_DEFAULT_ALIASES="check"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# To disable the uses of "sudo" by oh-my-bash, please set "false" to
# this variable.  The default behavior for the empty value is "true".
OMB_USE_SUDO=true

# To enable/disable display of Python virtualenv and condaenv
# OMB_PROMPT_SHOW_PYTHON_VENV=true  # enable
# OMB_PROMPT_SHOW_PYTHON_VENV=false # disable

# To enable/disable Spack environment information
# OMB_PROMPT_SHOW_SPACK_ENV=true  # enable
# OMB_PROMPT_SHOW_SPACK_ENV=false # disable

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bashmarks
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

# If you want to reduce the initialization cost of the "tput" command to
# initialize color escape sequences, you can uncomment the following setting.
# This disables the use of the "tput" command, and the escape sequences are
# initialized to be the ANSI version:
#
#OMB_TERM_USE_TPUT=no

# Powerline prompt: user + directory only, no git branch
POWERLINE_PROMPT="user_info python_venv ruby cwd"

source "$OSH"/oh-my-bash.sh

# Hide the failed-command exit-status segment entirely (must come after the theme loads)
function __powerline_last_status_prompt { :; }

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"

# aliases
alias ll='ls -la'
# dotfiles: git for the bare repo in ~/dotfiles; `dotfiles pull` keeps the LOCAL ONLY part of ~/.bashrc
dotfiles() {
    local git=(git --git-dir="$HOME/dotfiles" --work-tree="$HOME")
    local marker='^# ---- LOCAL ONLY'
    if [[ $1 == sync ]]; then    # dotfiles sync ["message"]: stage tracked files, commit, pull --rebase, push
        local tail_bak=~/.bashrc.localtail.bak sync_rc
        sed -n "/$marker/,\$p" ~/.bashrc | tail -n +2 > "$tail_bak"    # safety copy of the LOCAL ONLY part
        "${git[@]}" add -u || return
        if ! "${git[@]}" diff --cached --quiet; then
            "${git[@]}" commit -m "${2:-Update dotfiles}" || return
        fi
        dotfiles pull --rebase --autostash && "${git[@]}" push
        sync_rc=$?
        if [[ -s $tail_bak ]] && ! grep -qxFf <(head -n 3 "$tail_bak" | grep -v '^$') ~/.bashrc; then
            sed -i "/$marker/q" ~/.bashrc; cat "$tail_bak" >> ~/.bashrc    # the sync lost it: put it back
            echo "dotfiles: restored the LOCAL ONLY part of ~/.bashrc" >&2
        fi
        return $sync_rc
    fi
    if [[ $1 != pull ]]; then
        "${git[@]}" "$@"
        return
    fi
    local keep rc
    keep=$(mktemp)
    sed -n "/$marker/,\$p" ~/.bashrc | tail -n +2 > "$keep"
    "${git[@]}" "$@"
    rc=$?
    sed -i "/$marker/q" ~/.bashrc
    cat "$keep" >> ~/.bashrc
    rm -f "$keep"
    [[ $rc == 0 ]] && "${git[@]}" add ~/.bashrc    # refresh git's view of the rewritten file
    return $rc
}
alias ll='ls -lah' 
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'           # jump back to the previous directory
mkcd() { mkdir -p "$1" && cd "$1"; }   # a function, not an alias

alias rm='rm -I'            # asks once before deleting 3+ files or a folder
alias cp='cp -i'            # asks before overwriting
alias mv='mv -i'

alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'

alias gs='git status -sb'
alias ga='git add'
alias gc='git commit -m'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate -15'
# adds all, commits with message and pushes in one command, use: git yolo "my message"
git config --global alias.yolo '!f() { [ "$1" = "-m" ] && shift; git add -A && git commit -m "$1" && git push; }; f'
alias gy='git yolo'

alias please='sudo $(fc -ln -1)'    # rerun the last command with sudo
alias ports='ss -tulpn'             # what's listening
alias c='clear'
alias h='history | tail -30'

# History: large, de-duplicated, shared live between terminals (must come after the theme loads)
HISTSIZE=100000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
PROMPT_COMMAND="history -a; ${PROMPT_COMMAND}"

# fzf: Ctrl-R fuzzy history, Ctrl-T file picker, Alt-C cd into directory
[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
[ -f /usr/share/bash-completion/completions/fzf ] && source /usr/share/bash-completion/completions/fzf

# ROS 2 workspace helpers: find the workspace by walking up from the current directory
_ws_up() {    # _ws_up <file-or-dir>: print the nearest parent directory containing it
    local d=$PWD
    while [[ $d != / ]]; do
        [[ -e $d/$1 ]] && { echo "$d"; return; }
        d=$(dirname "$d")
    done
    return 1
}
sb() {        # source the nearest install/setup.bash
    local ws
    ws=$(_ws_up install/setup.bash) || { echo "no install/setup.bash found above $PWD" >&2; return 1; }
    source "$ws/install/setup.bash" && echo "sourced $ws/install/setup.bash"
}
cb() {        # build the nearest workspace (the one with src/), then source it; extra args go to colcon
    local ws
    ws=$(_ws_up src) || { echo "no workspace (src/) found above $PWD" >&2; return 1; }
    (cd "$ws" && colcon build --symlink-install "$@") && source "$ws/install/setup.bash"
}
alias tl="ros2 topic list"
alias tele="ros2 run teleop_twist_keyboard teleop_twist_keyboard"

# ---- LOCAL ONLY: everything below this line stays on this machine (not committed) ----
