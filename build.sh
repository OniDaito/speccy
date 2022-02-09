#!/bin/bash
VASM_PATH=/home/oni/Projects/vbcc/bin
PASMO_PATH=/home/oni/Projects/pasmo
ZXBASIC_PATH=/home/oni/Projects/zxbasic
BIN2TAP_PATH=/home/oni/Projects/bin2tap

#$VASM_PATH/vasmz80_oldstyle -chklabels -nocase -Dvasm=1 -DBuildZXS=1 -DBuildZXS_TRD=1 -Fbin -i first.asm -o first.bin

#$PASMO_PATH/pasmo -d -v --bin hello.asm ./build/hello.bin
#$PASMO_PATH/pasmo -d -v --bin screen.asm ./build/screen.bin
$PASMO_PATH/pasmo -d -v --bin bitmap.asm ./build/bitmap.bin

# Build the tap files for tape emulations
#$BIN2TAP_PATH/bin2tap -b -cp 1 ./build/hello.bin -c 28672 -o ./build/hello.tap
#$BIN2TAP_PATH/bin2tap -b ./build/screen.bin -o ./build/screen.tap
$BIN2TAP_PATH/bin2tap -b ./build/bitmap.bin -o ./build/bitmap.tap

# Previously, I appended the loader.bas bin file to the front of
# the loader tap but it didn't always work
#$BIN2TAP_PATH/bin2tap first.bin -c 28672 -o first.tap
#$ZXBASIC_PATH/zxbc -taB loader.bas -o loader.tap
#cat loader.tap first.tap > hello_world.tap
