# Introduction to ZX Spectrum (speccy/specky) programming 

A small introduction to programming the ZX Spectrum.

## Overview

* We use pasmo to create the binary from the assembly code
* We then convert to a tap file with bin2tap
* Some basic is added using bin2tap (or compiled using zxbasic and added to the file). This makes the tap file run the program when loaded.
* We run the final tap file in Fuse.

## Setup

* Install [Fuse](http://fuse-emulator.sourceforge.net/)
* Download [Pasmo](http://pasmo.speccy.org/) and [bin2tap](https://sourceforge.net/projects/zxspectrumutils/)
* Change the build.sh file so the paths at the top point to pasmo and bin2tap.
* Run the build.sh file.
* Load the .tap file you want to run inside Fuse.

## Progams
I've included a number of small programs including:

* hello.asm - write the classic text.
* screen.asm - slowly fill the screen, showing the layout of screen memory.
* invader.asm - draw a small space invader.
* bitmap.asm - draw a picture, generated from a png with img2speccy.py

## Commands

I use Pasmo as the compiler for the most part. To compile helloworld, you can run this:

    pasmo -d -v --bin hello.asm ./build/hello.bin
    bin2tap -b -cp 1 ./build/hello.bin -c 28672 -o ./build/hello.tap

Using vasm, one can make a tap file like so:

    vasmz80_oldstyle -chklabels -nocase -Dvasm=1 -DBuildZXS=1 -DBuildZXS_TRD=1 -Fbin -i ~/Projects/speccy/first.asm -o ~/Projects/speccy/first.bin
    bin2tap first.bin

## Converting images to ASM
Lossless compression PNGs seem best. JPGs less good. This python script relies on [Pillow]().

    python3 img2speccy.py --name horace images/horace.png > images/horace.asm

## Useful Links

The following is a collection of links (or credits) to sites I found helpful when learning about the ZX Spectrum.

* [https://spectrumcomputing.co.uk/entry/2000076/Book/The_Complete_Spectrum_ROM_Disassembly](https://spectrumcomputing.co.uk/entry/2000076/Book/The_Complete_Spectrum_ROM_Disassembly) - The complete Spectrum ROM Disassembly book.
* [https://www.spectrumcomputing.co.uk/index.php?cat=96&id=2000237](https://www.spectrumcomputing.co.uk/index.php?cat=96&id=2000237) - Mastering Machine Code on your ZX Spectrum. One of the better books.
* [https://github.com/gasman/spectrum-sizecoding](https://github.com/gasman/spectrum-sizecoding) - Gasman's great collection of useful assembly routines.
*[https://sourceforge.net/projects/zxspectrumutils/](https://sourceforge.net/projects/zxspectrumutils/) - utils package that contains bin2tap.
*[http://www.breakintoprogram.co.uk/computers/zx-spectrum/memory-map](http://www.breakintoprogram.co.uk/computers/zx-spectrum/memory-map) - Speccy memory map
* [http://pasmo.speccy.org/](http://pasmo.speccy.org/) - The Pasmo compiler
*[http://www.breakintoprogram.co.uk/computers/zx-spectrum/assembly-language/z80-development-toolchain](http://www.breakintoprogram.co.uk/computers/zx-spectrum/assembly-language/z80-development-toolchain)
*[http://www.breakintoprogram.co.uk/computers/zx-spectrum/assembly-language](http://www.breakintoprogram.co.uk/computers/zx-spectrum/assembly-language) - a set of useful routines
*[https://github.com/Dotneteer/spectnetide](https://github.com/Dotneteer/spectnetide)
*[https://www.chibiakumas.com/z80/multiplatform.php](https://www.chibiakumas.com/z80/multiplatform.php) - some potentially handy debugging routines.
* [http://www.overtakenbyevents.com/lets-talk-about-the-zx-specrum-screen-layout-part-two/](http://www.overtakenbyevents.com/lets-talk-about-the-zx-specrum-screen-layout-part-two/)
* [https://manpages.debian.org/stretch/fuse-emulator-utils/fuse-utils.1.en.html](https://manpages.debian.org/stretch/fuse-emulator-utils/fuse-utils.1.en.html)
* [http://www.computinghistory.org.uk/det/424/Sinclair-ZX-Spectrum-48k/](http://www.computinghistory.org.uk/det/424/Sinclair-ZX-Spectrum-48k/)
* [https://worldofspectrum.org/ZXBasicManual/zxmanchap1.html](https://worldofspectrum.org/ZXBasicManual/zxmanchap1.html)
* [https://sourceforge.net/projects/zxspectrumutils/](https://sourceforge.net/projects/zxspectrumutils/)
* [http://fuse-emulator.sourceforge.net/](http://fuse-emulator.sourceforge.net/)
* [https://github.com/boriel/zxbasic](https://github.com/boriel/zxbasic)
* [https://en.wikipedia.org/wiki/Sinclair_BASIC](https://en.wikipedia.org/wiki/Sinclair_BASIC)
* [http://zeroteam.sk/bin2tap.html http://zeroteam.sk/bin2tap.html](http://zeroteam.sk/bin2tap.html http://zeroteam.sk/bin2tap.html)
