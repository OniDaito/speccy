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

## Useful Links
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
