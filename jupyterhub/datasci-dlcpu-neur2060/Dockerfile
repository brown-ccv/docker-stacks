FROM browndatascience/datasci-dlcpu:latest

USER root

# Nothing to install as root

USER $NB_UID

#add extra plugins

RUN pip install --upgrade pip
RUN npm i npm@latest -g

# bqplot https://github.com/bloomberg/bqplot
conda install -c conda-forge bqplot
jupyter labextension install bqplot

#qgrid https://github.com/quantopian/qgrid 
conda install -c conda-forge qgrid
jupyter labextension install qgrid
