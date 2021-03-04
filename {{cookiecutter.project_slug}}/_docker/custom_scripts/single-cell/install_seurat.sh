#!/bin/bash

CRAN=${CRAN:-https://cran.r-project.org}
NCPUS=${NCPUS:-1}

# Additional CRAN packages
install2.r --error --skipinstalled -r $CRAN -n $NCPUS \
    Seurat \
    uwot