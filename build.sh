#!/bin/bash
PASMO_PATH=/home/oni/Projects/pasmo
BIN2TAP_PATH=/home/oni/Projects/bin2tap

mkdir ./build

$PASMO_PATH/pasmo -d -v --bin hello.asm ./build/hello.bin
$PASMO_PATH/pasmo -d -v --bin screen.asm ./build/screen.bin
$PASMO_PATH/pasmo -d -v --bin bitmap.asm ./build/invader.bin
$PASMO_PATH/pasmo -d -v --bin bitmap.asm ./build/bitmap.bin
$PASMO_PATH/pasmo -d -v --bin beep.asm ./build/beep.bin
$PASMO_PATH/pasmo -d -v --bin sound.asm ./build/sound.bin

# Build the tap files for tape emulations
$BIN2TAP_PATH/bin2tap -b -cp 1 ./build/hello.bin -c 28672 -o ./build/hello.tap
$BIN2TAP_PATH/bin2tap -b ./build/screen.bin -o ./build/screen.tap
$BIN2TAP_PATH/bin2tap -b ./build/bitmap.bin -o ./build/invader.tap
$BIN2TAP_PATH/bin2tap -b ./build/bitmap.bin -o ./build/bitmap.tap
$BIN2TAP_PATH/bin2tap -b ./build/beep.bin -o ./build/beep.tap
$BIN2TAP_PATH/bin2tap -b ./build/sound.bin -o ./build/sound.tap