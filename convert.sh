#! /bin/sh

# To install nix in WSL: sh <(curl -L https://nixos.org/nix/install) --no-daemon


ffmpeg -i $1 -ar 16000 -y $1.wav
./result/main -t 8 -m models/ggml-large.bin -l zh -f $1.wav | tee $1.txt
