# -*- coding: utf-8 -*-

import sys
import pytesseract
from PIL import Image
from io import BytesIO
from localfile import session     # Ensure requests.get() handles local files.

def get_image(url):
    return Image.open(BytesIO(session.get(url).content))

def std_print(s, end="\n"):
    sys.stdout.write("{}{}".format(s, end))


if __name__ == '__main__':
    """Tool to test the raw output of pytesseract with a given input URL"""

    std_print("""
===OOOO=====CCCCC===RRRRRR=====
==OO==OO===CC=======RR===RR====
==OO==OO===CC=======RR===RR====
==OO==OO===CC=======RRRRRR=====
==OO==OO===CC=======RR==RR=====
==OO==OO===CC=======RR== RR====
===OOOO=====CCCCC===RR====RR===
""")
    std_print("A simple OCR utility")
    url = input("What is the url of the image you would like to analyze?")
    image = get_image(url)
    std_print("The raw output from tesseract with no processing is:")
    std_print("-----------------BEGIN-----------------")
    std_print(pytesseract.image_to_string(image).encode('utf-8'))
    std_print("------------------END------------------")
