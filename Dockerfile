FROM rocker/rstudio
MAINTAINER "Carl Boettiger and Dirk Eddelbuettel" rocker-maintainers@eddelbuettel.com

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
  && apt-get install -y --no-install-recommends  \
    default-jdk \
    default-jre \
    gdal-bin \
    icedtea-netx \
    libatlas-base-dev \
    libcairo2-dev \
    libhunspell-dev \
    libgeos-dev \
    libgsl0-dev \
    librdf0-dev \
    libmysqlclient-dev \
    libpq-dev \
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

## Install the tidyverse package, RStudio pkg dev (and some close friends). 
RUN Rscript -e "install.packages(c('tidyverse', 'devtools', 'profvis', 'rticles', 'bookdown', 'rmdshower'), repos = c('http://www.bioconductor.org/packages/release/bioc', 'https://cran.rstudio.com'), dep = TRUE)" \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## httr authentication uses this port
EXPOSE 1410
ENV HTTR_LOCALHOST 0.0.0.0
