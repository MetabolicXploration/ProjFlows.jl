let
    P = Project0(ProjFlows)
    globproj!(P)
    fn_args = (["dev"], "test", ".jls")
    fn = projpath(fn_args...)
    try
        # write
        # always write, no cache
        ref = datio(:write!, fn_args...) do
            11
        end
        @test isempty(ref.cache)
        @test ref[] == 11
        @test ref[] == 11
        
        # read
        # load + cache
        ref = datio(:read, fn_args...) do
            12
        end
        @test !isempty(ref.cache)
        @test ref[] == 11
        @test ref[] == 11
        
        # get
        # load | dflt & cache
        ref = datio(:get, fn_args...) do
            18
        end
        @test !isempty(ref.cache)
        @test ref[] == 11
        @test ref[] == 11
        rm(fn; force = true)
        @test !isfile(fn)
        # load | dflt & cache
        ref = datio(:get, fn_args...) do
            18
        end
        @test !isempty(ref.cache)
        @test isempty(ref.file)
        @test ref[] == 18
        
        # wget!
        # always write + cache
        ref = datio(:wget!, fn_args...) do
            20
        end
        @test !isempty(ref.cache)
        @test !isempty(ref.file)
        @test ref[] == 20
        @test ref[] == 20
        

        # get!
        # maybe write and always cache
        ref = datio(:get!, fn_args...) do
            25
        end
        @test !isempty(ref.cache)
        @test !isempty(ref.file)
        @test ref[] == 20
        @test ref[] == 20
        rm(fn; force = true)
        ref = datio(:get!, fn_args...) do
            123
        end
        @test !isempty(ref.cache)
        @test !isempty(ref.file)
        @test ref[] == 123
        @test ref[] == 123

        # dry
        # maybe write and always cache
        ref = datio(:dry, fn_args...) do
            99
        end
        @test !isempty(ref.cache)
        @test isempty(ref.file)
        @test ref[] == 99

    finally
        rm(fn; force = true)
    end
end
