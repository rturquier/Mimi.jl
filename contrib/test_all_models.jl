# This script runs the tests for all models that are known to us. For 
# registered models it will use the latest tagged version, for all other
# models it will use the latest `master` branch version.
#
# The script assumes that Mimi is deved into ~/.julia/dev/Mimi, and will
# run the tests with the version of Mimi that is in that location.
#
# To run the script, simply call it via
#
#   julia --color=yes test_all_models.jl
#

# should locally also test 
#    - MimiIWG (can't pass on CI because of local registry)
#    - MimiDICE2016R2 (not all tests pass, but check for new failures)

packages_to_test = [
    "MimiDICE2010" => ("https://github.com/anthofflab/MimiDICE2010.jl", "master"), # fails because need to use new DataFrames syngax
    "MimiDICE2013" => ("https://github.com/anthofflab/MimiDICE2013.jl", "master"), # fails because need to use new DataFrames syngax
    "MimiDICE2016" => ("https://github.com/AlexandrePavlov/MimiDICE2016.jl", "master"),
    "MimiRICE2010" => ("https://github.com/anthofflab/MimiRICE2010.jl", "master"), 
    "MimiFUND" => ("https://github.com/fund-model/MimiFUND.jl", "mcs"), # note here we use the mcs branch 
    "MimiPAGE2009" => ("https://github.com/anthofflab/MimiPAGE2009.jl", "mcs"), # note here we use the mcs branch 
    "MimiPAGE2020" => ("https://github.com/lrennels/MimiPAGE2020.jl", "mcs"), # note using lrennels fork mcs branch, and testing this takes a LONG time :) 
    "MimiSNEASY" => ("https://github.com/anthofflab/MimiSNEASY.jl", "master"),
    "MimiFAIR" => ("https://github.com/anthofflab/MimiFAIR.jl", "master"),
    "MimiMAGICC" => ("https://github.com/anthofflab/MimiMAGICC.jl", "master"),
    "MimiHector" => ("https://github.com/anthofflab/MimiHector.jl", "master")
]

using Pkg

mktempdir() do folder_name
    pkg_that_errored = []
    Pkg.activate(folder_name)

    Pkg.develop(PackageSpec(path=joinpath(@__DIR__, "..")))

    Pkg.add([i isa Pair ? PackageSpec(url=i[2][1], rev=i[2][2]) : PackageSpec(i) for i in packages_to_test])

    Pkg.resolve()

    for pkg_info in packages_to_test
        pkg = pkg_info isa Pair ? pkg_info[1] : pkg_info
        @info "Now testing $pkg."
        try
            Pkg.test(PackageSpec(pkg))
        catch err
            push!(pkg_that_errored, pkg)
        end
    end

    println()
    println()
    println()

    println("The following packages errored:")
    for p in pkg_that_errored
        println(p)
    end
    
end

