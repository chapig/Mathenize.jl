# Mathenize

Small package to make it possible to perform math operations
from strings in the [Julia language](http://julialang.org/),
written by Luis C. Gómez.

Most math operations are possible, check [Mathematics - The Julia Language](https://docs.julialang.org/en/v1/base/math/#Mathematical-Functions) to check functions.

### 



### Installation and Usage

Use Julia 1.6.1 or above.

```@example
(@v1.6) pkg> add Mathenize
```

Displaying log info.
```julia
using Mathenize
x = calculate("sqrt(complex(-90)) + 10im", true)
```
Output:
```
┌ Info: -> sqrt(complex(-90)) + 10im <-
│  └Tasks: 3
│  └Any[:+, :(sqrt(complex(-90))), :(10im)]
│    └ Performing subtasks:
│     └ sqrt is a valid symbol | Belongs to: sqrt(complex(-90)) | Length: 1 - 2
│     └ complex is a valid Expression found in sym
│     └ complex(-90) is permitted | Belongs to: sqrt(complex(-90)) | Length: 2 - 2
│     └ * is a valid symbol | Belongs to: 10im | Length: 1 - 3
│     └ 10 is a valid number | Belongs to: 10im | Length: 2 - 3
│     └ im is a valid symbol | Belongs to: 10im | Length: 3 - 3
│     └ Subtasks done.
│     └ Checking if :Expr can be performed.
│
│ sqrt(complex(-90)) + 10im
└ └ :Expr parsed correctly.
0.0 + 19.486832980505138im
```
### Difference between parsing with Core.eval(Base.Math, :Expr) and Mathenize

#### Using Mathenize, the following input will result in:
```julia
x = calculate("for i in 1:10; print(i); end;")
```
```
ERROR: Error in Mathenize syntax. Check the log using calculate(math::String, true)
└ ->for i = 1:10
    #= none:1 =#
    print(i)
end is not recognized as a valid math operation.
 └ The input given is a Expr that contains Any[:(i = 1:10), quote
    #= none:1 =#
    print(i)
end]
```
#### Using Core.eval(Base.Math, :Expr)
```julia
Core.eval(Base.Math, Meta.parse("for i in 1:10; print(i); end;"))
> 12345678910
```

### Author
This package was written by Luis C. Gómez.
