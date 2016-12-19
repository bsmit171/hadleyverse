FROM rocker/verse
MAINTAINER "Carl Boettiger and Dirk Eddelbuettel" rocker-maintainers@eddelbuettel.com

## Install some external dependencies. 
RUN apt-get update \
  && apt-get install -y --no-install-recommends  \
    default-jdk \
    default-jre \
    icedtea-netx \
    libbz2-dev \
    libcairo2-dev \
    libgdal-dev \
    libicu-dev \
    liblzma-dev \
    libproj-dev \
    libgeos-dev \
    libgsl0-dev \
    librdf0-dev \
    librsvg2-dev \
    libv8-dev \
    libxcb1-dev \
    libxdmcp-dev \
    libxslt1-dev \
    libxt-dev \
    mdbtools \
    netcdf-bin \
  && . /etc/environment \
  && install2.r -e -r $MRAN rJava \
  && R CMD javareconf \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
## tidyverse, devtools and related R packages already inherited from rocker/verse

## httr authentication uses this port
EXPOSE 1410
ENV HTTR_LOCALHOST 0.0.0.0
