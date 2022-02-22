'''
Convert an image to ZX Spectrum format

http://www.breakintoprogram.co.uk/computers/zx-spectrum/screen-memory-layout

The Spectrum screen memory map is split into two sections:

    6144 bytes worth of bitmap data, starting at memory address &4000
    768 byte colour attribute data, immediately after the bitmap data at address &5800

The bitmap data starts at address &4000 and consists of 192 lines of 32 bytes.
Pixels are encoded as bits; 32 x 8 gives the horizontal resolution of 256 pixels.

Usage: python3 img2speccy.py --name test images/white.png > images/test.asm

image_you: ; 53 x 31 pixels. That's 7 blocks wide and 31 lines down
    defb 0x0, 0x2 , 0x1e ......etc
image_you_width:
    defb 7
image_you_height:
    defb 31
image_you_x:
    defb 7
image_you_y:
    defb 31

'''

from PIL import Image
import math
import argparse

parser = argparse.ArgumentParser(prog='img2speccy')
parser.add_argument('imgpath', nargs='+', help='The path to the image')
parser.add_argument('--name', default="temp", help='The shorthand name')
args = parser.parse_args()

# Read in the image
img = Image.open(args.imgpath[0])
name = "temp"
if args.name != "temp":
    name = args.name

img_str =  "image_" + name + ":\n    defb "

# Convert the pixels into blocks of one of 2 colours, in blocks of 8
for y in range(img.height):
    blocks = []
    width = 8 * int(img.width / 8)
    
    if img.width % 8 != 0:
        width += 8

    # Make it an even number of blocks
    if (width / 8) % 2 != 0:
        width += 8

    for x in range(0, width, 8):
        block = 0
        for b in range(8):
            val = 0
            if x + b < img.width:
            # Assuming input image is greyscale for now
                val, _, _ = img.getpixel((x + b, y))
           
            if val != 0:
                block = block | (1 << 7-b)

        blocks.append(block)
    
    for block in blocks:
        img_str += str(hex(block)) + ", "

img_str = img_str[:-2]
img_str += "\nimage_" + name + "_width:\n    defb " + str(len(blocks)) + "\n"
img_str += "image_" + name + "_height:\n    defb " + str(int(img.height)) + "\n"
img_str += "image_" + name + "_x:\n    defb " + str(len(blocks)) + "\n"
img_str += "image_" + name + "_y:\n    defb " + str(int(img.height)) + "\n"
img_str += "image_" + name + "_offx:\n    defb " + str(0) + "\n"
img_str += "image_" + name + "_offy:\n    defb " + str(0) + "\n"

print(img_str)

          
        
