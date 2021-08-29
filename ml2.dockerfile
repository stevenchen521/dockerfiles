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


FROM base as ml


RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN /opt/conda/bin/conda create -n ml-py3.9 python=3.9
RUN echo "source activate ml-py3.9" > ~/.bashrc
ENV PATH /opt/conda/envs/ml-py3.9/bin:/opt/conda/bin:$PATH

# https://www.py4u.net/discuss/142024
# 	—Answer #8:


RUN /bin/bash -c "source activate ml-py3.9 \
    && conda install -y \
            jupyterlab \
            seaborn plotly \ 
            scikit-learn scikit-image \
            beautifulsoup4"

RUN /bin/bash -c "source activate ml-py3.9 \
    && conda install -yc conda-forge \
    xgboost lightgbm catboost"

# RUN conda install -y \
#     jupyterlab \
#     seaborn plotly \ 
#     scikit-learn scikit-image \
#     beautifulsoup4


# RUN conda install -yc conda-forge \
#     xgboost lightgbm catboost
CMD ["bash"]




# docker build -t stevenchen/ml . -f ml.dockerfile
