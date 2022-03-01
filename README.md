# Speccy Demo 

A small introduction and couple of programs / demos for the ZX Spectrum.

## Overview

* We use VASM to create the binary from the assembly code
* We then convert to a tap file with bin2tap
* Some basic is compiled using zxbasic and added to the file
* We run the final file in Fuse.

## Commands

    vasmz80_oldstyle -chklabels -nocase -Dvasm=1 -DBuildZXS=1 -DBuildZXS_TRD=1 -Fbin -i ~/Projects/speccy/first.asm -o ~/Projects/speccy/first.bin
    bin2tap first.bin

## Converting images to ASM
Lossless compression PNGs seem best. JPGs less good.

    python3 img2speccy.py --name horace images/horace.png > images/horace.asm

## Useful Links
*[http://www.breakintoprogram.co.uk/computers/zx-spectrum/memory-map](http://www.breakintoprogram.co.uk/computers/zx-spectrum/memory-map) - Speccy memory map
*[http://www.breakintoprogram.co.uk/computers/zx-spectrum/assembly-language/z80-development-toolchain](http://www.breakintoprogram.co.uk/computers/zx-spectrum/assembly-language/z80-development-toolchain)
*[http://www.breakintoprogram.co.uk/computers/zx-spectrum/assembly-language](http://www.breakintoprogram.co.uk/computers/zx-spectrum/assembly-language) - a set of useful routines256
*[https://github.com/Dotneteer/spectnetide](https://github.com/Dotneteer/spectnetide)
*[https://www.chibiakumas.com/z80/multiplatform.php](https://www.chibiakumas.com/z80/multiplatform.php) - some potentially handy debugging routines.
* [http://www.overtakenbyevents.com/lets-talk-about-the-zx-specrum-screen-layout-part-two/](http://www.overtakenbyevents.com/lets-talk-about-the-zx-specrum-screen-layout-part-two/)
* [https://manpages.debian.org/stretch/fuse-emulator-utils/fuse-utils.1.en.html](https://manpages.debian.org/stretch/fuse-emulator-utils/fuse-utils.1.en.html)
* [http://www.computinghistory.org.uk/det/424/Sinclair-ZX-Spectrum-48k/](http://www.computinghistory.org.uk/det/424/Sinclair-ZX-Spectrum-48k/)
* [https://worldofspectrum.org/ZXBasicManual/zxmanchap1.html](https://worldofspectrum.org/ZXBasicManual/zxmanchap1.html)
* [http://pasmo.speccy.org/](http://pasmo.speccy.org/)
* [https://sourceforge.net/projects/zxspectrumutils/](https://sourceforge.net/projects/zxspectrumutils/)
* [https://www.chibiakumas.com/z80/helloworld.php#LessonH2](https://www.chibiakumas.com/z80/helloworld.php#LessonH2)
* [http://fuse-emulator.sourceforge.net/](http://fuse-emulator.sourceforge.net/)
* [https://github.com/boriel/zxbasic](https://github.com/boriel/zxbasic)
* [https://en.wikipedia.org/wiki/Sinclair_BASIC](https://en.wikipedia.org/wiki/Sinclair_BASIC)
* [http://zeroteam.sk/bin2tap.html http://zeroteam.sk/bin2tap.html](http://zeroteam.sk/bin2tap.html http://zeroteam.sk/bin2tap.html)

## Demo stuff

*[https://www.ffonts.net/XBAND-Rough.font.download](https://www.ffonts.net/XBAND-Rough.font.download) - The XBand Font