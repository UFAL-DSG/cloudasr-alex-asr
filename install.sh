#!/bin/bash

apt-get update
apt-get install -y build-essential libatlas-base-dev python-dev python-pip git wget gfortran g++ unzip

wget http://repo.continuum.io/miniconda/Miniconda2-3.18.3-Linux-x86_64.sh -O miniconda.sh
chmod +x miniconda.sh
./miniconda.sh -b
export PATH=/root/miniconda2/bin:$PATH
conda update --yes conda

conda install theano --yes


git clone https://github.com/UFAL-DSG/pykaldi2.git
cd pykaldi2
pip install -r requirements.txt
bash prepare_env.sh
make
make py
python setup.py install
#cd ..
#rm -rf pykaldi2
