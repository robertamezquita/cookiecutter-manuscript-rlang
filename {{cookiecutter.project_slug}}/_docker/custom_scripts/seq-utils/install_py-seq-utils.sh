#!/bin/bash

python3 -m pip --no-cache-dir install --upgrade \
    deeptools \
    pybedtools \
    pyBigWig \
    pysam \
    gffutils \
    tqdm \
    intervaltree

# PyGenomeTracks ---
# - requires a HiCMatrix tool ==v15 prior to install
wget https://github.com/deeptools/HiCMatrix/archive/15.tar.gz && \
    pip3 --no-cache-dir install 15.tar.gz
python3 -m pip --no-cache-dir install --upgrade \
    pyGenomeTracks