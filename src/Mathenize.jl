"""
The Mathenize module exists mainly to make math calculations in
strings.
"""
module Mathenize
export calculate
include("computation.jl")

"""
    calculate(math::String)

Return calculated value(s) in a string. 

# Arguments
- `math::String`: Math operation.

# Examples
```julia-repl
julia> calculate("sqrt(complex(-90)) + 10im")
0.0 + 19.486832980505138im
```

"""
function calculate(math::String)

    math = Meta.parse(math)
    hasproperty(math, :args) ? tasks = length(math.args) : tasks = 0
    if tasks >= 1
        subtasking(math, tasks, math.args)
    elseif math isa Number
        return math
    elseif math in sym
        return Core.eval(Base.Math, math)
    elseif tasks == 1 && ispermitted(math)
        return Core.eval(Base.Math, math)
    else
        unknownmath(math)
    end

end
end #End module
