projectdir(p0::Project0) = p0.root

projectdir(p0::Project0, arg, args...) = dfname([projectdir(p0)], arg, args...)

devdir(p0::Project0, args...) = dfname([projectdir(p0), "dev"], args...)
srcdir(p0::Project0, args...) = dfname([projectdir(p0), "src"], args...)
scriptsdir(p0::Project0, args...) = dfname([projectdir(p0), "scripts"], args...)
plotsdir(p0::Project0, args...) = dfname([projectdir(p0), "plots"], args...)
papersdir(p0::Project0, args...) = dfname([projectdir(p0), "papers"], args...)

datdir(p0::Project0, args...) = dfname([projectdir(p0), "data"], args...)
    rawdir(p0::Project0, args...) = dfname([projectdir(p0), "data", "raw"], args...)
    procdir(p0::Project0, args...) = dfname([projectdir(p0), "data", "processed"], args...)
    cachedir(p0::Project0, args...) = dfname([projectdir(p0), "data", "cache"], args...)

