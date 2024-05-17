import Base.rm
Base.rm(ref::FileRef; kwargs...) = rm(ref.file; kwargs...)

import Base.isfile
Base.isfile(ref::FileRef) = isfile(ref.file)

import Base.empty!
Base.empty!(ref::FileRef) = empty!(ref.cache)

import Base.getindex
function Base.getindex(r::FileRef{T})::T where T
    isempty(r.cache) && return __read(r.file)
    # if cached return and empty
    _dat = first(r.cache)
    empty!(r.cache)
    return _dat
end

import Base.show
function Base.show(io::IO, ref::FileRef{T}) where T
    println(io, "FileRef", "{", T, "}")
    println(io, "   file: ", ref.file)
    print(io, "   has_cache: ", !isempty(ref.cache))
end
