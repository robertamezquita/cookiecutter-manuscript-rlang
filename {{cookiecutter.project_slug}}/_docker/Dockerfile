# Docker image for {{cookiecutter.project_slug}}
#
# Builds off of a base image with R preinstalled with tidyverse
# and adds on scripts both from the rocker image itself
# (/rocker_scripts) and a manually specified collection of
# packages, (/custom_scripts). These installs are drawn from either
# the apt package manager (apt-get), python's pip3, or R's
# package manager, where the source could be from either the native
# package repositories or a git repo. Examples of all these modes
# are available in the /custom_scripts directory.
#
# The default base image provided here is from the rocker team:
# https://github.com/rocker-org/rocker-versioned2
# This contains a pre-installed R (+tidyverse) image that can be used
# to build off of.
#
# To learn more about this image, see the rocker-org repo above to check out 
# the extra rocker scripts and available base images.
# To learn more about the use of Docker and building images (working with
# containers), see the docker 
#
# ------------------------------------------------------------------------------ 

# Base image
https://github.com/rocker-org/rocker-versioned2
FROM rocker/tidyverse:latest

# Rocker-provided scripts with extra installs ---
RUN /rocker_scripts/install_verse.sh
RUN /rocker_scripts/install_python.sh
RUN /rocker_scripts/install_tensorflow.sh
RUN /rocker_scripts/install_geospatial.sh

# Manually specified custom installs ---
RUN mkdir -p /custom_scripts
COPY custom_scripts /custom_scripts/

# Stats and machine learning ---
RUN /custom_scripts/stats-and-ml/install_tidymodels.sh

# Generic seq utils (samtools, bedtools, deeptools, etc)
RUN /custom_scripts/seq-utils/install_py-seq-utils.sh

# Single-cell (scanpy, bioconductor, seurat, monocle3) ---
RUN /custom_scripts/single-cell/install_py-single-cell.sh
RUN /custom_scripts/single-cell/install_r-bioc-single-cell.sh
RUN /custom_scripts/single-cell/install_seurat.sh
RUN /custom_scripts/single-cell/install_monocle3.sh

# Misc seq tools ---
RUN /custom_scripts/install_cli-seq-utils.sh
RUN /custom_scripts/install_py-sci.sh

# Misc R tools ---
RUN /custom_scripts/install_r-utils.sh

# Failed; needs to be checked ---
# RUN /rocker_scripts/install_pandoc.sh

# Misc Essentials ---
RUN python3 -m pip --no-cache-dir install --upgrade \
    radian

# Create volume for mounting ---
VOLUME "/mnt/project"