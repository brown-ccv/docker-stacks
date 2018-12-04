FROM brown-datasci:julia_base:latest

MAINTAINER Stronghold Help <stronghold-help@brown.edu>


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


# ********************Julia/Python Interop ***************************
# Point Julia towards 
# ENV PYTHON=
# ENV JUPYTER=
# ENV CONDA_JL_HOME=
RUN julia -e 'using Pkg; Pkg.build("Conda"); Pkg.build("PyCall")'' Pkg.build("IJulia");'

ENTRYPOINT ["/bin/bash"]
