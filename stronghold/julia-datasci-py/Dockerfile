FROM browndatasci/sh-julia-datasci:latest

MAINTAINER Stronghold Help <stronghold-help@brown.edu>


COPY julia_scripts/external_pkgs.jl /opt/scripts/
RUN julia -e 'using Pkg; include("/opt/scripts/install_packages.jl"); include("/opt/scripts/external_pkgs.jl"); Pkg.update(); install(external_pkgs)'

#remove pre-compiled libraries as it creates permission errors
RUN rm -rf $JULIA_DEPOT_PATH/compiled

#expose notebook and mysql port
EXPOSE 8888 3306
