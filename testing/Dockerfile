FROM rocker/rstudio:testing
MAINTAINER "Carl Boettiger and Dirk Eddelbuettel" rocker-maintainers@eddelbuettel.com

## temporary fix to deal with things moving around on unstable
RUN apt-get update && apt-get -y install  --no-install-recommends -t unstable libgdal-dev libpq-dev libspatialite-dev libsqlite3-dev


## LaTeX:
## This installs inconsolata fonts used in R vignettes/manuals manually since texlive-fonts-extra is HUGE

RUN apt-get update \
  && apt-get install  -y --no-install-recommends \
    aspell \
    aspell-en \
    ghostscript \
    imagemagick \
    lmodern \
    texlive-fonts-recommended \
    texlive-humanities \
    texlive-latex-extra \
    texinfo \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ \
  && cd /usr/share/texlive/texmf-dist \
  && wget http://mirrors.ctan.org/install/fonts/inconsolata.tds.zip \
  && unzip inconsolata.tds.zip \
  && rm inconsolata.tds.zip \
  && echo "Map zi4.map" >> /usr/share/texlive/texmf-dist/web2c/updmap.cfg \
  && mktexlsr \
  && updmap-sys

## Install some external dependencies. 
RUN apt-get update \
  && apt-get install -y --no-install-recommends -t unstable librdf0-dev \
  && apt-get install -y --no-install-recommends  \
    default-jdk \
    default-jre \
    gdal-bin \
    icedtea-netx \
    libatlas-base-dev \
    libcairo2-dev \
    libhunspell-dev \
    libgeos-c1v5 \
    libgeos-dev \
    libgsl-dev \
    librdf0-dev \
    libmysqlclient-dev \
    libpq-dev \
    libssl-dev \
    libsqlite3-dev \
    librsvg2-dev \
    libv8-dev \
    libxcb1-dev \
    libxdmcp-dev \
    libxml2-dev \
    libxslt1-dev \
    libxt-dev \
    mdbtools \
    netcdf-bin \
    qpdf \
    r-cran-rgl \
    ssh \
    vim \
  && R CMD javareconf \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

RUN install2.r -r "http://packages.ropensci.org" git2r
## Install the tidyverse package, RStudio pkg dev (and some close friends). 
RUN install2.r \
  --error --deps "TRUE" \
  -r "http://www.bioconductor.org/packages/release/bioc" \
  -r "https://cran.rstudio.com" \
  tidyverse devtools profvis rticles bookdown rmdshower \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds



## httr authentication uses this port
EXPOSE 1410
ENV HTTR_LOCALHOST 0.0.0.0
