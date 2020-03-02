#!/usr/bin/env bash
# Simple utility that utilizes maim to take screenshots.
# Accepts one of 4 arguments:
#  -f  - fullscreen; saves to ~/Pictures/screenshots.
#  -fc - fullscreen; copies to clipboard.
#  -r  - select region; saves to ~/Pictures/screenshots.
#  -rc - select region; copies to clipboard.

function help_and_exit {
   if [ -n "${1}" ]; then
        echo "${1}"
    fi
    cat <<-EOF
    Usage: screenshot [option]

    Take screenshot using the specified format.
    Requires maim, xclip, and xdotool be installed.

       -h   - print help and exit.
       
       Fullscreen:
         -f  - save to ~/Pictures/screenshots.
         -fc - copy to clipboard.

       Region selection:
         -r  - save to ~/Pictures/screenshots.
         -fc - copy to clipboard.
EOF
    if [ -n "${1}" ]; then
        exit 1
    fi
    exit 0 
}

function check_deps {
    for c in "maim" "xclip" "xdotool"
    do
        if ! command -v "$c" > /dev/null; then
            error=true
            echo "$c not installed"
        fi
    done

    if [ "$error" == true ]; then
        echo "please install to continue :)"
        exit 1
    fi
}

function check_or_create_screenshots_dir {
    if [ ! -d "$HOME/Pictures/screenshots" ]; then
        mkdir -p "$HOME/Pictures/screenshots"
    fi
}

if [ "${1}" == '-h' ]; then
    help_and_exit
else
    check_deps
    check_or_create_screenshots_dir

    today=$(date '+%Y-%m-%d_%H-%M-%S')
    file_path="$HOME/Pictures/screenshots/${today}.png"

    case ${1} in
       -f)
           cmd="maim ${file_path}"
           ;;

       -fc)
           cmd="maim | xclip -selection clipboard -t image/png"
           ;;

       -r)
           cmd="maim -s ${file_path}" 
           ;;

       -rc)
           cmd="maim -s | xclip -selection clipboard -t image/png" 
           ;;

       *)
           echo "Error: unknown option ${1}."
           exit 1
    esac

    eval "$cmd"
fi
