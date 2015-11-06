#!/bin/bash

mkdir /opt/models
wget -O /model.zip https://vystadial.ms.mff.cuni.cz/tmp_zilka/nnet_cs.zip 
wget -O /opt/models/vad.tffnn https://vystadial.ms.mff.cuni.cz/download/alex/resources/vad/voip/vad_nnt_1196_hu512_hl1_hla3_pf30_nf15_acf_4.0_mfr32000000_mfl1000000_mfps0_ts0_usec00_usedelta0_useacc0_mbo1_bs1000.tffnn

(cd /; unzip model.zip)
