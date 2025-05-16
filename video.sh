#!/bin/bash

# Specify the folder containing the videos
TARGET_FOLDER="/Users/alex/dynamics-dp.github.io/videos/videos_speedup"

# Function to compress a video
compress_video() {
    local input_file="$1"
    local output_file="$input_file"
    
    # If file is .m4v, convert to .mp4
    if [[ "$input_file" == *.m4v ]]; then
        output_file="${input_file%.m4v}.mp4"
    fi

    # Compress the video using ffmpeg
    ffmpeg -i "$input_file" -vcodec libx264 -crf 28 -preset medium -acodec aac -b:a 128k "$output_file"
    
    # If original was .m4v, remove the original file
    if [[ "$input_file" == *.m4v ]]; then
        rm "$input_file"
    fi
}

export -f compress_video

# Find and compress all video files (mp4, mov, avi, mkv, m4v) in the specified folder
find "$TARGET_FOLDER" -type f \( -name "*.mp4" -o -name "*.mov" -o -name "*.avi" -o -name "*.mkv" -o -name "*.m4v" \) -exec bash -c 'compress_video "$0"' {} \;
