#!/bin/bash

# Visualisation ---
# thomasp85's packages
R -e "install.packages(c(
    'patchwork', 'scico', 'ggforce',
    'tidygraph', 'ggraph', 'GGally',
    'ragg', 'gganimate', '
))"

# 3D
R -e 'remotes::install_github("tylermorganwall/rayrender")'

# Generative art
R -e 'remotes::install_github("thomasp85/ambient")'
R -e 'remotes::install_github("djnavarro/jasmines")'

# Edge bundled networks
remotes::install_github("schochastics/edgebundle")


# Tidyverse-adjacent ---
# - pak = new package manager
R -e "install.packages(c(
    'styler', 'pak', 
    'vctrs', 'rlang', 'vroom', 
    'usethis', 'fs', 'lobstr',
    'cli', 'crayon', 'glue'
))"

R -e 'remotes::install_github("r-lib/clock")'