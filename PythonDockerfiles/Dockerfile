FROM ubuntu:18.04

# Maintainer
LABEL maintainer="albertotricker@correo.ugr.es"

# Install Python, pip and venv tool
RUN \
  apt-get update && \
  apt-get install -y python3.6 python3-pip python3-virtualenv && \
  rm -rf /var/lib/apt/lists/*

# Define working directory
WORKDIR /home/project

# Copy files
COPY requirements.txt test_script.py ./

# Install packages
RUN python3 -m pip install --no-cache-dir -r requirements.txt

# Define default command
CMD ["bash"]
