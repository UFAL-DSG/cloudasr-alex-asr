FROM ufaldsg/cloud-asr-base
MAINTAINER Lukas Zilka

RUN apt-get update && \
    apt-get install -y build-essential libatlas-base-dev python-dev python-pip git wget gfortran g++ && \
    pip install theano

WORKDIR /app
RUN git clone https://github.com/UFAL-DSG/pykaldi2.git && \
    cd pykaldi && \
    cd /app/pykaldi/tools && \
    bash prepare_env.sh \
    make \
    make py \
    python setup.py install
    pip install -r requirements.txt && \
    make install && echo 'Pykaldi build and installation files prepared: OK' \
    ldconfig && \
    python -c 'import fst; import kaldi2.decoders' && \
    cd /app && \
    rm -rf pykaldi2

WORKDIR /opt/app

ADD . /opt/app
CMD while true; do python run.py; done
