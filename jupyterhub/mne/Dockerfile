FROM jupyter/scipy-notebook:eb149a8c333a 

MAINTAINER Jupyter Help <jupyter-help@brown.edu>


# *********************As User ***************************
USER root

# *********************Unix tools ***************************
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -yq dist-upgrade \
    && apt-get install -yq --no-install-recommends \
    openssh-client \
    vim \ 
    curl \
    && apt-get clean

USER $NB_UID


RUN pip install --upgrade pip
RUN npm i npm@latest -g

# *********************As User ***************************
USER $NB_UID


RUN pip install --upgrade pip
RUN npm i npm@latest -g

# *********************Extensions ***************************

# Install google-drive extension
RUN jupyter labextension install @jupyterlab/google-drive

# Install nbgitpuller extension
RUN pip install nbgitpuller && \
    jupyter serverextension enable --py nbgitpuller --sys-prefix && \
    npm cache clean --force

# Install RISE extension
RUN pip install RISE && \
    jupyter nbextension install rise --py --sys-prefix &&\
    jupyter nbextension enable rise --py --sys-prefix &&\
    npm cache clean --force

RUN jupyter labextension install @jupyterlab/git && \
    pip install jupyterlab-git && \
    jupyter serverextension enable --py jupyterlab_git --sys-prefix &&\
    npm cache clean --force

# Clean up and fix permissions    
RUN rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER


# *********************MNE Directions***************************
# RUN curl -O https://raw.githubusercontent.com/mne-tools/mne-python/master/environment.yml

# RUN conda env create -f environment.yml &&\
#     conda clean -tipsy && \
#     fix-permissions $CONDA_DIR && \
#     fix-permissions /home/$NB_USER

# Error for mayavi
#  File "tvtk/vtk_module.py", line 15, in <module>
#       from vtk import *
#   ModuleNotFoundError: No module named 'vtk'

######### Conda, docker builds but at run time we get errors
#from mayavi import mlab
# ---------------------------------------------------------------------------
# ImportError                               Traceback (most recent call last)
# /opt/conda/lib/python3.6/site-packages/vtk/vtkRenderingOpenGL2.py in <module>
#       4     # use relative import for installed modules
# ----> 5     from .vtkRenderingOpenGL2Python import *
#       6 except ImportError:

# ImportError: libGL.so.1: cannot open shared object file: No such file or directory


# RUN conda install --quiet --yes -c conda-forge mne &&\
#     conda clean -tipsy && \
#     fix-permissions $CONDA_DIR && \
#     fix-permissions /home/$NB_USER

################### Just the workshop######################

# https://raw.githubusercontent.com/jasmainak/mne-workshop-brown/master/environment.yml

RUN pip install mayavi && \
    pip install PyQt5 && \
    pip install pysurfer && \
    pip install mne && \
    pip install https://api.github.com/repos/autoreject/autoreject/zipball/master && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN jupyter nbextension install mayavi --py --sys-prefix && \
    npm cache clean --force