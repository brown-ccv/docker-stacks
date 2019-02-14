FROM browndatasci/sh-julia-datasci:latest

MAINTAINER Stronghold Help <stronghold-help@brown.edu>


COPY julia_scripts/external_pkgs.jl /opt/scripts/
RUN julia -e 'using Pkg; include("/opt/scripts/install_packages.jl"); include("/opt/scripts/external_pkgs.jl"); Pkg.update(); install(external_pkgs); precompile(external_pkgs)'

# manually install jupyter since it doesn't ask to install until prompted when running a notebook
RUN /opt/julia/share/julia/conda/3/bin/conda install -y jupyter

#remove pre-compiled libraries as it creates permission errors
RUN rm -rf /opt/julia/share/julia/compiled

#expose notebook and mysql port
EXPOSE 8888 3306
