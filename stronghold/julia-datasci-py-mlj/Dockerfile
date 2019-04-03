FROM brownccv/sh-julia-datasci-py:latest

MAINTAINER Stronghold Help <stronghold-help@brown.edu>

RUN apt-get install -yq --no-install-recommends curl && apt-get clean

COPY julia_scripts/mlj_pkgs.jl /opt/scripts/
RUN julia -e 'using Pkg; include("/opt/scripts/install_packages.jl"); include("/opt/scripts/mlj_pkgs.jl"); Pkg.update(); install(mlj_pkgs_add); clone(mlj_pkgs_clone);'


#remove pre-compiled libraries as it creates permission errors
RUN rm -rf /opt/julia/share/julia/compiled

#expose notebook and mysql port
EXPOSE 8888 3306
