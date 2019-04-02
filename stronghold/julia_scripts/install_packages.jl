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
clone(pkgs)
Call `Pkg.clone` on list of desired packages
"""
function clone(pkgs::Array)
    for pkg in pkgs
        println("--------------------------------")
        println("Package: ", pkg)
        println("--------------------------------")
        Pkg.clone("https://github.com/$pkg")
    end
end

"""
precompile()
Run `using` an all lists of packages
"""
function precompile(pkgs)
    failed_pkgs = Vector{String}()

    for p in pkgs
        try
            pkg = split(p, "/")[2]
        catch
            pkg = p
        println("--------------------------------")
        println("Using Package: ", pkg)
        println("--------------------------------")
        try
            pkgsym = Symbol(pkg)
            eval(:(using $pkgsym))
        catch
            warn("using pkg failed")
            push!(failed_pkgs, p)
        end
    end
    println("--------------------------------")
    println("Failed packages: ", length(failed_pkgs))
    map(x->println(x), failed_pkgs)
    println("--------------------------------")

    return failed_pkgs
end

function precompile(pkgs)
    failed_pkgs = Vector{String}()

    for pkg in pkgs
        try
            pkg = split(pkg, "/")[2]
        catch
            pkg = pkg
        end
        println(pkg)
    end
end
