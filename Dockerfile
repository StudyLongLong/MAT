FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

# Install some basic utilities & python prerequisites
RUN apt-get update -y && apt-get install -y --no-install-recommends\
    wget \
    vim \
    curl \
    ssh \
    tree \
    sudo \
    git \
    libgl1-mesa-glx \
    libglib2.0-0 \
    zip && \
    apt-get update && \
    apt-get -y install python3.11 && \
    apt-get install -y python3.11-distutils && \
    apt-get install gcc && \
    apt install -y python3.11-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Install pip for Python 3.11
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.11 get-pip.py && \
    rm get-pip.py

# Upgrade pip
RUN python3.11 -m pip install --upgrade pip

# Set the default Python version
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

COPY ./requirements.txt .

RUN python3 -m pip install -r requirements.txt -f https://download.pytorch.org/whl/cu121/torch_stable.html --no-cache-dir
