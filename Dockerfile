# ffmpeg - http://ffmpeg.org/download.html
#
# https://hub.docker.com/r/jrottenberg/ffmpeg/
#
#

FROM python:3 AS base

#WORKDIR /usr/src/app

#COPY requirements.txt ./
#RUN pip install --no-cache-dir -r requirements.txt
#USER pestpp
WORKDIR     /tmp/pestpp
COPY . .


RUN       sysDeps="liblapack-dev \
                   gfortran-6 \
                   xvfb" && \
          apt-get update && \
          apt-get -y install ${sysDeps}

                 
#FROM        base AS build


ARG      pyemu_path=/root/miniconda/bin
#ENV      P

RUN \
         cd src && \
         COMPILER=gcc6 CXX=g++-6 FC=gfortran-6 STATIC=no make install

### miniconda - Failing on Alpine OS images
RUN      wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
         bash miniconda.sh -b -p $HOME/miniconda && \
         $HOME/miniconda/bin/conda update --yes conda && \
         $HOME/miniconda/bin/conda install --yes pip numpy scipy pandas matplotlib nose

#RUN      export DISPLAY=:99.0 && sh -e /etc/init.d/xvfb start
#RUN       Xvfb 99 --screen 0

### flopy
RUN      $HOME/miniconda/bin/conda install --yes -c conda-forge flopy
#        git clone --depth 1 --single-branch -b develop https://github.com/modflowpy/flopy.git && \
#        cd flopy && \
#        python setup.py install && \
#        cd ../ &&\
#        rm -rf flopy


### pyemu
RUN     pip install pyemu
#RUN     git clone --depth 1 --single-branch -b develop https://github.com/jtwhite79/pyemu.git && \
#        cd pyemu && \
#        python setup.py install && \
#        cd ../ && \
#        rm -rf pyemu

        

### Release Stage
#FROM        base AS release

ENTRYPOINT  ["/bin/bash"]
#CMD [ "python", "./your-daemon-or-script.py" ]

#COPY --from=build /usr/local /usr/local

