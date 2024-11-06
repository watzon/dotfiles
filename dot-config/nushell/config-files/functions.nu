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

# Nice little weather visualizer using wttr.in
def weather [location?: string] {
    let loc = if ($location | is-not-empty) {
        ($location | url encode)
    } else {
        "Salt Lake City"
    }
    http get https://wttr.in?$loc?un
}

# Get the moon phase
def moon-phase [] {
    http get https://wttr.in/moon
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

# Extract an archive (based on the oh-my-zsh extract plugin)
def extract [
    file?: path                     # The archive file to extract (optional if piping)
    --remove(-r)                    # Remove archive after extracting
] {
    # Get the file path either from parameter or pipeline
    let archive = if ($file != null) { 
        $file | path expand
    } else if ($in != null) {
        $in | path expand
    } else {
        error make {msg: "No file provided. Either pipe a file or provide it as an argument"}
    }

    # Ensure file exists
    if not ($archive | path exists) {
        error make {msg: $"File '($archive)' does not exist"}
    }

    # Create extraction directory based on archive name
    let extract_dir = ($archive | path parse).stem
    let extract_dir = if ($extract_dir | str ends-with ".tar") {
        ($extract_dir | path parse).stem
    } else { 
        $extract_dir 
    }

    # Add random suffix if directory already exists
    let extract_dir = if ($extract_dir | path exists) {
        let rnd = (random chars -l 5)
        $"($extract_dir)-($rnd)"
    } else {
        $extract_dir
    }

    # Create and enter extraction directory
    mkdir $extract_dir
    cd $extract_dir

    # Extract based on file extension
    let result = match ($archive | str downcase) {
        $path if ($path | str ends-with ".tar.gz") or ($path | str ends-with ".tgz") => { tar xvzf $archive }
        $path if ($path | str ends-with ".tar.bz2") or ($path | str ends-with ".tbz") or ($path | str ends-with ".tbz2") => { tar xvjf $archive }
        $path if ($path | str ends-with ".tar.xz") or ($path | str ends-with ".txz") => { tar xvJf $archive }
        $path if ($path | str ends-with ".tar.zst") or ($path | str ends-with ".tzst") => { tar --zstd -xvf $archive }
        $path if ($path | str ends-with ".tar") => { tar xvf $archive }
        $path if ($path | str ends-with ".gz") => { gunzip -c $archive | save -f ($archive | path parse).stem }
        $path if ($path | str ends-with ".bz2") => { bunzip2 -k $archive }
        $path if ($path | str ends-with ".xz") => { unxz -k $archive }
        $path if ($path | str ends-with ".zip") => { unzip $archive }
        $path if ($path | str ends-with ".rar") => { unrar x $archive }
        $path if ($path | str ends-with ".7z") => { 7z x $archive }
        $path if ($path | str ends-with ".zst") => { unzstd $archive }
        _ => { error make {msg: $"Unknown archive format for '($archive)'"} }
    }

    # Go back to original directory
    cd ..

    # Remove archive if requested
    if $remove {
        rm -f $archive
    }

    # Try to simplify directory structure if possible
    let contents = (ls $extract_dir | length)
    if $contents == 1 {
        let item = (ls $extract_dir).name.0
        let item_path = $"($extract_dir)/($item)"
        if ($item != $extract_dir) and (not ($item | path exists)) {
            mv $item_path $item
            rmdir $extract_dir
        }
    } else if $contents == 0 {
        rmdir $extract_dir
    }
}

# Create an archive from files
def compress [
    output: path                    # The output archive name (with extension)
    ...files: path                  # Files to compress (or from pipeline)
    --format(-f): string           # Override the format (ignore output extension)
] {
    # Get files from either parameters or pipeline
    let input_files = if ($files | is-empty) and ($in != null) { 
        $in
    } else { 
        $files 
    }

    # Determine compression format
    let format = if $format != null {
        $format
    } else {
        match ($output | str downcase) {
            $path if ($path | str ends-with ".tar.gz") or ($path | str ends-with ".tgz") => "tar.gz"
            $path if ($path | str ends-with ".tar.bz2") or ($path | str ends-with ".tbz2") => "tar.bz2"
            $path if ($path | str ends-with ".tar.xz") => "tar.xz"
            $path if ($path | str ends-with ".tar.zst") => "tar.zst"
            $path if ($path | str ends-with ".tar") => "tar"
            $path if ($path | str ends-with ".gz") => "gz"
            $path if ($path | str ends-with ".bz2") => "bz2"
            $path if ($path | str ends-with ".xz") => "xz"
            $path if ($path | str ends-with ".zip") => "zip"
            $path if ($path | str ends-with ".7z") => "7z"
            $path if ($path | str ends-with ".zst") => "zst"
            _ => { error make {msg: $"Unknown archive format for '($output)'"} }
        }
    }

    # Compress based on format
    match $format {
        "tar.gz" => { tar czf $output ...$input_files }
        "tar.bz2" => { tar cjf $output ...$input_files }
        "tar.xz" => { tar cJf $output ...$input_files }
        "tar.zst" => { tar --zstd -cf $output ...$input_files }
        "tar" => { tar cf $output ...$input_files }
        "gz" => { 
            if ($input_files | length) > 1 { error make {msg: "Can only gzip a single file"} }
            gzip -c $input_files.0 | save -f $output 
        }
        "bz2" => {
            if ($input_files | length) > 1 { error make {msg: "Can only bzip2 a single file"} }
            bzip2 -c $input_files.0 | save -f $output
        }
        "xz" => {
            if ($input_files | length) > 1 { error make {msg: "Can only xz a single file"} }
            xz -c $input_files.0 | save -f $output
        }
        "zip" => { ^zip $output ...$input_files }
        "7z" => { 7z a $output ...$input_files }
        "zst" => {
            if ($input_files | length) > 1 { error make {msg: "Can only zstd a single file"} }
            zstd -c $input_files.0 | save -f $output
        }
        _ => { error make {msg: $"Unknown compression format '($format)'"} }
    }
}
