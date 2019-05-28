FROM brownccv/sh-julia-datasci:latest

MAINTAINER Stronghold Help <stronghold-help@brown.edu>


COPY julia_scripts/bio_pkgs.jl /opt/scripts/

RUN wget https://github.com/electron/electron/releases/download/v4.0.4/electron-v4.0.4-linux-x64.zip
RUN unzip -q electron-v4.0.4-linux-x64.zip -d atom

RUN julia -e 'using Pkg; include("/opt/scripts/install_packages.jl"); include("/opt/scripts/bio_pkgs.jl"); Pkg.update(); install(bio_pkgs);'

RUN apt-get install -y libgtk2.0-0 \
                       libxtst6 \
                       libxss1 \
                       libgconf-2-4 \
                       libnss3 \
                       libssl1.0-dev

#remove pre-compiled libraries as it creates permission errors
RUN rm -rf /opt/julia/share/julia/compiled

# change permissions on VariantVisualization package.
RUN chmod 777 /opt/julia/share/julia/packages/VariantVisualization/*/

#expose notebook and mysql port
EXPOSE 8888 3306
