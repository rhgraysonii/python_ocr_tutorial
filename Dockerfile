# start with a base image
FROM tesseractshadow/tesseract4re

# Turn off debconf messages during build
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# Install system dependencies
# Docker says run apt-get update and install together,
# and then rm /var/lib/apt/lists to reduce image size.
RUN apt-get update && apt-get install -y \
    python3-pil \
    python3-requests \
    python3-pip \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip


# Add requirements.txt before rest of repo, for caching
COPY requirements.txt /
RUN pip3 install -r /requirements.txt


# update working directories
# ADD . /app
COPY ./flask_server /flask_server
WORKDIR /flask_server

# Make debconf interactive in the running container
ENV DEBIAN_FRONTEND teletype

# Set useful ENV vars
ENV PYTHONIOENCODING "utf-8"

# Try to forward request and error logs to docker log collector
# Not sure this works. Use /var/log/nginx/* if running nginx.
RUN ln -sf /dev/stdout /var/log/access.log \
	&& ln -sf /dev/stderr /var/log/error.log

# Expose and run
EXPOSE 80
CMD ["python3", "app.py"]
