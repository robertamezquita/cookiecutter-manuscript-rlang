#!/bin/bash

# Manuscript website builder and renderer.
#
# Updates the manuscript website.
# ------------------------------------------------------------------------------

MODE=$1

if [[ $MODE == "build" ]]; then
    RMDS=$(find . -name "*Rmd" -depth 2 | grep -v '_site' | grep -v '_build' )

    # Make a _build directory where everything is flattened (all Rmds at same level)
    mkdir -p _build/

    # - extra resources
    cp -R _images _build/
    cp -R _resources _build/

    # - top-level html/settings
    cp _site.yml _build/
    cp _footer.html _build/

    # - copy Rmds
    cp *.Rmd _build/
    for RMD in ${RMDS[*]}; do
        cp $RMD _build/
    done
fi

if [[ $MODE == "render" ]]; then
    # Go inside _build to call the render step to prevent issues
    cd _build/
    R -e 'rmarkdown::render_site()' # _site.yml specifies output site as "../_site"
    cd ..
fi