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

CMD ["bash"]


# docker build -t stevenchen/base:0.1 . -f base.dockerfile


FROM base as ml


 RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.zshrc && \
    echo "conda activate base" >> ~/.zshrc


# ###### instiall through commands than environment.yml

# RUN /bin/bash -c "source activate ml-py3.9 \
#     && conda install -y \
#             jupyterlab \
#             seaborn plotly \ 
#             scikit-learn scikit-image \
#             beautifulsoup4"

# RUN /bin/bash -c "source activate ml-py3.9 \
#     && conda install -yc conda-forge \
#     xgboost lightgbm catboost"

# # RUN conda install -y \
# #     jupyterlab \
# #     seaborn plotly \ 
# #     scikit-learn scikit-image \
# #     beautifulsoup4


# # RUN conda install -yc conda-forge \
# #     xgboost lightgbm catboost


 COPY environment.yml .
 RUN /opt/conda/bin/conda env create -n ml-py3.9 -f environment.yml
 RUN echo "source activate ml-py3.9" > ~/.bashrc
 RUN echo "source activate ml-py3.9" > ~/.zshrc
 ENV PATH /opt/conda/envs/ml-py3.9/bin:/opt/conda/bin:$PATH

 EXPOSE 80
 EXPOSE 8080
 EXPOSE 8800
 EXPOSE 8888
 EXPOSE 8889
 
 # Default powerline10k theme, no plugins installed
 RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)"

CMD ["zsh"]







# docker build -t stevenchen/ml . -f ml.dockerfile
