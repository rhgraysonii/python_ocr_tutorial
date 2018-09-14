# -*- coding: utf-8 -*-

import pytesseract
from localfile import session

from PIL import Image
from PIL import ImageFilter
from io import BytesIO

def process_image(url):
    image = _get_image(url)
    image.filter(ImageFilter.SHARPEN)
    return pytesseract.image_to_string(image)


def _get_image(url, session=session):
    return Image.open(BytesIO(session.get(url).content))
