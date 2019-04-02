FROM jupyter/minimal-notebook:65761486d5d3 

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
    gcc \
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

RUN pip install vtk && \
    pip install mayavi && \
    pip install PyQt5 && \
    pip install pysurfer && \
    pip install mne && \
    pip install https://api.github.com/repos/autoreject/autoreject/zipball/master && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN jupyter nbextension install mayavi --py --sys-prefix && \
    jupyter nbextension enable mayavi --py --sys-prefix && \
    npm cache clean --force

USER root

RUN apt-get install -yq --no-install-recommends xvfb x11-utils libx11-xcb1 && \
    apt-get clean

# ENTRYPOINT ["xvfb-run", "--server-args", "-screen 0 1920x1080x24",  "start.sh"]
# CMD ["xvfb-run", "--server-args", "-screen 0 1920x1080x24", "start-notebook.sh"]

# Switch back to jovyan to avoid accidental container runs as root
USER ${NB_UID}

# # helper file for xvfb (for LavaVu)
# ADD xvfb-run /usr/bin/
# RUN chmod +x /usr/bin/xvfb-run
# #ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh

# # script for xvfb-run.  all docker commands will effectively run under this via the entrypoint
# RUN printf "#\041/bin/sh \n rm -f /tmp/.X99-lock && xvfb-run -s '-screen 0 1600x1200x16' \$@" >> /usr/local/bin/xvfbrun.sh && \
# chmod +x /usr/local/bin/xvfbrun.sh

# note we use xvfb which to mimic the X display for lavavu
# ENTRYPOINT ["/tini", "--", "/usr/local/bin/xvfbrun.sh"]
ENTRYPOINT ["tini", "-g", "--", "xvfb-run"]