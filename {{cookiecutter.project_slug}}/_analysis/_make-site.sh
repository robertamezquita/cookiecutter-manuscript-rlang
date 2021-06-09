#!/bin/bash

# Manuscript website builder and renderer.
#
# Updates the manuscript website.
# ------------------------------------------------------------------------------

MODE=$1

if [[ $MODE == "build" ]]; then
    # Make a _build directory where everything is flattened (all Rmds at same level)
    # Copy all Rmds, regardless of depth, place into top-level of repo for flat structure
    RMDS=($(find -L . -name "*Rmd" | grep -v '_site' | grep -v '_build' | grep -v '_deprecated' | grep -v 'renv'))
    for RMD in ${RMDS[*]}; do
        echo "Copying $RMD .."
        cp $RMD .
    done
fi

if [[ $MODE == "render" ]]; then
    # Go inside _build to call the render step to prevent issues
    R -e 'renv::activate(); here::here(); rmarkdown::render_site()' # _site.yml specifies output site as "../_site"
    cd ..
fi