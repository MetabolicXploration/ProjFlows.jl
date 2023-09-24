_pidfile(p::AbstractProject) = joinpath(dotprojflow_dir(p), "p.pidfile")
_getlock(p::AbstractProject) = get!(() -> SimpleLockFiles(_pidfile(p)), p.extras, "_lock")
_setlock!(p::AbstractProject, lk) = setindex!(p.extras, lk, "_lock")

import Base.lock
function Base.lock(f::Function, p::AbstractProject; kwargs...) 
    lk = _getlock(p)
    isnothing(lk) && return f() # ignore locking
    lock(f, lk, kwargs...)
end
function Base.lock(p::AbstractProject; kwargs...) 
    lk = _getlock(p)
    isnothing(lk) && return # ignore locking 
    lock(lk, kwargs...)
    return p
end

import Base.islocked
function Base.islocked(p::AbstractProject) 
    lk = _getlock(p)
    isnothing(lk) && return false
    return islocked(lk)
end

function Base.unlock(p::AbstractProject; force = false) 
    lk = _getlock(p)
    isnothing(lk) && return
    return unlock(lk; force)
end
    
