#!/usr/bin/env bash
# Simple utility that utilizes ffmpeg and slop to take screen recordings.
# Accepts one of 4 arguments:
#  -f  - fullscreen; saves to ~/Videos/recordings.
#  -fc - fullscreen; copies to clipboard.
#  -r  - select region; saves to ~/Videos/recordings.
#  -rc - select region; copies to clipboard.

function help_and_exit {
   if [ -n "${1}" ]; then
        echo "${1}"
    fi
    cat <<-EOF
    Usage: screencap [option]

    Take a screen recording using the specified format.
    Requires ffmpeg and slop be installed.

       -h   - print help and exit.
       
       Fullscreen:
         -f  - save to ~/Videos/recordings.
         -fc - copy to clipboard.

       Region selection:
         -r  - save to ~/Videos/recordings.
         -fc - copy to clipboard.
EOF
    if [ -n "${1}" ]; then
        exit 1
    fi
    exit 0 
}

function check_deps {
    for c in "ffmpeg" "slop"
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
    if [ ! -d "$HOME/Videos/recordings" ]; then
        mkdir -p "$HOME/Videos/recordings"
    fi
}

if [ "${1}" == '-h' ]; then
    help_and_exit
else
    check_deps
    check_or_create_screenshots_dir
    
    if killall -2 ffmpeg >/dev/null; then
        exit 0
    fi

    today=$(date '+%Y-%m-%d_%H-%M-%S')
    file_path="$HOME/Videos/recordings/${today}.mp4"
    cmd="ffmpeg"
    
    case ${1} in
       -f)
           screen_size=$(xdpyinfo  | grep 'dimensions:' | awk 'match($0, /[0-9]{3,4}x[0-9]{3,4}/) { print substr( $0, RSTART, RLENGTH ) }')
           cmd="$cmd -video_size $screen_size -f x11grab -i :0.0+0,0 -an -c:v libx264 -crf 26 -pix_fmt yuv420p $file_path"
           eval "$cmd"
           exit 0
           ;;

       -r)
           region=$(slop -f '%wx%h;%xx%y')
           width=$(echo -e "$region" | gawk 'match($0, /([0-9]+)x([0-9]+);([0-9]+)x([0-9]+)/, arr) { print arr[1]}')
           height=$(echo -e "$region" | gawk 'match($0, /([0-9]+)x([0-9]+);([0-9]+)x([0-9]+)/, arr) { print arr[2]}')
           pos_x=$(echo -e "$region" | gawk 'match($0, /([0-9]+)x([0-9]+);([0-9]+)x([0-9]+)/, arr) { print arr[3]}')
           pos_y=$(echo -e "$region" | gawk 'match($0, /([0-9]+)x([0-9]+);([0-9]+)x([0-9]+)/, arr) { print arr[4]}')
           cmd="$cmd -video_size ${width}x${height} -f x11grab -i :0.0+$pos_x,$pos_y -an -c:v libx264 -crf 26 -pix_fmt yuv420p $file_path"
           eval "$cmd"
           exit 0
           ;;

       *)
           echo "Error: unknown option ${1}."
           exit 1
    esac
fi
