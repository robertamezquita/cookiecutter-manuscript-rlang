#!/bin/bash

# Install from ubuntu apt
apt-get update && apt-get install -y --no-install-recommends \
    bedtools \
    samtools \
    vcftools \
    picard-tools

# fastq-tools
git clone https://github.com/dcjones/fastq-tools.git && \
    cd fastq-tools && \
    ./autogen.sh && ./configure && make install