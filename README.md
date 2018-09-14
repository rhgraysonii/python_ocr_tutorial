## Python OCR Docker

This is my branch of a
[RealPython Tutorial](https://realpython.com/blog/python/setting-up-a-simple-ocr-server/).
I've updated it for Python3 / Unicode, and dropped most of the non-Docker bits
so I can inherit from the tesseractshadow/tesseract4re Docker container.
The result is a simple OCR Docker app using Tesseract. It provides:
* cli.py - a command-line app that takes a URL and returns the text extracted from the image.
* app.py - a small Flask app that does the same thing, but in the browser.

The only preprocessing is a single call to ImageFilter.SHARPEN.


### Changes include:
* Updated for Python3 & unicode.
* Refactored to use tesseractshadow/tesseract4re Docker container.
* Allows file:/// URLs. (Relative to the _container!_)

### Alternatives
* [tesseract-ocr-re](https://github.com/tesseract-shadow/tesseract-ocr-re)
* [tleyden/open-ocr](https://github.com/tleyden/open-ocr) Full-featured queued service. Written in Go.


### Usage

Install Docker

If you are not familiar with Docker please read [Docker - Get Started.](https://docs.docker.com/get-started/).

#### Quick Start: CLI
The following should run the Docker container straight from DockerHub.

```
docker container run --publish 5000:5000 --interactive --tty ctwardy/python_ocr_tutorial:2.0 python3 cli.py
```

That should produce the following output:
```
===OOOO=====CCCCC===RRRRRR=====
==OO==OO===CC=======RR===RR====
==OO==OO===CC=======RR===RR====
==OO==OO===CC=======RRRRRR=====
==OO==OO===CC=======RR==RR=====
==OO==OO===CC=======RR== RR====
===OOOO=====CCCCC===RR====RR===

A simple OCR utility
What is the url of the image you would like to analyze?
```

Type the following:
```
file:///flask_server/tests/advertisement.jpg
```

to see:
```
The raw output from tesseract with no processing is:
-----------------BEGIN-----------------
b'ADVERTISEMENT.\n\nTus publication of the Works of Joan Knox, it is\nsupposed, will extend to Five Volumes. It was thought\nadvisable to commence the series with his History of\nthe Reformation in Scotland, as the work of greatest\nimportance. The next volume will thus contain the\nThird and Fourth Books, which continue the History to\nthe year 1564; at which period his historical labours\nmay be considered to terminate. But the Fifth Book,\nforming a sequel to the History, and published under\nhis name in 1644, will also be included. His Letters\nand Miscellaneous Writings will be arranged in the\nsubsequent volumes, as nearly as possible in chronolo-\ngical order ; each portion being introduced by a separate\nnotice, respecting the manuscript or printed copies from\nwhich they have been taken.\n\nIt may perhaps be expected that a Life of the Author\nshould have been prefixed to this volume. The Life of\nKnox, by Dr. M\xe2\x80\x98Crig, is however a work so universally\nknown, and of so much historical value, as to supersede\nany attempt that might be made for a detailed bio-'
------------------END------------------
```

#### Quick Start: App
Runs another app from the same container, pulled from DockerHub:
```
docker container run --publish 5000:5000 ctwardy/python_ocr_tutorial:2.0
```
Then visit `localhost:5000` in your browser and type `file:///flask_server/tests/advertisement.jpg` to
see essentially the same result, but rendered more nicely. Click "Again" to try another.

Stop it with Ctrl-C as usual.

#### Get this from GitHub
```
git clone https://github.com/ctwardy/python_ocr_tutorial.git
```

#### Build the Docker image:
From the python_ocr_tutorial folder, do:
```docker image build --tag python_ocr_test .```
(Note the trailing "." -- it means build from this folder.)

#### Pull the Docker image:
In case you want to pull but not run.
```docker pull ctwardy/python_ocr_tutorial:2.0```

#### Run either the CLI or the App:
We did these above, but for reference.
* CLI: `docker container run --publish 5000:5000 --interactive --tty
    ctwardy/python_ocr_tutorial:2.0 python3 cli.py`
* App: `docker container run --publish 5000:5000 ctwardy/python_ocr_tutorial:2.0`

Stop the app using Ctrl-C.

### TODO (or see GitHub Issues):
* Browser app still won't display "<" characters. The returned JSON is fine,
so it's getting sanitized in the javascript or browser.
* Add endpoint for POSTing images directly.
* Add file upload widget.
* Try Tesseract4 instead of Tesseract3: tesseractshadow/tesseract4cmp


:)