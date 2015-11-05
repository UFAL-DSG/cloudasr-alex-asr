FROM ufaldsg/cloud-asr-base
MAINTAINER Lukas Zilka

RUN apt-get update && \
    apt-get install -y build-essential libatlas-base-dev python-dev python-pip git wget gfortran g++ && \
    pip install theano

ADD . /opt/app
WORKDIR /opt/app
RUN install.sh


# CMD while true; do python run.py; done
