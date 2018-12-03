println("Python")
println(ENV["PYTHON"])
const external_pkgs = ["PyCall", "PyPlot", "IJulia", "ScikitLearn", "TensorFlow"]

# "RCall" Error: R_HOME not a directory
# "Seaborn" ERROR: UndefVarError: warn not defined