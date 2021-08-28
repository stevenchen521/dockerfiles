FROM ubuntu:20.04 as base

 ARG DEBIAN_FRONTEND=noninteractive

 RUN apt-get update && apt-get -y upgrade && apt-get install -y apt-utils

 RUN apt-get install -y \
        net-tools iputils-ping \
        build-essential cmake git \
        curl wget \
        vim \
        zip p7zip-full p7zip-rar 
        # imagemagick ffmpeg libomp5 \ for video GPU
RUN mkdir /home/stevenchen521

CMD ["bash"]


# docker build -t stevenchen/base:0.1 . -f base.dockerfile
