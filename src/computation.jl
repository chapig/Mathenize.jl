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
        :widemul, :evalpoly, :@evalpoly, :im, 
        :vcat, :hcat]

#Iterate through expression to verify all items in it are valid symbols and operations.
function subtasking(math, tasks, sbtask, LOG_INFO)

    success = false
    for ñ in sbtask[1:tasks]

        if hastask(ñ)

            for i in 1:length(ñ.args)

                if ñ.args[i] in sym
                    success = true
                    continue
                elseif ñ.args[i] isa Number
                    success = true
                    continue
                elseif ispermitted(ñ.args[i], LOG_INFO)
                    success = true
                    continue
                else
                    success = false
                    unknownmath(ñ)
                    break
                end
            end
                
        elseif ispermitted(ñ, LOG_INFO) 
            success = true
        else 
            unknownmath(ñ)
            success = false
            break
        end
    end

    push!(LOG_INFO, "    Subtasks were all read\n(...) Checking if expression was parsed and can be computed")
    if success
        push!(LOG_INFO, "! Expression was parsed and computed succesfully\n")
        return Core.eval(Base.Math, math)
    else
        push!(LOG_INFO, "! Expression was not parsed succesfully\n")
        return nothing
    end
    
end

#Check if value is a valid math operation, such as a mathematical function, number, vector, or matrix.
function ispermitted(tsk, LOG_INFO)

    push!(LOG_INFO, "    └ -> $(tsk) is being checked, its type is: $(typeof(tsk))")
    if tsk in sym 
        push!(LOG_INFO, "        └ $(tsk) is permitted that belongs to: $(tsk)")
        return true 
    elseif tsk isa Number 
        push!(LOG_INFO, "        └ $(tsk) is permitted that belongs to: $(tsk)")
        return true
    elseif tsk isa Expr && hasproperty(tsk, :head) && tsk.head == :hcat || tsk.head == :vcat
        push!(LOG_INFO, "        └ $(tsk) is a valid matrix that belongs to: $(tsk)")
        return true
    elseif tsk isa Expr && hasproperty(tsk, :head) && tsk.head == :vect
        push!(LOG_INFO,"        └ $(tsk) is a valid vector that belongs to: $(tsk)")
        return true
    elseif tsk isa Expr && tsk.args[1] in sym
        push!(LOG_INFO,"        └ $(tsk.args[1]) is a valid Expression found in sym that belongs to: $(tsk)")
        return true
    else
        push!(LOG_INFO, "       └ $(tsk) was not recognized")
        unknownmath(tsk)
        return false
    end
end

#Check if argument contains subarguments.
function hastask(sb)
    return hasproperty(sb, :args) ? true : false
end

#Error when given input contains an unknown operation.
function unknownmath(ñ)

    items = "and is an empty value"
    if hastask(ñ) items = "that contains $(ñ.args)" end
    error("$(ñ) is not recognized as a valid math operation. $(ñ) is a $(typeof(ñ)) $(items)")
    return nothing

end
