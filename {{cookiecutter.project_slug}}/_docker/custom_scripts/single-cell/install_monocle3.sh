#!/bin/bash

R -e "BiocManager::install(c(
    'BiocGenerics', 'DelayedArray', 'DelayedMatrixStats',
    'limma', 'S4Vectors', 'Matrix.utils')"

R -e "
    devtools::install_github('cole-trapnell-lab/leidenbase'); 
    devtools::install_github('cole-trapnell-lab/monocle3')"
