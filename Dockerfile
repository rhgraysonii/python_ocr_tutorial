# start with a base image
FROM tesseractshadow/tesseract4re

# Turn off debconf messages during build
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# install system dependencies
RUN apt-get update
RUN apt-get install -y autoconf automake libtool
#RUN apt-get install -y libpng12-dev
#RUN apt-get install -y libjpeg62-dev
#RUN apt-get install -y g++
#RUN apt-get install -y libtiff5-dev
#RUN apt-get install -y libopencv-dev libtesseract-dev
RUN apt-get install -y git
#RUN apt-get install -y cmake
RUN apt-get install -y build-essential
#RUN apt-get install -y libleptonica-dev
#RUN apt-get install -y liblog4cplus-dev
#RUN apt-get install -y libcurl3-dev
RUN apt-get install -y wget
RUN apt-get install -y tk8.5 tcl8.5 tk8.5-dev tcl8.5-dev
RUN apt-get install -y imagemagick

#RUN apt-get build-dep -y python-??? --fix-missing    (PIL?)
RUN apt-get install -y python3-dev
RUN apt-get install -y python3-pil
RUN apt-get install -y python3-requests

RUN apt-get install -y python3-pip
RUN pip3 install --upgrade pip

# Add requirements.txt before rest of repo, for caching
ADD requirements.txt /
RUN pip3 install -r /requirements.txt


# update working directories
# ADD . /app
ADD ./flask_server /flask_server
WORKDIR /flask_server

# Make debconf interactive in the running container
ENV DEBIAN_FRONTEND teletype

# Expose and run
EXPOSE 801
CMD ["python", "app.py"]
