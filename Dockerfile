FROM ufaldsg/cloud-asr-base
MAINTAINER Lukas Zilka

ADD . /opt/app
WORKDIR /opt/app
RUN bash install.sh

CMD while true; do python run.py; done
