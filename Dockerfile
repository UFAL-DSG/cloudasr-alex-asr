FROM ufaldsg/cloud-asr-base
MAINTAINER Lukas Zilka

RUN apt-get update && \
    apt-get install -y build-essential libatlas-base-dev python-dev python-pip git wget gfortran g++ && \
    pip install theano

RUN install.sh
ADD . /opt/app

# CMD while true; do python run.py; done
