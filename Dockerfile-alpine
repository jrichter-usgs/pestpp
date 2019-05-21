# ffmpeg - http://ffmpeg.org/download.html
#
# https://hub.docker.com/r/jrottenberg/ffmpeg/
#
#

FROM python:3-alpine AS base

#WORKDIR /usr/src/app

#COPY requirements.txt ./
#RUN pip install --no-cache-dir -r requirements.txt
USER pestpp
#WORKDIR     /tmp/workdir
COPY . ./pestpp


#RUN     apk  add --no-cache --update libgcc libstdc++ ca-certificates libcrypto1.0 libssl1.0 libgomp expat git bash
RUN     buildDeps="make \
                   g++ \
                   gcc \
                   gfortran \
                   lapack-dev \
                   openblas \
                   ca-certificates \
                   git \
                   bash" && \
        apk  add --no-cache --update ${buildDeps}

RUN     helpers="man" && \
        apk  add --no-cache --update ${helpers}
                 
#FROM        base AS build


#ARG        PKG_CONFIG_PATH=/opt/ffmpeg/lib/pkgconfig
#ARG        LD_LIBRARY_PATH=/opt/ffmpeg/lib

#ENV         GIFSICLE_VERSION=1.92     \
#            SRC=/usr/local

RUN \
         cd pestpp/src && \
         STATIC=no make install

### miniconda - Failing on Alpine OS images
#RUN      wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
#         bash miniconda.sh -b -p $HOME/miniconda
         
### pip 
### NOTE: Will likely need to stick with conda for multi OS builds
RUN      pip install numpy 
RUN      pip install scipy pandas matplotlib nose

### llgal https://github.com/bgoglin/llgal
#RUN \
#        DIR=/tmp/llgal && \
#        mkdir -p ${DIR} && \
#        cd ${DIR} && \
#        curl -sL https://github.com/bgoglin/llgal/archive/llgal-${LLGAL_VERSION}.tar.gz | \
#        tar -zx --strip-components=1 && \
#        make && \
#        make install && \
#        rm -rf ${DIR}

### gifsicle http://www.lcdf.org/gifsicle
#RUN \
#        DIR=/tmp/gifsicle && \
#        mkdir -p ${DIR} && \
#        cd ${DIR} && \
#        curl -sL http://www.lcdf.org/gifsicle/gifsicle-${GIFSICLE_VERSION}.tar.gz | \
#        tar -zx --strip-components=1 && \
#        ./configure --prefix="/opt/gifsicle" --bindir="/opt/gifsicle/bin" && \
#        make && \
#        make install && \
#        rm -rf ${DIR}

### fdk-aac https://github.com/mstorsjo/fdk-aac
#RUN \
#        DIR=/tmp/fdk-aac && \
#        mkdir -p ${DIR} && \
#        cd ${DIR} && \
#        curl -sL https://github.com/mstorsjo/fdk-aac/archive/v${FDKAAC_VERSION}.tar.gz | \
#        tar -zx --strip-components=1 && \
#        autoreconf -fiv && \
#        ./configure --prefix="${PREFIX}" --enable-shared --datadir="${DIR}" && \
#        make && \
#        make install && \
#        rm -rf ${DIR}


## ffmpeg https://ffmpeg.org/
#RUN  \
#        DIR=/tmp/ffmpeg && mkdir -p ${DIR} && cd ${DIR} && \
#        curl -sLO https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2 && \
#        tar -jx --strip-components=1 -f ffmpeg-${FFMPEG_VERSION}.tar.bz2


#RUN \
#    ldd ${PREFIX}/bin/ffmpeg | grep opt/ffmpeg | cut -d ' ' -f 3 | xargs -i cp {} /usr/local/lib/ && \
#    cp ${PREFIX}/bin/* /usr/local/bin/ && \
#    cp -r ${PREFIX}/share/ffmpeg /usr/local/share/ && \
#    LD_LIBRARY_PATH=/usr/local/lib ffmpeg -buildconf

### Release Stage
#FROM        base AS release
#MAINTAINER  Julien Rottenberg <julien@rottenberg.info>

ENTRYPOINT  ["/bin/bash"]
#CMD [ "python", "./your-daemon-or-script.py" ]

#COPY --from=build /usr/local /usr/local

