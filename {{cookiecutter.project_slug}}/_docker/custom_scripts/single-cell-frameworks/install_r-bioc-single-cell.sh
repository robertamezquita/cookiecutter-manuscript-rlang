R -e "BiocManager::install()"

# Essentials
R -e "BiocManager::install(c(
    'scran', 'scater', 'scRNAseq', 'BiocNeighbors', 
    'batchelor', 'rtracklayer', 'edgeR', 'DESeq2'
))"

# Signaling & Trajectory
R -e "BiocManager::install(c(
    'SingleCellSignalR', 'switchde'
))"

# Integration
R -e "remotes::install_github('immunogenomics/harmony')"

# Data type conversions Py<->R
R -e "remotes::install_github('theislab/zellkonverter')"