FROM gcr.io/jupyterhub-docker-images/jupyterhub-scipy:geol1510-spring2020 

USER root

USER $NB_UID

RUN pip install --upgrade pip
RUN npm i npm@latest -g

# *********************Python Geology libraries ***************************
# netcdf4
# metpy
# cartopy
# iris
# imbalanced-learn
RUN conda install --quiet --yes -c conda-forge\
    'netcdf4' 'metpy' 'cartopy' 'iris' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
