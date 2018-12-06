FROM ubuntu:18.10

MAINTAINER Stronghold Help <stronghold-help@brown.edu>


# Basic OS dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -yq dist-upgrade \
 && apt-get install -yq --no-install-recommends \
    build-essential \
    gfortran \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation \
    git \
    emacs nano vim \
    openssh-client\ 
    && apt-get clean 

# not sure why this is needed but otherwise after installing miniconda we get 
#/bin/bash: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Configure basic environment
ENV SHELL=/bin/bash \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
# HOME=/?

# Add some other useful tools and dependencies
RUN apt-get install -y screen cmake m4 hdf5-tools gettext libcurl4-openssl-dev libssl-dev\
    && apt-get clean


# ****************************** MySQL **************************************

# Dependencies
RUN apt-get install -yq --no-install-recommends \
    lsb-release gnupg

# Get and configure apt repo for latest version
# see https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#apt-repo-fresh-install
ENV MYSQL_APT_VERSION 0.8.11-1_all
RUN cd /tmp/ && wget https://dev.mysql.com/get/mysql-apt-config_${MYSQL_APT_VERSION}.deb && \
    dpkg -i mysql-apt-config_${MYSQL_APT_VERSION}.deb

RUN apt-get update && apt-get install -y mysql-client libmysqlclient-dev

# ****************************** Julia ***************************
ENV JULIA_URL https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.2-linux-x86_64.tar.gz
        
ENV JULIA_DEPOT_PATH=/opt/julia
ENV JULIA_VERSION=1.0.2

RUN mkdir /opt/julia-${JULIA_VERSION} && \
    cd /tmp && \
    wget -q https://julialang-s3.julialang.org/bin/linux/x64/`echo ${JULIA_VERSION} | cut -d. -f 1,2`/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    echo "e0e93949753cc4ac46d5f27d7ae213488b3fef5f8e766794df0058e1b3d2f142 *julia-${JULIA_VERSION}-linux-x86_64.tar.gz" | sha256sum -c - && \
    tar xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz -C /opt/julia-${JULIA_VERSION} --strip-components=1 && \
    rm /tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz
RUN ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia

RUN mkdir /opt/scripts

# Add packages, they are all split into different files/steps so Docker Caching can work better
COPY julia_scripts/install_packages.jl /opt/scripts/
COPY julia_scripts/base_pkgs.jl /opt/scripts/
RUN julia -e 'include("/opt/scripts/install_packages.jl"); include("/opt/scripts/base_pkgs.jl"); install(base_pkgs)'

# Julia MySQL v0.7 ships with an outdated myslq client that prevents us to onnect to servers running
# MySQL > v8.04 see - https://github.com/JuliaDatabases/MySQL.jl/issues/118
RUN rm /opt/julia/packages/MySQL/owtkt/deps/usr/lib/libmariadb.so
RUN ln -s /usr/lib/x86_64-linux-gnu/libmysqlclient.so /opt/julia/packages/MySQL/owtkt/deps/usr/lib/libmariadb.so 

COPY julia_scripts/plotting_pkgs.jl /opt/scripts/
RUN julia -e 'include("/opt/scripts/install_packages.jl"); include("/opt/scripts/plotting_pkgs.jl"); install(plotting_pkgs)'

#expose notebook and mysql port
EXPOSE 8888 3306

COPY entrypoint_scripts/julia_base.sh /opt/scripts/
ENTRYPOINT ["/opt/scripts/julia_base.sh"]
