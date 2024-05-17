__PROJ = AbstractProject[]

function globproj()
    isempty(__PROJ) && error("Project not set!, see `globproj!`")
    first(__PROJ)
end

function globproj!(p::AbstractProject)
    empty!(__PROJ)
    push!(__PROJ, p)
    return p
end

function withproj(f::Function, p1::AbstractProject)
    p0 = globproj()
    globproj!(p1)
    ret = f()
    globproj!(p0)
    return ret
end