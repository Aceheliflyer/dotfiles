# Add XDG support prior to anything else.
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state

# Check and set-up TMUX first.
if status is-interactive
and not set -q TMUX
  exec tmux new -As root
end

# Set prompt & vim-like keybindings and clear annoying greeting.
starship init fish | source
set fish_greeting
fish_vi_key_bindings

# Set various SSH parameters.
if string match -e 'kitty' $TERM; alias ssh 'kitty +kitten ssh'; end
set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
set -x GPG_TTY $(tty)

# Custom aliases.
alias cat 'bat'; alias find 'fd'; alias grep 'rg'; alias ps 'procs'
alias ls 'exa --classify --icons --git'
alias li 'ls --long --header --group --modified --created --octal-permissions'
alias tree 'ls --tree'

alias tb 'nc termbin.com 9999'
alias pacman-packages 'pacman -Qq | fzf --preview \'pacman -Qil {}\' --layout=reverse --bind \'enter:execute(pacman -Qil {} | less)\''
alias dry 'docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -e DOCKER_HOST=$DOCKER_HOST moncho/dry'
alias lzd 'docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/.config/lazydocker:/.config/jesseduffield/lazydocker lazyteam/lazydocker'
