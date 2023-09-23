_pidfile(p::AbstractProject) = joinpath(dotprojflow_dir(p), "p.pidfile")
getlock(p::AbstractProject) = get!(() -> _pidfile(p), p.extras, "_getlock")
setlock!(p::AbstractProject, lock) = setindex!(p.extras, lock, "_getlock")
setlock!(p::AbstractProject) = setlock!(p, _pidfile(p))

import Base.lock
function Base.lock(f::Function, p::AbstractProject; kwargs...) 
    lkf = getlock(p)
    isnothing(lkf) && return f() # ignore locking
    mkpath(dirname(lkf))
    return mkpidlock(f, lkf; kwargs...)
end
function Base.lock(p::AbstractProject; kwargs...) 
    lkf = getlock(p)
    isnothing(lkf) && return # ignore locking 
    mkpath(dirname(lkf))
    lk = mkpidlock(lkf; kwargs...)
    p.extras["_Pidfile.LockMonitor"] = lk
    return p
end

import Base.islocked
function Base.islocked(p::AbstractProject) 
    lkf = getlock(p)
    isnothing(lkf) && return false # ignore locking 
    # check mine
    lk = get(p.extras, "_Pidfile.LockMonitor", nothing)
    !isnothing(lk) && isopen(lk.fd) && return true 
    # check other
    lk = Pidfile.tryopen_exclusive(lkf)
    isnothing(lk) && return true
    close(lk)
    return false
end

import Base.unlock
function Base.unlock(p::AbstractProject; force = false) 
    lkf = getlock(p)
    isnothing(lkf) && return # ignore locking 
    force && rm(lkf; force)
    lk = get(p.extras, "_Pidfile.LockMonitor", nothing)
    isnothing(lk) && return 
    close(lk)
end
    