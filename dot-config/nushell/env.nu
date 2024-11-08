# Nushell Environment Config File
#
# version = "0.99.1"

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

$env.EDITOR = "nvim"
$env.SUDO_EDITOR = "nvim"

$env.CARGO_HOME = ($env.HOME | path join .cargo)
$env.BUN_INSTALL = ($env.HOME | path join .bun)

# Put any additional system paths here
# They will only be added if the path exists, avoiding errors
let paths = [
  /usr/local/bin
  ($env.CARGO_HOME | path join bin)
  ($env.HOME | path join .local bin)
  ($env.BUN_INSTALL | path join bin)
]

$env.PATH = (
  $env.PATH
  | split row (char esep)
  | append ($paths | where (path exists))
  | uniq # filter so the paths are unique
)

$env.DOCKER_HOST = $"unix://($env.XDG_RUNTIME_DIR)/docker.sock"

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
