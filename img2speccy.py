'''
Convert an image to ZX Spectrum format

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

    for x in range(0, width, 8):
        block = 0
        for b in range(8):
            val = 0
            if x + b < img.width:
            # Assuming input image is greyscale for now
                val, _, _ = img.getpixel((x + b, y))
           
            if val != 0:
                block = block | (1 << b)

        blocks.append(block)
    blocks_reordered = []

    # Swapping over bytes in pairs - reordering the 16 bits seems to work on the speccy
    # at least for the most part.
    for bidx in range(0, len(blocks), 2):
        if bidx+1 < len(blocks):
            blocks_reordered.append(blocks[bidx+1])
        blocks_reordered.append(blocks[bidx])
     
    for block in blocks_reordered:
        img_str += str(hex(block)) + ", "

img_str = img_str[:-2]
img_str += "\nimage_" + name + "_width:\n    defb " + str(int(math.ceil(img.width / 8))) + "\n"
img_str += "image_" + name + "_height:\n    defb " + str(int(img.height)) + "\n"
img_str += "image_" + name + "_x:\n    defb " + str(int(math.ceil(img.width / 8))) + "\n"
img_str += "image_" + name + "_y:\n    defb " + str(int(img.height)) + "\n"

print(img_str)

          
        
