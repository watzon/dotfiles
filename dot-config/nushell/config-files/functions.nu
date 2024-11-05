# yazi helper
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# nushell plugin helper
def install_plugin [plugin_name: string, git_repository_url?: string, git_tag?: string] {
    mut cargo_install_flags = {}

    if ($git_repository_url != null) {
        $cargo_install_flags = ($cargo_install_flags | insert "--git" $git_repository_url)
    }

    if $git_tag != null and $git_tag != "" {
        $cargo_install_flags = ($cargo_install_flags | insert "--tag" $git_tag)
    }

    let flags = ($cargo_install_flags | items {|key, value| echo $'($key) ($value)' } | str join " ")
    nu -c $"cargo install --locked ($flags) nu_plugin_($plugin_name)";

    const home_directory = ("~" | path expand)
    let cargo_bin_directory = $"($home_directory)/.cargo/bin"
    mut plugin_path = $"($cargo_bin_directory)/nu_plugin_($plugin_name)"
    if (sys host | get name) == "Windows" {
        $plugin_path += ".exe"
    }
    
    nu -c $"plugin add ($plugin_path)"
}

# Create beautiful code screenshots using inkify (https://inkify.0x45.st/)
# 
# Examples:
#   # Save to a file
#   open code.rs | inkify --language rust | save code.png
#   
#   # Display in terminal (requires kitty terminal)
#   open code.rs | inkify --language rust | kitten icat
#   
#   # Display in terminal (requires terminal with sixel support)
#   open code.rs | inkify --language rust | chafa
#   
#   # Save with custom styling
#   open code.py | inkify --language python --theme monokai --no-line-number | save code.png
#   
#   # Pipe string directly
#   "print('hello')" | inkify -l python | save code.png
def inkify [
    --language (-l): string        # The language for syntax highlighting
    --theme (-t): string           # The theme to use (defaults to Dracula)
    --font (-f): string            # The font to use
    --shadow-color (-s): string    # The shadow color
    --background (-b): string      # The background color
    --tab-width (-w): int          # Tab width (defaults to 4)
    --line-pad (-p): int           # Line padding (defaults to 2)
    --line-offset (-o): int        # Line offset (defaults to 1)
    --window-title: string         # Window title (defaults to "Inkify")
    --no-line-number               # Hide line numbers
    --no-round-corner              # Disable rounded corners
    --no-window-controls           # Hide window controls
    --shadow-blur-radius: int      # Shadow blur radius
    --shadow-offset-x: int         # Shadow X offset
    --shadow-offset-y: int         # Shadow Y offset
    --pad-horiz: int               # Horizontal padding (defaults to 80)
    --pad-vert: int                # Vertical padding (defaults to 100)
    --highlight-lines: string      # Lines to highlight
    --background-image: string     # Background image URL
] {
    # Build the query parameters
    mut params = [
		'code' ($in | url encode)
	]
    
    if $language != null { $params = ($params | append ['language' $language]) }
    if $theme != null { $params = ($params | append ['theme' $theme]) }
    if $font != null { $params = ($params | append ['font' $font]) }
    if $shadow_color != null { $params = ($params | append ['shadow_color' $shadow_color]) }
    if $background != null { $params = ($params | append ['background' $background]) }
    if $tab_width != null { $params = ($params | append ['tab_width' $tab_width]) }
    if $line_pad != null { $params = ($params | append ['line_pad' $line_pad]) }
    if $line_offset != null { $params = ($params | append ['line_offset' $line_offset]) }
    if $window_title != null { $params = ($params | append ['window_title' $window_title]) }
    if $no_line_number { $params = ($params | append ['no_line_number' true]) }
    if $no_round_corner { $params = ($params | append ['no_round_corner' true]) }
    if $no_window_controls { $params = ($params | append ['no_window_controls' true]) }
    if $shadow_blur_radius != null { $params = ($params | append ['shadow_blur_radius' $shadow_blur_radius]) }
    if $shadow_offset_x != null { $params = ($params | append ['shadow_offset_x' $shadow_offset_x]) }
    if $shadow_offset_y != null { $params = ($params | append ['shadow_offset_y' $shadow_offset_y]) }
    if $pad_horiz != null { $params = ($params | append ['pad_horiz' $pad_horiz]) }
    if $pad_vert != null { $params = ($params | append ['pad_vert' $pad_vert]) }
    if $highlight_lines != null { $params = ($params | append ['highlight_lines' $highlight_lines]) }
    if $background_image != null { $params = ($params | append ['background_image' $background_image]) }
    
    # Build the URL with query parameters
    let query = ($params | chunks 2 | each {|chunk| 
        $chunk | reduce -f '' {|it, acc| 
            if $acc == '' { 
                $it 
            } else { 
                $"($acc)=($it)" 
            }
        }
    } | str join '&')
    
    let url = $"https://inkify.0x45.st/generate?($query)"
    
    # Make the request
    http get $url
}
