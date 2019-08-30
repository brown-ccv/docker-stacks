
FROM brownccv/jupyterhub-scipy:latest

USER root

USER $NB_UID

RUN pip install --upgrade pip
RUN npm i npm@latest -g

# *********************Python Geology libraries ***************************
RUN conda install --quiet --yes -c conda-forge\
    netcdf4 metpy cartopy iris && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
    