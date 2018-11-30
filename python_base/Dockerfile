FROM ubuntu:18.10

MAINTAINER Stronghold Help <stronghold-help@brown.edu>


# Basic OS dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -yq dist-upgrade \
 && apt-get install -yq --no-install-recommends \
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


# # Do we need a server?
# # RUN  apt-get install -y debconf-utils && \
# #      echo 'mysql-server mysql-server/root_password password bcbi123' | debconf-set-selections && \
# #      echo 'mysql-server mysql-server/root_password_again password bcbi123' | debconf-set-selections && \
# #      apt-get -y install mysql-server

# ****************************** Conda and Python***************************
# Configure environment
ENV CONDA_DIR=/opt/conda 
ENV PATH=$CONDA_DIR/bin:$PATH
ENV MINICONDA_VERSION 4.5.11

# Install conda and check the md5 sum provided on the download site
RUN cd /tmp && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    echo "e1045ee415162f944b6aebfe560b8fee *Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh" | md5sum -c - && \
    /bin/bash Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    conda config --system --prepend channels conda-forge && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true && \
    conda install --quiet --yes conda="${MINICONDA_VERSION%.*}.*" && \
    conda update --all --quiet --yes && \
    conda clean -tipsy
#     # rm -rf /home/$NB_USER/.cache/yarn && \
#     # fix-permissions $CONDA_DIR && \
#     # fix-permissions /home/$NB_USER

# Install Tini
RUN conda install --quiet --yes 'tini=0.18.0' && \
    conda list tini | grep tini | tr -s ' ' | cut -d ' ' -f 1,2 >> $CONDA_DIR/conda-meta/pinned && \
    conda clean -tipsy 
    # fix-permissions $CONDA_DIR && \
    # fix-permissions /home/$NB_USER

# Install desired python packages
# Generate a notebook server config
# Cleanup temporary files
RUN conda install -c conda-forge --quiet --yes \
    notebook \
    jupyterlab \
    numpy \
    scipy \
    matplotlib \
    pandas   \
    scikit-learn \
    statsmodels \
    iml \
    xgboost \
    tsfresh \
    natsort \
    nltk \
    spacy \
    seaborn \
    xlrd \
    fuzzywuzzy \
    cufflinks-py \
    plotly \
    rise && \
    conda clean -tipsy


# ****************************** Julia ***************************
  


# # Install Julia
# ADD files/install-julia.sh /test/install-julia.sh
# ADD files/.ssh/ /root/.ssh/

# RUN apt-get update \
#         && apt-get install --no-install-recommends -qq texlive-latex-base git \
#         texlive-pictures texlive-latex-extra pdf2svg poppler-utils gnuplot-nox \
#         wget ca-certificates openssh-client rsync file \
#         && /test/install-julia.sh 1.0 \
#         && chmod 700 /root/.ssh && chmod 600 /root/.ssh/*

#expose notebook and mysql ports
EXPOSE 8888 3306

ENTRYPOINT ["/bin/bash"]
