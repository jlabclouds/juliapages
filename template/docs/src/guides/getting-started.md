---
title: Getting Started
description: Get up and running with TemplatePackage.jl in just a few minutes with easy installation and first steps
keywords: getting-started, installation, beginner, tutorial, setup
category: guides
order: 1
---

# Getting Started

Get up and running with TemplatePackage.jl in just a few minutes!

## Installation

### Option 1: Using the Package Manager (Recommended)

```julia
julia> using Pkg
julia> Pkg.add("TemplatePackage")
```

### Option 2: Development Installation

```bash
git clone https://github.com/username/TemplatePackage.jl.git
cd TemplatePackage.jl
julia --project
```

Then in Julia:

```julia
julia> ]
(@v1.10) pkg> dev .
```

## Your First Program

Create a new Julia file `demo.jl`:

```julia
using TemplatePackage

# Simple function call
println("Hello from TemplatePackage!")
result = basic_function(42)
println(result)
```

Run it:

```bash
julia demo.jl
```

Output:
```
Hello from TemplatePackage!
The answer is 42
```

## Basic Examples

### Example 1: Using Basic Functions

```julia
using TemplatePackage

# Call the basic function
answer = basic_function(123)
println(answer)  # Output: The answer is 123
```

### Example 2: Advanced Operations

```julia
using TemplatePackage

# Use advanced function with options
result = advanced_function(15, 25; verbose=true)
println(result)
```

Output:
```
Computing: 15 + 25 = 40
40
```

### Example 3: Data Processing

```julia
using TemplatePackage

# Process some data
measurements = [10.5, 12.3, 11.8, 13.2, 10.9]
stats = process_data(measurements)

println("Statistics:")
println("  Count: $(stats["count"])")
println("  Mean:  $(stats["mean"])")
println("  Min:   $(stats["min"])")
println("  Max:   $(stats["max"])")
```

Output:
```
Statistics:
  Count: 5
  Mean:  11.74
  Min:   10.5
  Max:   13.2
```

## Next Steps

Now that you're familiar with the basics:

1. **Explore more** - Check out the [Advanced Usage](../examples/advanced-usage.md) examples
2. **Learn the API** - Read the [API Reference](../api.md)
3. **Contribute** - See [CONTRIBUTING.md](https://github.com/username/TemplatePackage.jl/blob/main/CONTRIBUTING.md) to get involved

## Common Tasks

### Get Help on a Function

```julia
julia> using TemplatePackage
julia> ?basic_function
```

### Run Tests

```bash
julia> using Pkg
julia> Pkg.test("TemplatePackage")
```

### Check Version

```julia
julia> using Pkg
julia> Pkg.status("TemplatePackage")
```

## Troubleshooting

### Package Not Found

Make sure you've installed it correctly:

```julia
julia> using Pkg
julia> Pkg.add("TemplatePackage")
```

### Version Conflicts

If you encounter compatibility issues, try updating:

```julia
julia> using Pkg
julia> Pkg.update()
```

### Still Having Issues?

- Check [Installation Guide](installation.md) for detailed instructions
- Visit [FAQ](faq.md) for common questions
- Open an issue on [GitHub](https://github.com/username/TemplatePackage.jl/issues)

## Performance Tips

- TemplatePackage functions are optimized for Julia 1.10+
- For large datasets, use vectorized operations
- Enable inference mode for better performance on repeated calls

```julia
# Good performance
big_array = rand(10^6)
stats = process_data(big_array)

# Still good
for i in 1:1000
    result = basic_function(i)
end
```

---

**Next:** Learn more in the [Advanced Usage](../examples/advanced-usage.md) guide!
