using Pkg


deleteat!(DEPOT_PATH, 1:2)

"""
install_packages(pkgs)
Call `Pkg.add` and `using` on list of desired packages
"""
function install(pkgs)
    for pkg in pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")
        Pkg.add(pkg)
    end
end

"""
precompile()
Run `using` an all lists of packages
"""
function precompile(pkgs)
    failed_pkgs = Vector{String}()

    for pkg in pkgs
        println("--------------------------------")
        println("Using Package: ", pkg)
        println("--------------------------------")
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
