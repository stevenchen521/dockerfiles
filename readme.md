# Contents
* Python
* Miniconda
* Jupyter

# How to install
* Download the folder and enter it
* Open ml.dockerfile and change the line 'RUN mkdir /home/stevenchen521' into the name you want
* Build: docker build -t [image-name] . -f ml.Dockerfile  
* Run: docker run [-v mount path] -it [-p ip mapping for jupyter] [image-name]


