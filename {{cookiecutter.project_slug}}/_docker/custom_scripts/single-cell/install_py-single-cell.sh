#!/bin/bash

python3 -m pip --no-cache-dir install --upgrade \
    cellphonedb \
    scanpy \
    phate

# associated with PHATE - python is required
R -e 'install.packages("phateR")'