using Pkg


"""
install_packages(pkgs)
Call `Pkg.add` and `using` on list of desired packages
"""
function install(pkgs)

    failed_pkgs = Vector{String}()

    for pkg in pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")

        try
            println("* Adding")
            Pkg.add(pkg)
        catch
            warn("Pkg.add failed")
            push!(failed_pkgs, pkg)
            continue
        end

    end

    println("--------------------------------")
    println("Failed packages: ", length(failed_pkgs))
    map(x->println(x), failed_pkgs)
    println("--------------------------------")

    return failed_pkgs
end

"""
precompile()
Run `using` an all lists of packages
"""
function precompile(pkgs)
    for pkg in pkgs
        try
            pkgsym = Symbol(pkg)
            eval(:(using $pkgsym))
        catch
            warn("using pkg failed")
            push!(failed_pkgs, pkg)
        end
    end
    println("--------------------------------")
    println("Failed packages: ", length(failed_pkgs))
    map(x->println(x), failed_pkgs)
    println("--------------------------------")
    
    return failed_pkgs
end

const base_pkgs = [ "MySQL",
                    "ClassImbalance",
                    "Clustering",
                    "Compat",
                    "CSV",
                    "DataFrames",
                    "DecisionTree",
                    "EzXML",
                    "Flux",
                    "GLM",
                    "HTTP",
                    "HypothesisTests",
                    "JLD",
                    "JLD2",
                    "JSON",
                    "JuliaDB",
                    "LightXML",
                    "MixedModels",
                    "Revise",
                    "ROCAnalysis",
                    "StatsBase",
                    "SQLite",
                    "TextAnalysis",
                    "Query",
                    "WordTokenizers"
                    ]


const plotting_pkgs = [ "VegaLite", "PlotlyJS", "Gadfly"]

# install(base_pkgs)
# precompile(base_pkgs)
