# The default project layout
struct Project0 <: AbstractProject
    
    root::String
    extras::Dict

    Project0(root::AbstractString) = new(root, Dict())
end
