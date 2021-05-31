#!/bin/bash
VASM_PATH=/home/oni/Projects/vbcc/bin
BIN2TAP_PATH=/home/oni/Projects/bin2tap
$VASM_PATH/vasmz80_oldstyle -chklabels -nocase -Dvasm=1 -DBuildZXS=1 -DBuildZXS_TRD=1 -Fbin -i first.asm -o first.bin
$BIN2TAP_PATH/bin2tap first.bin
cat loader.tap first.tap > hello_world.tap
