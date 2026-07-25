# System Notes

## Dotfiles Repo

Bare git repo at `~/.dotfiles`, work-tree is `~`. All git commands use:

```bash
git --git-dir=~/.dotfiles --work-tree=~ <command>
```

Aliased as `dotfiles` and `dotfiles-ui` (lazygit) in `.bashrc`.
Remote: `github.com:0xMNT/omarchy-dotfiles.git`, branch `master`.

The `.gitignore` uses an **allowlist** pattern (`*` ignores everything, then explicit `!` entries).
To track a new file in `~`, add `!filename` to `.gitignore` first.

## Machine-Specific Config Files (gitignored)

These files exist locally but are never synced — each machine manages its own:

| File | Purpose |
| ------ | --------- |
| `~/.config/hypr/monitors-local.conf` | Monitor scale/position overrides |
| `~/.config/hypr/input-local.conf` | Touchpad/mouse sensitivity overrides |
| `~/.config/waybar/style.local.css` | Waybar style overrides |
| `~/.config/git/config.local` | Git user identity (`name`, `email`) |

## Display / Monitor Scaling

This machine has a 1080p non-HiDPI display (`eDP-1`, 1920x1080@60).

The global `monitors.conf` sets `GDK_SCALE,2` (intended for retina/4K external monitors).
On a 1080p laptop screen, that global setting makes apps appear very small.

**Fix in `~/.config/hypr/monitors-local.conf`:**

```
monitor = eDP-1, 1920x1080@60, 0x1080, 1.5
env = GDK_SCALE,1
```

- `scale 1.5` — Hyprland scales everything 50% larger (logical resolution ~1280×720)
- `GDK_SCALE,1` — overrides the global `GDK_SCALE,2` so GTK apps aren't double-scaled

If connecting a 4K external (`DP-1`), the `GDK_SCALE,1` override applies globally for the session — GTK apps may appear less sharp on the 4K display.

## Git Identity

Git user is set per-machine via `~/.config/git/config.local` (gitignored, not synced).
This machine: `0xMNT <idntmnt@gmail.com>`.
