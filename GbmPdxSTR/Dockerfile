FROM rocker/shiny-verse:4.1.0

LABEL maintainer="Lara Ianov <lianov@uab.edu>"
LABEL description="Dockerized GBM PDX STR Similarity Search Tool app dependencies"

#custom server config:
COPY ./shiny_customized.config /etc/shiny-server/shiny-server.conf

RUN apt-get update && apt-get install -y \
    libhdf5-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libpng-dev \
    libboost-all-dev \
    libxml2-dev \
    openjdk-8-jdk \
    python3-dev \
    python3-pip \
    wget \
    git \
    libfftw3-dev \
    libgsl-dev \
    llvm-10 \
    libbz2-dev \
    liblzma-dev \
    g++ \
    gcc \
    libglpk-dev \
    software-properties-common && add-apt-repository -y ppa:git-core/ppa

# main targets
RUN R -e "install.packages('markdown')"
RUN R -e "install.packages('shinyjs')"
RUN R -e "install.packages('shinyhelper')"
RUN R -e "install.packages('shinycssloaders')"
RUN R -e "install.packages('plyr')"
RUN R -e "install.packages('DT')"

# port container listens to (default R Shiny port)
EXPOSE 3838

# allow permission
RUN sudo chown -R shiny:shiny /srv/shiny-server
RUN sudo chown -R shiny:shiny /var/log/shiny-server/

# remove sample index and apps:
RUN sudo rm /srv/shiny-server/index.html
RUN sudo rm -rf /srv/shiny-server/sample-apps
#exec form for wildcards...
RUN ["/bin/bash", "-c", "sudo rm -rf /srv/shiny-server/{0*,1*}_*"]

# run app
CMD ["/usr/bin/shiny-server"]
