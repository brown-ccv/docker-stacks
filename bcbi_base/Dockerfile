FROM jupyter/datascience-notebook:14fdfbf9cfc1

# Add more julia packages
RUN julia -e 'import Pkg; Pkg.add(Pkg.PackageSpec(url="https://github.com/bcbi/BCBI_base.jl.git", rev="master"))'

CMD [ "/bin/bash" ]