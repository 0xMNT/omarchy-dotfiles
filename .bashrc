# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# ble.sh - bash line editor with autosuggestions (load at top, configure below)
[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh --noattach

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# Auto-start tmux if not already inside a tmux session
if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s main
fi

# Add your own exports, aliases, and functions here.
export EDITOR="nvim"

# Make an alias for invoking commands you use constantly
alias vim="nvim"
alias sd="shutdown now"

# Dotfiles bare repo management
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dotfiles-ui='lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# ble.sh autosuggestion color (equivalent to ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=242")
ble-face -s auto_complete fg=242
bleopt highlight_syntax=


if [[ ${BLE_VERSION-} ]]; then
  bleopt complete_auto_history=1
  ble-attach
fi
