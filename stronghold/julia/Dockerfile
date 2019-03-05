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
    gpg \
    emacs nano vim \
    openssh-client\
    xdg-utils \
    && apt-get clean

# not sure why this is needed but otherwise after installing miniconda we get
#/bin/bash: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Configure basic environment
ENV SHELL=/bin/bash \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    PROMPT_COMMAND="echo -n [$()]"


# Add some other useful tools and dependencies
RUN apt-get install -y screen cmake m4 hdf5-tools gettext libcurl4-openssl-dev libssl-dev\
    && apt-get clean


# ****************************** MySQL **************************************

# Dependencies
RUN apt-get install -yq --no-install-recommends \
    lsb-release gnupg

# Get and configure apt repo for latest version
# see https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#apt-repo-fresh-install
# if you get an error - check your MYSQL_APT_VERSION at https://dev.mysql.com/downloads/repo/apt/
ENV MYSQL_APT_VERSION 0.8.12-1_all
RUN cd /tmp/ && wget https://dev.mysql.com/get/mysql-apt-config_${MYSQL_APT_VERSION}.deb && \
    dpkg -i mysql-apt-config_${MYSQL_APT_VERSION}.deb

RUN apt-get update && apt-get install -y mysql-client libmysqlclient-dev

# ****************************** Julia ***************************
# UPDATE THIS TO UPGRADE JULIA VERSION
ENV JULIA_VERSION 1.1.0

# get GPG key and install it to key ring, download and install julia
RUN cd /tmp && \
    wget -q https://julialang.org/juliareleases.asc && \
    gpg --import juliareleases.asc && \
    JULIA_MAJOR_VERSION=$(echo $JULIA_VERSION | cut -c1-3) && \
    JULIA_FILE=$(echo julia-$JULIA_VERSION-linux-x86_64.tar.gz) && \
    JULIA_URL=$(echo https://julialang-s3.julialang.org/bin/linux/x64/$JULIA_MAJOR_VERSION/$JULIA_FILE) && \
    mkdir /opt/julia && \
    cd /tmp && \
    wget -q $JULIA_URL && \
    wget -q $(echo $JULIA_URL.asc) && \
    gpg --verify $JULIA_FILE.asc && \
    tar xzf $JULIA_FILE -C /opt/julia --strip-components=1 && \
    rm /tmp/$JULIA_FILE

RUN ln -fs /opt/julia/bin/julia /usr/local/bin/julia

RUN mkdir /opt/scripts

# Add packages, they are all split into different files/steps so Docker Caching can work better
COPY julia_scripts/install_packages.jl /opt/scripts/
COPY julia_scripts/base_pkgs.jl /opt/scripts/
RUN julia -e 'include("/opt/scripts/install_packages.jl"); include("/opt/scripts/base_pkgs.jl"); install(base_pkgs)'

# Julia MySQL v0.7 ships with an outdated myslq client that prevents us to Connect to servers running on Brown network
# MySQL > v8.04 see - https://github.com/JuliaDatabases/MySQL.jl/issues/118
RUN rm /opt/julia/share/julia/packages/MySQL/owtkt/deps/usr/lib/libmariadb.so
RUN ln -s /usr/lib/x86_64-linux-gnu/libmysqlclient.so /opt/julia/share/julia/packages/MySQL/owtkt/deps/usr/lib/libmariadb.so
ENV LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN y


COPY julia_scripts/plotting_pkgs.jl /opt/scripts/
RUN julia -e 'include("/opt/scripts/install_packages.jl"); include("/opt/scripts/plotting_pkgs.jl"); install(plotting_pkgs)'

# set the julia registry using startup.jl
RUN cd /opt/julia/share/julia/registries && \
    mv General StrongHoldGeneral && \
    cd StrongHoldGeneral && \
    sed -i 's/name = "General"/name = "StrongHoldGeneral"/g' Registry.toml && \
    sed -i 's/uuid = "23338594-aafe-5451-b93e-139f81909106"/uuid = "a67460e4-2ee5-11e9-b210-d663bd873d93"/g' Registry.toml && \
    sed -i 's/repo = "https:\/\/github.com\/JuliaRegistries\/General.git"/repo = "\/opt\/julia\/share\/julia\/registries\/StrongHoldGeneral"/g' Registry.toml && \
    git config --global user.email "stronghold-help@brown.edu" && \
    git config --global user.name "Stronghold Team" && \
    git add . && \
    git commit -m "updating registry details for stronghold" && \
    git remote remove origin
COPY julia_scripts/sh_startup.jl /opt/julia/etc/julia/startup.jl

# remove compiled packages from shared install
RUN JULIA_MAJOR_VERSION=$(echo v$JULIA_VERSION | cut -c1-4) && \
    cd /opt/julia/share/julia/compiled/$JULIA_MAJOR_VERSION && \
    rm -rf *

#expose notebook and mysql port
EXPOSE 8888 3306

COPY entrypoint_scripts/julia_base.sh /opt/scripts/
ENTRYPOINT ["/opt/scripts/julia_base.sh"]
