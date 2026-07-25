# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
	zsh-autosuggestions
	z
	kubectl
	helm
	terraform
	aws
	docker
	ansible
	archlinux
	fzf
)

source $ZSH/oh-my-zsh.sh

# User configuration
# Enable completion
autoload -U compinit
compinit

# Set autocompletion color options
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=242"

# Set flux autocompletion
fpath=(~/.oh-my-zsh/completions $fpath)
autoload -Uz compinit
compinit

#zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking





# Auto-start tmux if not already inside a tmux session
if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
  tmux new-session -A -s main
fi

# kubectl completion
_kc="$HOME/.kube/completion.zsh"
[[ -f "$_kc" ]] || kubectl completion zsh >"$_kc"
source "$_kc"

export EDITOR="nvim"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

alias vim="nvim"
alias sd='pkill -SIGKILL -f google-chrome; sleep 1; python3 -c "import json,os; p=os.path.expanduser(\"~/.config/google-chrome/Default/Preferences\"); d=json.load(open(p)); d.setdefault(\"profile\",{})[\"exit_type\"]=\"Normal\"; d[\"profile\"][\"exited_cleanly\"]=True; json.dump(d,open(p,\"w\"))" 2>/dev/null; shutdown now'
alias rb='pkill -SIGKILL -f google-chrome; sleep 1; python3 -c "import json,os; p=os.path.expanduser(\"~/.config/google-chrome/Default/Preferences\"); d=json.load(open(p)); d.setdefault(\"profile\",{})[\"exit_type\"]=\"Normal\"; d[\"profile\"][\"exited_cleanly\"]=True; json.dump(d,open(p,\"w\"))" 2>/dev/null; systemctl reboot'
alias k="kubectl"
alias kc="kubectx"
alias ns="kubens"
alias lg="lazygit"
alias pd="kubectl get pods --all-namespaces --no-headers | grep -vE 'Running|Completed'"
alias mic="arecord -vvv /dev/null"
alias sandbox="docker compose -f /home/mnt/claude/compose.yaml run --rm claude --dangerously-skip-permissions"
alias kzapply="kustomize build . | kubectl apply -f -"
alias kzdiff="kustomize build . | kubectl diff -f -"


compdef k=kubectl

# Dotfiles bare repo management
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dotfiles-ui='lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

source <(kubectl completion zsh)

eval "$(direnv hook zsh)"

eval "$(starship init zsh)"

unsetopt PROMPT_CR
