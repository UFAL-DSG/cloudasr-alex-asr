#!/bin/bash
set -e

apt-get update
apt-get install -y build-essential libatlas-base-dev python-dev python-pip git wget gfortran g++ unzip zlib1g-dev automake autoconf libtool subversion

wget http://repo.continuum.io/miniconda/Miniconda2-3.18.3-Linux-x86_64.sh -O miniconda.sh
chmod +x miniconda.sh
./miniconda.sh -b
export PATH=/root/miniconda2/bin:$PATH
conda update --yes conda

conda install theano --yes

git clone https://github.com/UFAL-DSG/alex-asr.git
cd alex-asr
pip install -r requirements.txt
bash prepare_env.sh
make
python setup.py install
mv /root/miniconda2/lib/python2.7/site-packages/* /usr/lib/python2.7/dist-packages/ || true
mv /root/miniconda2/lib/* /usr/lib || true
(source deactivate; cd /; python -c "from alex_asr import Decoder" && rm -rf alex-asr) || true  # Will remove only if everything was alright.
