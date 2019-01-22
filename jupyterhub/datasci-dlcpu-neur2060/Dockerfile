FROM browndatascience/datasci-dlcpu:latest

USER root

# Nothing to install as root

USER $NB_UID

#add extra plugins
RUN pip install --upgrade pip
RUN npm i npm@latest -g

# bqplot https://github.com/bloomberg/bqplot
RUN conda install -c conda-forge bqplot
RUN jupyter labextension install bqplot

#qgrid https://github.com/quantopian/qgrid 
RUN conda install -c conda-forge qgrid
RUN jupyter labextension install qgrid

# Clean up and fix permissions    
RUN rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER