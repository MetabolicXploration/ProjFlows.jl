using ProjFlows
using Test

@testset "ProjFlows.jl" begin
    # Write your tests here.
    include("save_load_tests.jl")
    include("utils_tests.jl")
end
