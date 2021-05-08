"""
The Mathenize module exists mainly to make math calculations in
strings.
"""
module Mathenize
export calculate
include("computation.jl")

"""
    calculate(math::String, print_info::Bool=false)

Return calculated value(s) in a string. 

# Arguments
- `math::String` Math operation.
- `print_info::Bool` Shows log of what happened during the calculation.

# Examples
```julia-repl
julia> calculate("sqrt(complex(-90)) + 10im")
0.0 + 19.486832980505138im
```

"""
function calculate(math::String, print_info::Bool=false)

    math = Meta.parse(math)
    hasproperty(math, :args) ? tasks = length(math.args) : tasks = 0
    
    #Adding to log info.
    LOG_INFO = []
    push!(LOG_INFO, "-> $(math) <- \n └Tasks: $(tasks)\n └$(hasproperty(math, :args) ? math.args : "Empty")")

    if tasks >= 1
        push!(LOG_INFO, "   └ Performing subtasks:")
        r = subtasking(math, tasks, math.args, LOG_INFO, print_info)
    elseif math isa Number
        push!(LOG_INFO, "   └$(math) is a number")
        r = math
    elseif math in sym
        push!(LOG_INFO, "   └$(math) is a valid symbol")
        r = Core.eval(Base.Math, math)
    elseif tasks == 1 && ispermitted(math, LOG_INFO)
        push!(LOG_INFO, "   └$(math) is a valid a permitted number or expression")
        r = Core.eval(Base.Math, math)
    else
        r = nothing
        unknownmath(math, LOG_INFO, print_info)
    end


    if print_info == true
        @info join(LOG_INFO, "\n")
    end

    return r #Return result

end 
end #End module
