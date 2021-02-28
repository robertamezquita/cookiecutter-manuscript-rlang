#!/bin/bash

# Manuscript website builder and renderer.
#
# Updates the manuscript website.
# ------------------------------------------------------------------------------

MODE=$1

if [[ $MODE == "build" ]]; then
    # Make a _build directory where everything is flattened (all Rmds at same level)
    mkdir -p _build/

    # Copy over the manuscript add-ins
    cp -R _figures _build/
    cp -R _tables _build/
    cp -R _resources _build/
    
    # - top-level html/settings
    cp _site.yml _build/
    cp _footer.html _build/

    # Unlike _analysis, copy over all Rmds within the manuscript folder for rendering 
    # Given that this area should only consist of prose, rendering/building extra files
    # should be cheap; that said, placing anything within a _deprecated dir will ignore it

    # Copy all Rmds, regardless of depth, place at top-level of _build
    RMDS=$(find . -name "*Rmd" | grep -v '_site' | grep -v '_build' | grep -v '_deprecated' )
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