#!/bin/bash

# Manuscript website builder and renderer.
#
# Updates the manuscript website.
# ------------------------------------------------------------------------------

MODE=$1

if [[ $MODE == "build" ]]; then
    # Make a _build directory where everything is flattened (all Rmds at same level)
    mkdir -p _build/

    # -- Manually amend this file to add any extra items to _build --
    # Copy over supplemental folders that do not contain Rmd content but are needed for said Rmd content
    cp -R _store-resources _build/

    # - top-level html/settings
    cp _site.yml _build/
    cp footer.html _build/

    # - copy all Rmds, regardless of depth, place into top-level of _build/
    RMDS=$(find . -name "*Rmd" | grep -v '_site' | grep -v '_build' )
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