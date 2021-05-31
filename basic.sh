#!/bin/bash
ZXBASIC_PATH="/home/oni/Projects/zxbasic"
$ZXBASIC_PATH/zxbc -taB hello_basic.bas -o hello_basic.tap
fuse --machine 48 --tape hello_basic.tap -g 2x
