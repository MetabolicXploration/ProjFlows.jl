## --.-..-..-- -- - - - . . .. .- - .- .-. .- . . .. -. - ..
datio(f::Function, s::Symbol, arg0, args...) = 
    datio(f, Val(s), arg0, args...)
datio(s::Symbol, arg0, args...) = 
    datio(Val(s), arg0, args...)

## --.-..-..-- -- - - - . . .. .- - .- .-. .- . . .. -. - ..
# TODO: think about hash version
# datio(::Val{:read}, fnarg0, fnargs...) = 
#     _datio(:read, projpath(fnarg0, fnargs...))
# datio(f::Function, ::Val{:read}, fnarg0, fnargs...) =
#     _datio(f, :read, projpath(fnarg0, fnargs...)) 

## --.-..-..-- -- - - - . . .. .- - .- .-. .- . . .. -. - ..
# read
# load + cache
# datio(::Val{:read}, fnarg0, fnargs...)
datio(::Val{:read}, fnarg0, fnargs...) = 
    _datio(:read, projpath(fnarg0, fnargs...))
# datio(::Function, ::Val{:read}, fnarg0, fnargs...) 
datio(f::Function, ::Val{:read}, fnarg0, fnargs...) =
    _datio(f, :read, projpath(fnarg0, fnargs...)) 

# write!
# always write, no cache
# datio(::Val{:write!}, dat::T, fnarg0, fnargs...) where T
datio(::Val{:write!}, dat::T, fnarg0, fnargs...) where T =
    _datio(:write!, dat, projpath(fnarg0, fnargs...))
# datio(f::Function, ::Val{:write!}, fnarg0, fnargs...)
datio(f::Function, ::Val{:write!}, fnarg0, fnargs...) = 
    _datio(f, :write!, projpath(fnarg0, fnargs...))

# get
# load | dflt & cache
# datio(f::Function, ::Val{:get}, fnarg0, fnargs...)
datio(f::Function, ::Val{:get}, fnarg0, fnargs...) =
    _datio(f, :get, projpath(fnarg0, fnargs...))
# datio(::Val{:get}, fnarg0, fnargs...)
datio(::Val{:get}, fnarg0, fnargs...) =
    _datio(:get, projpath(fnarg0, fnargs...))

# write & get!
# always write + cache
# datio(f::Function, ::Val{:wget!}, fnarg0, fnargs...)
datio(f::Function, ::Val{:wget!}, fnarg0, fnargs...) =
    _datio(f, :wget!, projpath(fnarg0, fnargs...))

# get!
# maybe write and always cache
# datio(f::Function, ::Val{:get!}, fnarg0, fnargs...)
datio(f::Function, ::Val{:get!}, fnarg0, fnargs...) =
    _datio(f, :get!, projpath(fnarg0, fnargs...))
 
# dry!
# only cache
# datio(f::Function, ::Val{:dry}, fnarg0, fnargs...)
datio(f::Function, ::Val{:dry}, fnarg0, fnargs...) = 
    _datio(f, :dry, projpath(fnarg0, fnargs...))

