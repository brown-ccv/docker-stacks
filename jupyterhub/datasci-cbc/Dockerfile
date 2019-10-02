ARG NAMED_TAG=latest
FROM brownccv/jupyterhub-datasci:$NAMED_TAG
ARG NAMED_TAG
RUN echo "--------Pulling from brownccv/jupyterhub-datasci with tag: ${NAMED_TAG}---------"

USER $NB_UID

# *********************R Extras ***************************
# R packages including IRKernel which gets installed globally.
RUN conda install --quiet --yes \
    'r-gridExtra' \
    'r-ggrepel' \
    'r-maps'

# Clean up and fix permissions
RUN npm cache clean --force && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
