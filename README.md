# omarchy-dotfiles

Personal dotfiles for [Omarchy](https://omarchy.org/), managed as a bare git repo tracked directly in `$HOME`.

Covers: Hyprland, Waybar, terminals (Alacritty, Kitty, Ghostty), tmux, Neovim, Walker, Mako, Starship, and a custom Tokyo Night theme.

---

## Setup on a fresh Omarchy install

### 1. Add your SSH key to GitHub

Generate an SSH key if you don't have one:

```bash
ssh-keygen -t ed25519 -C "your@email.com"
cat ~/.ssh/id_ed25519.pub
```

Copy the output and add it to your GitHub account at **Settings > SSH and GPG keys**.

Test the connection:

```bash
ssh -T git@github.com
```

---

### 2. Clone the repo

This repo uses a **bare clone** so files are checked out directly into `$HOME` with no symlinks needed.

```bash
git clone --bare git@github.com:0xMNT/omarchy-dotfiles.git ~/.dotfiles
```

---

### 3. Set up the `dotfiles` alias

```bash
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Add it to your shell config so it persists:

```bash
echo "alias dotfiles='git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME'" >> ~/.bashrc
source ~/.bashrc
```

---

### 4. Check out the files

```bash
dotfiles checkout
```

If git warns about existing files being overwritten, back them up first:

```bash
mkdir -p ~/.dotfiles-backup
dotfiles checkout 2>&1 | grep "^\s" | awk '{print $1}' | xargs -I{} mv {} ~/.dotfiles-backup/{}
dotfiles checkout
```

Then hide untracked files from `dotfiles status`:

```bash
dotfiles config --local status.showUntrackedFiles no
```

---

### 5. Apply the theme

```bash
omarchy theme set "Tokyo Night Custom"
```

---

## Daily usage

```bash
dotfiles status                      # see what changed
dotfiles add ~/.config/hypr/bindings.conf
dotfiles commit -m "update bindings"
dotfiles push
```
