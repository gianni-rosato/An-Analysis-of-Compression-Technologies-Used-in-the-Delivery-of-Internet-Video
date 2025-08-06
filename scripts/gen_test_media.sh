#!/bin/bash -eu

# Source videos can be sourced from derf's test media on xiph.org
# Example:
# wget https://media.xiph.org/video/derf/ElFuente/Netflix_FoodMarket_4096x2160_60fps_10bit_420.y4m

if [ $# -ne 1 ]; then
    echo "Takes a lossless input video of resolution 4096x2160, & generates \
    lossless scaled versions at 1080p, 720p, 540p, 360p, & 144p."
    echo "Usage: $0 input.y4m"
    exit 1
fi

encode() {
    local output_dir=$1
    local input_file=$2
    local width=0
    local height=0
    local input_file_name

    # get input filename from input_file.y4m
    input_file_name=$(basename "$input_file" .y4m)

    case "$output_dir" in
        "1080p")
            width=1920
            height=1080
            ;;
        "720p")
            width=1280
            height=720
            ;;
        "540p")
            width=960
            height=540
            ;;
        "360p")
            width=640
            height=360
            ;;
        "144p")
            width=256
            height=144
            ;;
    esac

    echo "Encoding ${input_file} to ${output_dir}/${input_file_name}_${output_dir}.m4v (${width}x${height})"

    ffmpeg -y -hide_banner -loglevel error -stats \
    -i "$input_file" -pix_fmt yuv420p10le \
    -r 30 \
    -vf "crop=3840:2160,scale=${width}:${height}:flags=bicubic:param0=0:param1=1/2" \
    -c:v libx264 -preset ultrafast -profile:v high444 -qp 0 \
    "${output_dir}/${input_file_name}_${output_dir}.m4v"

}

main() {
    local in=$1
    for out in "1080p" "720p" "540p" "360p" "144p"; do
        encode "$out" "$in"
    done
    exit 0
}

main "$1"
