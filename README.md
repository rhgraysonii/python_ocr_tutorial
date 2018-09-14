## Python OCR Docker

This is my branch of a
[RealPython Tutorial](https://realpython.com/blog/python/setting-up-a-simple-ocr-server/).
I've updated it for Python3 / Unicode, and dropped most of the non-Docker bits
so I can inherit from the tesseractshadow/tesseract4re Docker container.
The result is a simple OCR Docker app using Tesseract. It provides:
* cli.py - a command-line app that takes a URL and returns the text extracted from the image.
* app.py - a small Flask app that does the same thing, but in the browser.

The only preprocessing is a single call to ImageFilter.SHARPEN.


##### Changes include:
* Updated for Python3 & unicode.
* Refactored to use tesseractshadow/tesseract4re Docker container.
* Allows file:/// URLs. (Relative to the _container!_)

##### TODO (or see GitHub Issues):
* Browser app still won't display "<" characters. This seems to be last-minute
sanitizing in the javascript or browser. JSON seems fine.
* Need to add endpoint for POSTing images directly.
* Need to add file upload widget.
* Consider basing on Tesseract4: tesseractshadow/tesseract4cmp

##### Alternatives
* [tesseract-ocr-re](https://github.com/tesseract-shadow/tesseract-ocr-re)
* [tleyden/open-ocr](https://github.com/tleyden/open-ocr) Full-featured queued service. Written in Go.

:)