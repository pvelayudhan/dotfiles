# dotfiles

Configuration files intended for usage with `Fedora Sway Spin 42`.
I developed them for a working with sway, neovim, git, kitty, bash, and tmux.
The neovim configuration started many moons ago from a base of [Launch.nvim](https://github.com/LunarVim/Launch.nvim) (which is also where the GPL license came from).

## Automated installation

These are all just regular configuration files that can be manually copy and pasted or symbolically linked to where they belong.
Each program directory contains an identically named subdirectory as well as a README file indicating where each of those subdirectories should go to function.

The `bootstrap.sh` script was intended to be non-destructive by asking for permissions before symbolically linking over a directory (or creating a full backup in the case of kitty).

At your own risk, you can automate the dotfile symbolic linking and/or program and font installing with:

```
chmod +x bootstrap.sh
./bootstrap.sh
```

This script appends logging information to the file `bootstrap-install.log`.

## Configuring installed programs (bootstrap.conf)

### `[dnf]`

`bootstrap.conf` can be edited to change what programs are installed by `bootstrap.sh`.
Programs can be added to the `[dnf]` section if they are available on the dnf repository.
Lines can be commented out of bootstrap.conf with `#` symbols.

### `[custom-install]`

Programs under the `[custom-install]` must be installed through more complex processes.
Adding programs to `[custom-install]` requires manually integrating them into a switch statement (you'll find it) in `bootstrap.sh`.

### `[dotfiles]`

Programs under the `[dotfiles]` section have their corresponding dotfiles symbolically linked from this repository into locations on the machine (usually ~/.config) where they will be actively used.
Adding programs to this section requires manually integrating them into a different switch statement (you'll find it too) in `bootstrap.sh`.

### `[fonts]`

Same story as `[custom-install]` and `[dotfiles]`.

## Light/Dark Switch

The commands `lightson` and `lightsoff` can swap light/dark modes for nearly everything.
Some applications like firefox and neovim need to be manually reloaded to have the swap take effect.

## Things to do that aren't in the script

### Hardware-specific changes

You may want to change things in the sway configuration file (command `nsway` if using the provided dotfiles for bash) to manage monitor/wallpaper/other hardware related things.

### ssh/git integration

```
ssh-keygen -t ed25519 -C "your_email@example.com"
cd ~/.ssh
cat id_ed25519.pub | wl-copy
```

Visit: and paste into https://github.com/settings/ssh/new

### Other programs

- [sioyek (pdf reader)](https://github.com/ahrm/sioyek/releases)
- [anki (flash cards)](https://docs.ankiweb.net/platform/linux/installing.html)
- [quarto (document prep)](https://quarto.org/docs/get-started/)
