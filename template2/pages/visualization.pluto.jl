### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 00000000-0000-0000-0000-000000000001
md"""
# Data Visualization Example

Explore interactive data visualization with Pluto and MyTemplate.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
begin
    using Plots
    using StatsPlots
    using Random
    using Distributions
    
    Random.seed!(42)
end

# ╔═╡ 00000000-0000-0000-0000-000000000003
md"""
## Random Data Generation

Let's create some sample data to visualize:
"""

# ╔═╡ 00000000-0000-0000-0000-000000000004
# Generate random data
n_samples = 1000
data = randn(n_samples)

md"""
Generated $n_samples data points with normal distribution.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000005
md"""
## Visualization 1: Histogram
"""

# ╔═╡ 00000000-0000-0000-0000-000000000006
histogram(data, title="Distribution of Random Data", xlabel="Value", ylabel="Frequency", legend=false)

# ╔═╡ 00000000-0000-0000-0000-000000000007
md"""
## Visualization 2: Density Plot
"""

# ╔═╡ 00000000-0000-0000-0000-000000000008
density(data, title="Density Plot", xlabel="Value", ylabel="Density", legend=false, fillalpha=0.7)

# ╔═╡ 00000000-0000-0000-0000-000000000009
md"""
## Visualization 3: Multiple Series
"""

# ╔═╡ 00000000-0000-0000-0000-000000000010
begin
    x = 0:0.01:4π
    y1 = sin.(x)
    y2 = cos.(x)
    
    plot(x, y1, label="sin(x)", linewidth=2)
    plot!(x, y2, label="cos(x)", linewidth=2)
    
    xlabel!("x")
    ylabel!("y")
    title!("Trigonometric Functions")
end

# ╔═╡ 00000000-0000-0000-0000-000000000011
md"""
## Interactive Statistics

Calculate summary statistics:
"""

# ╔═╡ 00000000-0000-0000-0000-000000000012
begin
    using Statistics
    
    stats = Dict(
        "Mean" => mean(data),
        "Std Dev" => std(data),
        "Min" => minimum(data),
        "Max" => maximum(data),
        "Median" => median(data)
    )
    
    md"""
    | Statistic | Value |
    |-----------|-------|
    | Mean | $(round(stats["Mean"], digits=4)) |
    | Std Dev | $(round(stats["Std Dev"], digits=4)) |
    | Min | $(round(stats["Min"], digits=4)) |
    | Max | $(round(stats["Max"], digits=4)) |
    | Median | $(round(stats["Median"], digits=4)) |
    """
end

# ╔═╡ Cell order:
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
# ╟─00000000-0000-0000-0000-000000000003
# ╟─00000000-0000-0000-0000-000000000004
# ╟─00000000-0000-0000-0000-000000000005
# ╟─00000000-0000-0000-0000-000000000006
# ╟─00000000-0000-0000-0000-000000000007
# ╟─00000000-0000-0000-0000-000000000008
# ╟─00000000-0000-0000-0000-000000000009
# ╟─00000000-0000-0000-0000-000000000010
# ╟─00000000-0000-0000-0000-000000000011
# ╟─00000000-0000-0000-0000-000000000012
