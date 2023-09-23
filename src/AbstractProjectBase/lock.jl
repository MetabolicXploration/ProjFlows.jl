_pidfile(p::AbstractProject) = joinpath(dotprojflow_dir(p), "p.pidfile")
getlock(p::AbstractProject) = get!(() -> _pidfile(p), p.extras, "_getlock")
setlock!(p::AbstractProject, lock) = setindex!(p.extras, lock, "_getlock")
setlock!(p::AbstractProject) = setlock!(p, _pidfile(p))

function _isvalid_pidfile(lkf)
    pid, host, _ = Pidfile.parse_pidfile(lkf)
    return Pidfile.isvalidpid(host, pid)
end

function _its_mypid(lkf)
    pid, host, _ = Pidfile.parse_pidfile(lkf)
    Pidfile.isvalidpid(host, pid) || return false
    return getpid() == Int(pid)
end


import Base.lock
function Base.lock(f::Function, p::AbstractProject; kwargs...) 
    lkf = getlock(p)
    isnothing(lkf) && return f() # ignore locking
    mkpath(dirname(lkf))
    _its_mypid(lkf) && return f()
    lk = mkpidlock(lkf; kwargs...) 
    try
        p.extras["_Pidfile.LockMonitor"] = lk
        return f()
    finally
        close(lk)
    end
end
function Base.lock(p::AbstractProject; kwargs...) 
    lkf = getlock(p)
    isnothing(lkf) && return # ignore locking 
    mkpath(dirname(lkf))
    _its_mypid(lkf) && return get(p.extras, "_Pidfile.LockMonitor", nothing)
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
    # check others
    return _isvalid_pidfile(lkf)
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
    