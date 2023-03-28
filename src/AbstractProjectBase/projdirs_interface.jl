# implement the methods for getting tree structures

# TODO: Make proper documentation

# To implement
# - projectdir
# - dotprojflow_dir
# - datdir
# - cachedir
# - plotsdir

dotprojflow_dir(p::AbstractProject) = joinpath(projectdir(p), ".projflow")

