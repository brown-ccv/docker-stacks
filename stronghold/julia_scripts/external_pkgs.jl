println("Python")
ENV["PYTHON"]=""
const external_pkgs = ["PyCall", "PyPlot", "Blosc", "ZMQ", "IJulia", "ScikitLearn", "Seaborn", "Pandas"]

# "RCall" Error: R_HOME not a directory
# "Seaborn" ERROR: UndefVarError: warn not defined
