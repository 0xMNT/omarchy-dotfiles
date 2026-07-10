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
  tmux new-session -A -s main
fi

# auto_complete
_kc="$HOME/.kube/completion.bash"
[[ -f "$_kc" ]] || kubectl completion bash >"$_kc"
source "$_kc"

# Add your own exports, aliases, and functions here.
export EDITOR="nvim"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Make an alias for invoking commands you use constantly
alias vim="nvim"
alias sd="shutdown now"
alias k="kubectl"
alias kc="kubectx"
complete -F __start_kubectl k
alias ns="kubens"
alias lg="lazygit"
alias pd="kubectl get pods --all-namespaces --no-headers | grep -vE 'Running|Completed' | wc -l"

# Dotfiles bare repo management
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dotfiles-ui='lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# ble.sh autosuggestion color (equivalent to ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=242")
ble-face -s auto_complete fg=242
bleopt highlight_syntax=

eval "$(direnv hook bash)"

if [[ ${BLE_VERSION-} ]]; then
  bleopt complete_auto_history=1
  ble-attach
fi
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
