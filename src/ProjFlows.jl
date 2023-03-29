# TODO: Wait for 'DataFileNames' update to add a DataFileNamer object per project

# TODO: Think on a WIP feature

# TODO: remove the dependencies on DrWatson (currently using only the tag feature)

module ProjFlows

    import DrWatson
    import Logging
    import Logging: SimpleLogger, global_logger, with_logger
    import Serialization: serialize, deserialize
    import FileIO
    import Requires: @require
    import Pkg
    using FilesTreeTools
    using ExtractMacro
    using Base.Threads
    using DataFileNames

    #! include .
    
    #! include Types
    include("Types/AbtractProjects.jl")
    include("Types/DrWatsonProject.jl")
    include("Types/Project0s.jl")
    
    #! include AbstractProjectBase
    include("AbstractProjectBase/base.jl")
    include("AbstractProjectBase/extras_interface.jl")
    include("AbstractProjectBase/projdirs_interface.jl")
    include("AbstractProjectBase/save_load.jl")
    
    #! include Utils
    include("Utils/_io_print.jl")
    include("Utils/exportall.jl")
    include("Utils/extras_interface.jl")
    include("Utils/fileid.jl")
    include("Utils/group_files.jl")
    include("Utils/quickactivate.jl")
    include("Utils/save_load.jl")
    include("Utils/sfig_sgif.jl")
    include("Utils/utils.jl")

    #! include Project0Base
    include("Project0Base/projdirs_interface.jl")
    include("Project0Base/save_load.jl")

    @_exportall_non_underscore()

    function __init__()
        @require Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80" begin
            import ImgTools
        end
    end

end