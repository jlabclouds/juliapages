---
title: Basic Examples
description: Learn the fundamentals of TemplatePackage through practical examples and code snippets
keywords: examples, basic, tutorial, getting-started, code-samples
category: examples
order: 1
---

# Basic Examples

Learn the fundamentals of TemplatePackage through practical examples.

## Example 1: Simple String Generation

The simplest way to use TemplatePackage:

```julia
using TemplatePackage

# Generate a formatted string
result = basic_function(42)
println(result)
```

Output:
```
The answer is 42
```

You can use any integer:

```julia
basic_function(0)      # "The answer is 0"
basic_function(100)    # "The answer is 100"
basic_function(-5)     # "The answer is -5"
```

## Example 2: Adding Numbers

Use the advanced function for mathematical operations:

```julia
using TemplatePackage

# Simple addition
sum1 = advanced_function(10, 20)
println(sum1)  # Output: 30

# With floats
sum2 = advanced_function(3.14, 2.86)
println(sum2)  # Output: 6.0
```

### With Verbose Output

Enable verbose mode to see the calculation:

```julia
result = advanced_function(15, 25; verbose=true)
```

Output:
```
Computing: 15 + 25 = 40
40
```

## Example 3: Processing Data

Analyze a dataset:

```julia
using TemplatePackage

# Create sample data
temperatures = [20.5, 21.3, 19.8, 22.1, 20.9]

# Get statistics
stats = process_data(temperatures)

# Access the results
println("Count: $(stats["count"])")     # Count: 5
println("Mean:  $(stats["mean"])")      # Mean:  20.92
println("Min:   $(stats["min"])")       # Min:   19.8
println("Max:   $(stats["max"])")       # Max:   22.1
```

### Complete Statistics Extraction

```julia
using TemplatePackage

data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
stats = process_data(data)

@printf "Dataset Statistics\n"
@printf "=" ^ 25
printf "\n"
@printf "Count:  %d\n" stats["count"]
@printf "Mean:   %.2f\n" stats["mean"]
@printf "Min:    %d\n" stats["min"]
@printf "Max:    %d\n" stats["max"]
```

## Example 4: Working with Different Data Types

### Integer Data

```julia
using TemplatePackage

int_data = [10, 20, 30, 40, 50]
result = process_data(int_data)
println(result["mean"])  # 30.0
```

### Float Data

```julia
using TemplatePackage

float_data = [1.5, 2.5, 3.5, 4.5, 5.5]
result = process_data(float_data)
println(result["mean"])  # 3.5
```

### Mixed Numeric Data

```julia
using TemplatePackage

mixed_data = [10, 20.5, 30, 40.5, 50]
result = process_data(mixed_data)
println(result["mean"])  # 30.2
```

## Example 5: Error Handling

TemplatePackage includes built-in error handling:

```julia
using TemplatePackage

# This will raise an error
try
    result = process_data([])
catch e
    println("Error: $(e.msg)")
    # Handle the error appropriately
end
```

## Example 6: Chaining Operations

Combine functions for more complex tasks:

```julia
using TemplatePackage

# Process data and use the results
measurements = [100.2, 105.5, 102.3, 101.8, 103.7]
stats = process_data(measurements)

# Combine results
mean_value = stats["mean"]
description = basic_function(Int(round(mean_value)))
println(description)
```

## Example 7: Loops and Iteration

Use TemplatePackage in loops:

```julia
using TemplatePackage

for i in 1:5
    result = advanced_function(i, i+1)
    println("$i + $(i+1) = $result")
end
```

Output:
```
1 + 2 = 3
2 + 3 = 5
3 + 4 = 7
4 + 5 = 9
5 + 6 = 11
```

## Example 8: Working with Arrays

Process multiple datasets:

```julia
using TemplatePackage

datasets = [
    [1, 2, 3],
    [10, 20, 30],
    [100, 200, 300]
]

for (i, data) in enumerate(datasets)
    stats = process_data(data)
    println("Dataset $i - Mean: $(stats["mean"])")
end
```

Output:
```
Dataset 1 - Mean: 2.0
Dataset 2 - Mean: 20.0
Dataset 3 - Mean: 200.0
```

## Tips and Tricks

### Performance

For large datasets, operations are optimized:

```julia
using TemplatePackage

large_dataset = rand(1_000_000)
@time stats = process_data(large_dataset)
```

### Type Stability

TemplatePackage functions maintain type stability:

```julia
using TemplatePackage

# Results maintain expected types
int_result = advanced_function(5, 10)          # Int result
float_result = advanced_function(5.0, 10)      # Float result
```

### Variable Scoping

Remember Julia's scoping rules:

```julia
using TemplatePackage

function my_analysis()
    data = [1, 2, 3, 4, 5]
    stats = process_data(data)
    return stats
end

result = my_analysis()
```

## Common Patterns

### Pattern 1: Batch Processing

```julia
using TemplatePackage

function batch_process(datasets::Vector)
    results = []
    for data in datasets
        push!(results, process_data(data))
    end
    return results
end
```

### Pattern 2: Conditional Processing

```julia
using TemplatePackage

function process_if_valid(data::Vector)
    if !isempty(data)
        return process_data(data)
    else
        return nothing
    end
end
```

### Pattern 3: Data Pipeline

```julia
using TemplatePackage

# Create a processing pipeline
function pipeline(data::Vector)
    # Step 1: Process data
    stats = process_data(data)
    
    # Step 2: Generate description
    mean_int = Int(round(stats["mean"]))
    description = basic_function(mean_int)
    
    # Step 3: Return results
    return (stats=stats, description=description)
end
```

---

**Next:** Explore [Advanced Usage](advanced-usage.md) or check the [API Reference](../api.md)!
