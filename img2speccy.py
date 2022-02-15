from PIL import Image
import argparse

parser = argparse.ArgumentParser(prog='img2speccy')
parser.add_argument('imgpath', nargs='+', help='The path to the image')
args = parser.parse_args()

# Read in the image
img = Image.open(args.imgpath[0])
print("Image:", args.imgpath[0], img.width, img.height)

img_str = ""

# Convert the pixels into blocks of one of 2 colours, in blocks of 8
for y in range(img.height):
    for x in range(0, img.width, 8):
        block = 0
        for b in range(8):
            if x + b >= img.width:
                break

            # Assuming input image is greyscale for now
            r, _, _ = img.getpixel((x + b, y))
            if r != 0:
                block = block | (1 << b)

            img_str += str(hex(block)) + ", "

print(img_str)

          
        
