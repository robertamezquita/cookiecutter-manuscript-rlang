Cookiecutter for Data Science Driven Manuscript Writing
================

<img src='assets/logo.png' align="right" height="200" /></a>

This repo provides a cookiecutter for the purpose of writing a
manuscript that is largely driven by computational analyses. In
addition, this cookiecutter provides a means to create websites for both
the analysis side and the end manuscript based on the [Distill
publication](https://distill.pub) web-format, a template that is
optimized for scientific and technical communication.

## Requirements

First, install `cookiecutter` via `pip install cookiecutter` or
`brew install cookiecutter`.

Next, run the code below to create a new directory based on the
cookiecutter herein. The new directory will be customized based on how
you answer an interactive series of questions.

``` sh
cookiecutter gh:robertamezquita/cookiecutter-manuscript-rlang
```

And that’s it! Your new repo is ready to roll.

## Usage

This site has three primary branches:

-   `_analysis` : the data science side of the project where analyses
    will be split across notebooks and preliminary figures/tables will
    be generated
-   `_manuscript` : the manuscript side where you’ll compose both the
    primary text and final versions of figures/tables
-   `_submissions` : artifacts that contain the entirety of what is
    submitted for publication

The `_analysis` and `_manuscript` branches are organized in such a way
to facilitate the creation of a website for each aspect of the project.

To generate the template website to see for yourself, run:

``` sh
# `make all` runs `_make-site.sh under the hood to create an
# intermediate _build folder that is then rendered to _site
cd _analysis
make all 
cd ../_manuscript
make all
```

Navigating to the respective `_site` directories will bring you to each
freshly generated website. Both of these websites are generated based on
a configuration file `_site.yml` and the `_make-site.sh` script that
runs under-the-hood of the `make` command, which can be modified as
needed to reflect what should be available and where as content on the
website.

### What files are built/rendered for the website?

Its important to note that the site is rendered *only based on what is
provided inside of the `_build/` directory*. This is controlled by the
build portion of the `_make-site.sh` script. The `_site.yml` file then
controls what files from the `_build` directory are included or excluded
from the final `_site` directory. Thus, ensuring that these two files -
`_make-site.sh` and `_site.yml` - reflect your desired settings is
crucial.

These two files can (and should!) be modified to copy only the content
necessary to build and render the site. The analysis and manuscript
sides each have their own defaults explained below.

### Customizing the website

In both the analysis and manuscript sides, the `_site.yml` controls how
the website is structured via the navigation specification. *However,
this is not synonymous with what is built/rendered*. Aspects that are
built/rendered will not be included in the site if they are not called
from within the `_site.yml` file.

### Building the analysis website

The `_analysis` side’s website by default is rendered based on only on
the content within `_notebooks`. The reason for this design choice is
that the `_eda` section of the `_analysis` side should be treated as
“the playground” where you can do whatever you like. Eventually however,
you’ll hit upon some results that should be formalized and communicated
to an audience. This is the time when you “promote” an analysis to a
notebook, which will be clearly laid out and ensured to be
runnable/reproducible.

Note that when rendering, it will run a fresh R instance and walk
through the notebooks in sequential order to render each `.Rmd` (*be
sure to name each `.Rmd` uniquely and with prefixes that correctly
denote the order of operations!*).

The script however by default ignores any file with `_deprecated` as
part of its path (e.g. inside such a directory). Thus, once a notebook
has become irrelevant, place it into the `_deprecated` directory to keep
it as an archival record but not continue building/rendering it as the
site gets made.

Finally, the entire build process - create `_build`, render `_site`,
destroy `_build` - can be done via `make all`. The `make build`,
`make render`, and `make clean` (destroys both `_build` and `_site`)
subcommands discretizes the various steps.

#### Bypassing expensive calculations

Depending on the analysis, this may take a while, and may necessitate
intermediate caching or creation of intermediate files that can be
reloaded when rendering the `.Rmd` to avoid costly calculations. Note
however that if a cache is created via the default `knitr` methodology,
this cache will be erased each time the website is built, as the cache
is placed inside of the `_build` directory (which is continually
regenerated each time). Thus, change the cache location by modifying the
`knitr` settings. Another strategy is to generate intermediate
`.rda`/`.rds` files that capture expensive calculations, and then set
`eval=FALSE` for the chunks that should only be regenerated manually.
However, this strategy has its own weakness in that it breaks the
ability to reliably reproduce the workflow.

### Building the manuscript site

The `_manuscript` side’s website can be a bit more free-form, as it is
rendered based on all the `.Rmd` content within the section folders as
all of them are copied into the `_build` folder. *This is because the
manuscript side should really only contain prose*. This makes it easy
and quick to render the website. The `.Rmd` files should reference
objects in the `_figures`, `_tables`, and `_resources` directories as
needed for necessary content.

#### Building the final manuscript

Of course, while the website is a great add-on, there still is the
matter of generating the *final* manuscript, which is the composite of
all the individual sections of the paper. An initial take of this can be
done by running `make preview`. This will create a preview of the final
composition, which is great because it will automagically generate all
the necessary citations and bibliography.

Inevitably however there may still be work required to finalize the
manuscript into a submission ready artifact. Thus, once such is done,
the final manuscript artifact can be placed into the `_submission`
directory.

------------------------------------------------------------------------

## Structure & Rationale

Herein I’ll detail my own thoughts on what all the point of this is, the
high-level view of the organizational hierarchy of the repo along with
their purpose, and finally a tidbit about managing the web of
interdependencies that inevitably composes such a project.

### Rationale

Manuscripts are finicky things, in that there are myriad complications.
Indeed, there is an art to putting together a manuscript, as it involves
the management of various moving parts - primary text, figures, tables,
and any other supplementary material. Dealing with all this as a single
person is difficult enough as it is, and once other people are
introduced, it becomes an exponential mess.

Complicating all this is computational analyses. More and more it is
recognized as a crucial part of a generating a publication. But all too
often, this code is left as a pile of spaghetti that is uninterpretable
to outside audiences, and even likely your future self.

So, this cookiecutter seeks to address some of the problems that we
*can* handle. Things like making computational analyses *reproducible,
accessible, portable, and all that.* With regards to the manuscript
creation, there is a great cross-platform tool - markdown - that will
prevent the nightmare situation of “that one time a collaborator wanted
you to add one last reference and you had to manually renumber *all* of
your references because something broke.” And of course, tables and
figures should all be kept in a place right next to the writing as
separate assets.

Thus, we address two things here: creating a common organizational
structure that encompasses both manuscripts and data science projects,
embracing the bespoke nature of a manuscript - with all its little
hand-curated bits - as well as the computational analyses that should be
reproducible by anyone at anytime and ensured to be functional and
up-to-date.

Furthermore, this structure supports the creation of a reproducible
workflow. This encompasses modern best practices in data science. The
[`targets`](https://docs.ropensci.org/targets/index.html) R package home
page contains many resources on how to get started with learning how to
create and manage reproducible workflows. In brief, the key concepts are
those of *provenance* (tracking the origin, location, and history of an
object) and *reproducibility* through the running of computation
contingent on changes to a data’s provenance. While providing such tools
is well beyond the scope of this cookiecutter, the design herein is
inspired by such concepts and supports it through providing a navigable
file hierarchy.

Lastly, we want to make this all accessible to a wide audience, in a way
that is both portable and - dare I say - beautiful. To this end, the
cookiecutter is organized to allow for the rendering of a manuscript as
a website (where each main section could be its own page and
tables/figures can be placed as needed) as well as a website to feature
viewable ongoing analytical work. For that, we are using the [Distill
for R Markdown](https://rstudio.github.io/distill/) format that is
optimized for scientific and technical communication.

The focus of this cookiecutter is really towards the writing of academic
manuscripts - as it contains explicit callouts to figures, tables, and
the written word. More broadly however, it is focused on the
*communication* of scientific concepts, building *trust* through a
navigable file hierarchy, and ensuring *functionality* by implicitly
supporting workflow-infrastructure tooling.

### High-level view with descriptions

Starting with the total structure, and descriptions for each component
describing its intended use.

-   \_manuscript
    -   \_resources - miscellaneous objects that may be useful to have
        handy - either for rendering the website or as a supplementary
        resource (code will be kept in a different part of the repo so
        don’t place that here)
    -   \_figures - bespoke assets and vector/photo/publisher specific
        software format files
    -   \_tables
        -   \_main - these tables should be in a common format (tsv;
            csv); while stylized tables can be kept here as well, common
            format tables that can be interpreted programmatically will
            be nice to have for the website rendering
        -   \_supplementary - any tables that should be a part of a
            manuscript submission
    -   index.Rmd, about.Rmd, footer.html - the index page is the start
        point of the manuscript website; the about shows an example
        page; the footer is a nice to have across the website
    -   \_site.yml - the structure definition that composes the site
    -   Makefile, \_build-site.sh\*, \_render-site.sh - helpers that
        automagically build the site; `make build` creates the website
        skeleton and performs necessary setup such as copying the
        \_figures\*, \_tables\*, \_resources\* folders and other
        top-level assets (your Rmd’s!) into the automagically created
        `_build` folder; `make render` actually produces the site and
        places it in `_site`; `make clean` will remove the `_build`
        folder; `make all` runs all these steps
    -   manuscript .Rmds - these `RMarkdown` files are the content of
        your manuscript’s site and also knitted together to form the
        full body of the manuscript; it can be organized into as many or
        as few files as you’d like, where each file becomes its own
        separate page; note, ideally, these *do not* have code in them;
        if they do, ensure it is a necessity (e.g. for pulling in a
        table)
    -   \*your-bespoke-manuscript.whatever - the manually compiled
        version of the manuscript should you so choose to make it (and
        you likely will, as most publishers require `.docx` or `.pdf`
        format)
-   \_analysis
    -   \_data-store - a central place to store *processed* datasets;
        this folder may have additional substructure as needed to
        organize the data in a meaningful way; most importantly, the
        files here should be *links*, as they should be tied to specific
        functional *notebooks* that generate them; this area may also
        contain final outputs generated from data stored in \_data-raw\*
        and created by \_data-exec\*, but that is a judgement call for
        you to make
    -   \_data-raw - raw datasets that are (mostly) untouched and may be
        used to generate object within \_data\*; ideally, this area will
        contain (untracked) large raw data (e.g. bams, reference
        genomes, etc.) either as-is or via a symbolic link
        representation to a central large data store
    -   \_data-exec - executable scripts that can be used to re-generate
        objects stored in the \_data\*; these scripts should always be
        checked that they work; these scripts should really be thought
        of as being part of central preprocessing/pipeline work that
        operates on large data stores that would not be kept in a
        reasonably sized repo; while there may be some overlap
        conceptually with analysis code stored in \_notebooks\*, you can
        think of this area as more for components that do not need much
        explanation/are not the novel parts of the work
    -   \_eda - exploratory data analyses that may or may not work at
        any given time; this area can be organized in a manner that best
        suits your needs
    -   \_notebooks - a place to store *working*, functional code
        (e.g. EDA code that has been “promoted”) that is mixed with
        prose to explain the work that generates either data objects,
        tables, or figures; this store is organized into groups that are
        annotated to note the sequence in which they should be run (as
        there may be notebooks with upstream dependencies); within each
        notebook, the same approach is taken, as (long) scripts are
        broken up into a sequential order for execution
        -   01.my-first-analysis-objective - each notebook should be
            centered on a single analytical objective; inside are all
            the inputs and outputs for the analysis such that each
            notebook can be a standalone component
            -   01.setup-code.Rmd\*
            -   02.more-preamble.Rmd\*
            -   *…*
            -   0N.figure-generating-code.Rmd\*
            -   \_figures - output figures generated within the notebook
            -   \_tables - output tables generated within the notebook
            -   \_input - input data used by the notebook; may be a
                combination of *de-novo* external data, data from
                *data-raw*
            -   \_output - output data generated within the notebook;
                these data are linked *out* to other areas of the repo
                (e.g., downstream notebooks)
        -   02.my-second-analysis-objective - note the sequential order
            in relation to the first notebook denoted by the naming
            schema
            -   01.code.Rmd\*
            -   *…*
            -   \_figures
            -   \_tables
            -   \_data-input - if this notebook is dependent on data
                outputs generated by a prior notebook, this will have a
                *link* to relevent notebook’s \_data-output directory’s
                file
            -   \_data-output
    -   \_figures-store - a central location for figures, with links to
        the pertinent figure generated within a notebook
    -   \_tables-store - likewise for tables
    -   \_resources-store - likewise for any other resources
-   \_submissions - the complete artifacts (code, figures, text, etc.)
    that are actually submitted to a publisher; note the use of the
    plural form..

### Managing the various interdependencies

As noted above, the relationships between inputs, scripts, and outputs
end up forming a directed acyclic graph (DAG) that quickly gets out of
hand as a project’s scope inevitably increases. The construction of this
DAG is guided by this cookiecutter repository. The simplest form of
managing/creating this DAG would simply be to create symbolic links
between the relevant objects. However, modern infrastructure focused
packages such as the
[`targets`](https://docs.ropensci.org/targets/index.html) R package,
[pachyderm](https://github.com/pachyderm/pachyderm),
[kubeflow](https://www.kubeflow.org), and certainly many others could
operate within this organizational system.

For any infrastructure package to work with this system, it must:

-   draw links to and from scripts that are comprised of data and
    software dependencies/outputs
-   watch for changes to the data, scripts, and software dependencies
    -   note that, external software is highly volatile, thus it may not
        be practical to track *all* upstream dependencies; this is where
        environment managers such as
        [`venv`](https://docs.python.org/3/library/venv.html) and
        [`renv`](https://rstudio.github.io/renv/articles/renv.html) come
        in handy to annotate and create reproducible environments, as
        well as solutions that containerize objects such as
        [`Docker`](https://www.docker.com)

## License

This project is licensed under the terms of the [MIT License](/LICENSE)

## Acknowledgements

Much of this template is based on lazappi’s
[cookiecutter-r-data-analysis](https://github.com/lazappi/cookiecutter-r-analysis)
template, which was based on other templates and the tree goes on and
on.
