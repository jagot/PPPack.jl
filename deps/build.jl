using BinDeps

@BinDeps.setup

libpppack = library_dependency("libpppack")

prefix = joinpath(BinDeps.depsdir(libpppack), "usr")
src_dir = joinpath(BinDeps.depsdir(libpppack), "src", "pppack")
build_dir = joinpath(BinDeps.depsdir(libpppack), "builds", "pppack")

provides(SimpleBuild,
         (@build_steps begin
	  `git submodule update --init --recursive`
          CreateDirectory(build_dir)
          @build_steps begin
          ChangeDirectory(build_dir)
          @build_steps begin
          `cmake -DCMAKE_INSTALL_PREFIX="$prefix" $src_dir`
          `make`
          `make install`
          end
          end
          end),
         libpppack)
@BinDeps.install Dict([(:libpppack, :_jl_libpppack)])
