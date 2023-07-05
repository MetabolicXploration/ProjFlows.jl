"""
    give the error text as string
"""
function err_str(err; max_len = 10000)
    s = sprint(showerror, err, catch_backtrace())
    return length(s) > max_len ? s[1:max_len] * "\n[...]" : s
end

## ----------------------------------------------------------------------------
function _extract_dir(args...)
    isempty(args) && return ("", args)
    path = ""
    for (i, arg) in enumerate(args)
        !(arg isa Vector{<:AbstractString}) && return (path, args[i:end])
        for dir in arg
            path = joinpath(path, dir)
        end
    end
    return (path, tuple())
end

## ----------------------------------------------------------------------------
# Ploting
COLORS_ID = [:red :green :blue :orange :purple :brown :cyan :magenta :black :gray :pink :gold :olive :navy :teal :maroon :indigo :turquoise :violet :coral]
LINES_STYLES = [:solid, :dash, :dot, :dashdot, :dashdotdot]
MARKER_SHAPES = [:auto, :circle, :rect, :star5, :diamond, :hexagon, :cross, :xcross, :utriangle, :dtriangle, :rtriangle, :ltriangle, :pentagon, :heptagon, :octagon, :star4, :star6, :star7, :star8, :vline, :hline, :+, :x]

rand_color(n...) = rand(COLORS_ID, n...)
rand_line_style(n...) = rand(LINES_STYLES, n...)
rand_marker_shape(n...) = rand(MARKER_SHAPES, n...)
