### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 00000000-0000-0000-0000-000000000001
md"""
# MyTemplate - Welcome Guide

Welcome to MyTemplate! This interactive notebook introduces you to the key concepts.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
md"""
## What is MyTemplate?

MyTemplate is a professional documentation template that combines:

- **Pluto Notebooks**: Interactive, reactive Julia notebooks
- **Genie Framework**: Fast web server for serving content
- **Documenter.jl**: Automatic API documentation generation

## Why use MyTemplate?

✨ Professional documentation site  
📚 Interactive examples  
🚀 Fast and easy to deploy  
🎨 Beautiful, responsive design  
"""

# ╔═╡ 00000000-0000-0000-0000-000000000003
md"""
## Key Features

### 1. Interactive Notebooks
Run code directly in your browser and see results instantly.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000004
# Simple interactive example
x = 5
y = 3
sum_xy = x + y

md"""
**Example:** $x + $y = $sum_xy
"""

# ╔═╡ 00000000-0000-0000-0000-000000000005
md"""
### 2. Reactive Cells

Change the values above and watch the result update automatically!
"""

# ╔═╡ 00000000-0000-0000-0000-000000000006
md"""
### 3. Data Visualization

Create beautiful plots and visualizations:
"""

# ╔═╡ 00000000-0000-0000-0000-000000000007
begin
    using Plots
    x = 0:0.01:2π
    y = sin.(x)
    plot(x, y, label="sin(x)", legend=:bottomright, size=(600, 400))
end

# ╔═╡ 00000000-0000-0000-0000-000000000008
md"""
## Getting Started

1. **Install**: Clone the repository and run `julia --project`
2. **Dependencies**: Run `] instantiate` 
3. **Start Server**: `using MyTemplate; MyTemplate.serve()`
4. **Explore**: Open http://localhost:8000

## Next Steps

- Read the [Getting Started Guide](./getting-started)
- Explore the [API Reference](./api)
- Check out more [Examples](./examples)

Happy learning! 🚀
"""

# ╔═╡ Cell order:
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
# ╟─00000000-0000-0000-0000-000000000003
# ╟─00000000-0000-0000-0000-000000000004
# ╟─00000000-0000-0000-0000-000000000005
# ╟─00000000-0000-0000-0000-000000000006
# ╟─00000000-0000-0000-0000-000000000007
# ╟─00000000-0000-0000-0000-000000000008
