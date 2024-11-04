# watzon's dotfiles

I don't really expect anyone to care, but I'm putting this here anyway. - Ghandi probably

## Software

- [GNU Stow](https://www.gnu.org/software/stow/)
- [Git](https://git-scm.com/)
- [Nushell](https://www.nushell.sh/)
- [Starship](https://starship.rs/)
- [Kitty](https://sw.kovidgoyal.net/kitty/)
- [Bun](https://bun.sh/)
- [Carapace](https://github.com/rsteube/carapace)
- [TheFuck](https://github.com/nvbn/thefuck)

```sh
yay -S stow git starship kitty bun carapace thefuck nushell
```

## Setup

> [!WARNING]
> This will overwrite existing files. Use with caution.

```sh
cd ~
git clone --recurse-submodules git@github.com:watzon/dotfiles.git
cd dotfiles
stow --dotfiles --override=* .
```