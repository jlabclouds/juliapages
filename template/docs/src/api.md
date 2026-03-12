---
title: API Reference
description: Complete API documentation for all TemplatePackage.jl functions, types, and methods
keywords: api, reference, functions, documentation, guide
author: Template Contributors
toc-depth: 3
---

# API Reference

Complete API documentation for TemplatePackage.jl.

```@meta
CurrentModule = TemplatePackage
```

## Public Functions

### Core Functions

```@docs
basic_function
advanced_function
process_data
```

## Function Details

### `basic_function(x::Int)::String`

A simple demonstration function that processes an integer.

**Parameters:**
- `x::Int` - An integer input value

**Returns:**
- `String` - A formatted string containing the result

**Examples:**
```julia
julia> basic_function(42)
"The answer is 42"

julia> basic_function(0)
"The answer is 0"
```

---

### `advanced_function(x::Number, y::Number; verbose::Bool=false)::Number`

Performs mathematical operations on two numbers with optional verbose output.

**Parameters:**
- `x::Number` - First numeric input
- `y::Number` - Second numeric input

**Keyword Arguments:**
- `verbose::Bool` - Enable verbose output (default: `false`)

**Returns:**
- `Number` - Result of the operation

**Examples:**
```julia
julia> advanced_function(10, 20)
30

julia> advanced_function(3.14, 2.86)
6.0

julia> advanced_function(5, 15; verbose=true)
Computing: 5 + 15 = 20
20
```

**Performance Notes:**
- Type-stable for identical input types
- Efficient for both integers and floating-point numbers

---

### `process_data(data::Vector)::Dict`

Computes statistical summary of a data vector.

**Parameters:**
- `data::Vector` - Numeric vector to analyze

**Returns:**
- `Dict` - Dictionary with keys: `"count"`, `"mean"`, `"min"`, `"max"`

**Throws:**
- `ErrorException` - If input data is empty

**Examples:**
```julia
julia> process_data([1, 2, 3, 4, 5])
Dict{String, Any} with 4 entries:
  "count" => 5
  "mean"  => 3.0
  "min"   => 1
  "max"   => 5

julia> process_data([10.5, 20.5])
Dict{String, Any} with 4 entries:
  "count" => 2
  "mean"  => 15.5
  "min"   => 10.5
  "max"   => 20.5
```

**Error Handling:**
```julia
julia> process_data([])
ERROR: Input data cannot be empty
```

**Performance:**
- O(n) time complexity for n elements
- Single pass through the data

---

## Data Types

### Input Types

All functions accept standard Julia numeric types:
- `Int`, `Int32`, `Int64`, etc.
- `Float32`, `Float64`
- `BigInt`, `BigFloat`
- Any type supporting arithmetic operations

### Output Types

- `basic_function` returns `String`
- `advanced_function` returns result of addition (same type as inputs)
- `process_data` returns `Dict{String, Any}`

## Function Behaviors

### Type Promotion

When mixing input types, Julia auto-promotes:

```julia
advanced_function(10, 20.5)    # Result: Float64
advanced_function(10.5, 20)    # Result: Float64
```

### Edge Cases

```julia
# Zero values
advanced_function(0, 0)        # Returns 0

# Negative numbers
advanced_function(-10, 5)      # Returns -5

# Large numbers
advanced_function(10^18, 10^18) # Handles large integers

# Empty data
process_data([])               # Raises ErrorException
```

## Performance Characteristics

### Time Complexity

| Function | Complexity | Notes |
|----------|-----------|-------|
| `basic_function` | O(1) | String formatting |
| `advanced_function` | O(1) | Simple arithmetic |
| `process_data` | O(n) | Single pass, n = data length |

### Memory Complexity

| Function | Memory | Notes |
|----------|--------|-------|
| `basic_function` | O(1) | Output string size |
| `advanced_function` | O(1) | Single numeric result |
| `process_data` | O(1) | Returns fixed-size dict |

## Thread Safety

All functions are **thread-safe** and can be called from multiple threads simultaneously without special synchronization.

```julia
using Base.Threads

@threads for i in 1:1000
    process_data(rand(100))
end
```

## Version Compatibility

| Requirement | Minimum Version |
|------------|-----------------|
| Julia | 1.10 |
| TemplatePackage | 0.1.0 |

## Deprecations

Currently, there are no deprecated functions. All API elements are stable.

## Examples by Category

### Simple Operations

```julia
basic_function(42)
advanced_function(10, 20)
```

### Data Analysis

```julia
process_data([1, 2, 3, 4, 5])
```

### Error Handling

```julia
try
    process_data([])
catch e
    println("Error: $(e.msg)")
end
```

### Verbose Output

```julia
advanced_function(5, 15; verbose=true)
```

## Getting Help

For each function, you can access built-in help:

```julia
?basic_function
?advanced_function
?process_data
```

## Common Patterns

### Pattern: Safe Processing

```julia
function safe_process(data::Vector)
    isempty(data) && return nothing
    return process_data(data)
end
```

### Pattern: Batch Processing

```julia
function batch_analyze(datasets::Vector{Vector})
    map(process_data, datasets)
end
```

### Pattern: Conditional Logic

```julia
function analyze_with_threshold(data::Vector, threshold::Number)
    stats = process_data(data)
    return stats["mean"] > threshold ? "HIGH" : "LOW"
end
```

## See Also

- [Getting Started](guides/getting-started.md)
- [Examples](examples/basic-example.md)
- [Advanced Usage](examples/advanced-usage.md)

---

**Last Updated:** 2024
**Status:** Stable
