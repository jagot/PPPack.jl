module PPPack

include("../deps/deps.jl")

function interv(xt::Vector{Float32},
                lxt::Integer, x::Float32,
                left::Integer,mflag::Integer)
    left = Int32[left]
    mflag = Int32[mflag]
    ccall((:interv_, _jl_libpppack),
          Void,
          (Ref{Float32}, Ref{Int32}, Ref{Float32}, Ref{Int32}, Ref{Int32}),
          xt, Int32(lxt), x, left, mflag)
    left[1],mflag[1]
end

function bsplvb(t::Vector{Float32}, jhigh::Integer, index::Integer,
                  x::Float32, left::Integer, biatx::AbstractVector{Float32})
    ccall((:bsplvb_, _jl_libpppack),
          Void,
          (Ref{Float32}, Ref{Int32}, Ref{Int32}, Ref{Float32}, Ref{Int32}, Ref{Float32}),
          t, Int32(jhigh), Int32(index), x, Int32(left), biatx)
end

function bsplvd(t::Vector{Float32}, k::Integer, x::Float32,
                left::Integer, a::Matrix{Float32},
                dbiatx::Matrix{Float32},
                nderiv::Integer)
    ccall((:bsplvd_, _jl_libpppack),
          Void,
          (Ref{Float32}, Ref{Int32}, Ref{Float32},
           Ref{Int32}, Ref{Float32},
           Ref{Float32},
           Ref{Int32}),
          t, Int32(k), x, Int32(left), a, dbiatx, nderiv)
end

pppbindir = abspath(joinpath(dirname(_jl_libpppack), "../../builds/pppack/bin"))
example(exe) = `$(joinpath(pppbindir, exe))`

export interv, bsplvb, bsplvd

end # module
