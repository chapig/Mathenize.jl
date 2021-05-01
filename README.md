# Mathenize

Small package to make it possible to perform math operations
from strings in the [Julia language](http://julialang.org/),
written by Luis C. Gómez.

Most math operations are possible, check [Mathematics - The Julia Language](https://docs.julialang.org/en/v1/base/math/#Mathematical-Functions) to check functions.

# Usage

```julia
include("Mathenize.jl")
using .Mathenize
x = calculate("sqrt(complex(-90))+pi")
> 3.141592653589793 + 9.486832980505138im
```

# Author
This package was written by Luis C. Gómez.
