#Functions recognized by Mathenize
sym = [ :sqrt, :+, :-, :/, :^, :tan, :*,
        :sin, :cos, :sincos, :sind, :cosd, 
        :tand, :sinh, :cosh, :tanh, :log, 
        :pi, :π, :\, :fma, :muladd, :inv, 
        :div, :÷, :fld, :cld, :mod, :eps,
        :rem2pi, :mod2pi, :divrem, :fldmod,
        :fld1, :mod1, ://, :rationalize, 
        :numerator, :denominator, :<<, :>>,
        :>>>, :bitrotate, :cmp, :complex,
        :~, :&, :|, :asin, :acos, :atan,
        :asind, :acosd, :atand, :sec, :csc,
        :cot, :secd, :cscd, :cotd, :asec,
        :acsc, :acot, :asecd, :acscd, :acotd,
        :sech, :csch, :coth, :asinh, :acosh,
        :atanh, :atan, :asech, :acsch, :acoth,
        :sinc, :cosc, :deg2rad, :hypot, :log2, 
        :log10, :log1p, :frexp, :exp, :exp2,
        :exp10, :ldexp, :modf, :expm1, :round,
        :ceil, :floor, :trunc, :unsafe_trunc,
        :min, :max, :minmax, :clamp, :clamp!,
        :abs, :abs2, :copysign, :sign, :signbit,
        :flipsign, :isqrt, :cbrt, :real, :imag, 
        :reim, :conj, :angle, :cis, :cispi,
        :binomial, :factorial, :gcd, :lcm, 
        :gcdx, :ispow2, :nextpow, :prevpow, 
        :nextprod, :invmod, :powermod, :ndigits, 
        :widemul, :evalpoly, :@evalpoly, :im]

#Iterate through expression to verify all items in it are valid symbols and operations.
function subtasking(math, tasks, sbtask)

    success = false
    for ñ in sbtask[1:tasks]
        if hastask(ñ)
            
            if ñ.args[1] in sym
                continue
            elseif ispermitted(ñ.args[1])
                continue
            else
                unknownmath(ñ)
            end
        elseif ispermitted(ñ)
            success = true
        else
            unknownmath(ñ)
        end
    end

    if success
        return Core.eval(Base.Math, math)
    end
    
end

#Check if value is a valid math operation, such as a mathematical function, number, vector, or matrix.
function ispermitted(tsk)

    if tsk in sym
        return true
    elseif tsk isa Number
        return true
    elseif tsk isa Expr && tsk isa Vector{Int} || tsk isa Vector{Int8} || tsk isa Vector{Int16} || tsk isa Vector{Int32} || tsk isa Vector{Int64} || tsk isa Vector{Int128}
        return true
    elseif tsk isa Expr && tsk isa Vector{Float16} || tsk isa Vector{Float32} || tsk isa Vector{Float64} 
        return true
    elseif tsk isa Expr && tsk isa Matrix{Int} || tsk isa Matrix{Int8} || tsk isa Matrix{Int16} || tsk isa Matrix{Int32} || tsk isa Matrix{Int64} || tsk isa Matrix{Int128}
        return true
    elseif tsk isa Expr && tsk isa Matrix{Float16} || tsk isa Matrix{Float32} || tsk isa Matrix{Float64}
        return true
    elseif tsk isa Expr && tsk isa Vector{Complex{Int}} || tsk isa Vector{Complex{Int8}} || tsk isa Vector{Complex{Int16}} || tsk isa Vector{Complex{Int32}} || tsk isa Vector{Complex{Int64}} || tsk isa Vector{Complex{Int128}}
        return true
    elseif tsk isa Expr && tsk isa Vector{ComplexF16} || tsk isa Vector{ComplexF32} || tsk isa Vector{ComplexF64}
        return true
    elseif tsk isa Expr && tsk.args[1] in sym
        return true
    else
        return false
    end
end

#Check if argument contains subarguments.
function hastask(sb)
    return hasproperty(sb, :args) ? true : false
end

#Error when given input contains an unknown operation.
function unknownmath(ñ)

    items = "Empy value."
    if hastask(ñ)
        items = "Contains $(ñ.args)"
    end

    @error("$(ñ) is not recognized as a valid math operation.\nType of value: $(typeof(ñ))\n └ $(items)")
    return nothing
end
