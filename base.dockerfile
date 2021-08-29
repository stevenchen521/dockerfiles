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
 WORKDIR /home/stevenchen521/

 # Default powerline10k theme, no plugins installed
 RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)"

CMD ["zsh"]