FROM browndatasci/julia_base:9746edf

MAINTAINER Stronghold Help <stronghold-help@brown.edu>


COPY julia_scripts/datasci_pkgs.jl /tmp/
RUN julia -e 'using Pkg; include("/tmp/install_packages.jl"); include("/tmp/datasci_pkgs.jl"); Pkg.update(); install(datasci_pkgs)'

#expose notebook and mysql port
EXPOSE 8888 3306

COPY entrypoint.sh /tmp/
ENTRYPOINT ["/tmp/entrypoint.sh"]
