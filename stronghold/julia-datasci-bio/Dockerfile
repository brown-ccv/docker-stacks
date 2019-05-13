FROM brownccv/sh-julia-datasci:latest

MAINTAINER Stronghold Help <stronghold-help@brown.edu>


COPY julia_scripts/bio_pkgs.jl /opt/scripts/
RUN julia -e 'using Pkg; include("/opt/scripts/install_packages.jl"); include("/opt/scripts/bio_pkgs.jl"); Pkg.update(); install(bio_pkgs);'

RUN apt-get install -y libgtk2.0-0

#remove pre-compiled libraries as it creates permission errors
RUN rm -rf /opt/julia/share/julia/compiled

# change permissions on VariantVisualization package.
RUN chmod 777 /opt/julia/share/julia/packages/VariantVisualization/*/

#expose notebook and mysql port
EXPOSE 8888 3306
