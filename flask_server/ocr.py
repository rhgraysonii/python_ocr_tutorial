import pytesseract
import requests
from PIL import Image
from PIL import ImageFilter
from io import BytesIO


def process_image(url):
    image = _get_image(url)
    image.filter(ImageFilter.SHARPEN)
    return pytesseract.image_to_string(image)


def _get_image(url):
    return Image.open(BytesIO(requests.get(url).content))
