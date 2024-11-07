# Load modules
use modules/git/mod.nu *

# Load modular configuration files
use config-files/themes.nu *
use config-files/hooks.nu *
use config-files/plugins.nu *
use config-files/menus.nu *
use config-files/keybindings.nu *

# The default config record
$env.config = {
    show_banner: false
    ls: {
        use_ls_colors: true
        clickable_links: true
    }
    rm: {
        always_trash: false
    }
    # ... other basic configurations ...

    # Load configurations from modules
    color_config: (dark_theme)
    hooks: (get_hooks)
    menus: (get_menus)
    keybindings: (get_keybindings)
} | merge (get_plugin_config)

# Source extras
source ~/.config/nushell/config-files/aliases.nu
source ~/.config/nushell/config-files/functions.nu

# Load carapace to handle some completions
source ~/.cache/carapace/init.nu

# More completions from nu_scripts
source ./nu_scripts/custom-completions/git/git-completions.nu

# Load starship for prompt
use ~/.cache/starship/init.nu
