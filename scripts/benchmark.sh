#!/bin/bash

# x264
# -I 120
for preset in ultrafast superfast veryfast faster fast medium slow slower; do
    ./stats.py \
        -i ~/Videos/gb82_reference/1080p/*.m4v \
        -q "16 17 20 22 26" \
        -g 8 -t 8 \
        -o ./x264_p${preset}.csv \
        x264 -- --preset $preset -I 120
done

# x265
# -I 120
for preset in ultrafast superfast veryfast faster fast medium slow slower; do
    ./stats.py \
        -i ~/Videos/gb82_reference/1080p/*.m4v \
        -q "17 18 21 23 27" \
        -g 8 -t 8 \
        -o ./x265_p${preset}.csv \
        x265 -- --preset $preset -I 120
done

# SVT-AV1
# --keyint 120
for speed in {2..13}; do
    ./stats.py \
        -i ~/Videos/gb82_reference/1080p/*.m4v \
        -q "15 18 24 31 40" \
        -g 8 -t 8 \
        -o ./svtav1_p${speed}.csv \
        svtav1 -- --preset $speed --keyint 120
done

# aomenc
# --kf-max-dist=120
for cpu in {3..12}; do
    ./stats.py \
        -i ~/Videos/gb82_reference/1080p/*.m4v \
        -q "14 17 22 29 37" \
        -g 8 -t 8 \
        -o ./aomenc_s${cpu}.csv \
        aomenc -- --cpu-used=$cpu --threads=24 --kf-max-dist=120
done

# libvpx (vpxenc)
# --kf-max-dist=120
for cpu in {3..9}; do
    ./stats.py \
        -i ~/Videos/gb82_reference/1080p/*.m4v \
        -q "18 20 25 30 37" \
        -g 8 -t 8 \
        -o ./vpxenc_s${cpu}.csv \
        vpxenc -- --cpu-used=$cpu --threads=24 --kf-max-dist=120
done
