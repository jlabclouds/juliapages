# Examples

Practical examples demonstrating MyTemplate usage.

## Example 1: Data Visualization

Create interactive data visualizations with Pluto:

```julia
using Plots, StatsPlots

data = randn(100)
@df data density(:x)
```

See [visualization.pluto.jl](../pages/examples/visualization.pluto.jl).

## Example 2: Scientific Computation

Perform scientific calculations:

```julia
using LinearAlgebra

A = rand(5, 5)
eigvals(A)
```

## Example 3: Machine Learning

Build ML models:

```julia
using Flux

model = Chain(
    Dense(10, 32, relu),
    Dense(32, 10),
    softmax
)
```

## Example 4: Web API Development

Create RESTful APIs:

```julia
# In src/routes.jl
route("/api/users/:id", method=GET) do
    user_id = payload(:id)
    # Fetch user data
    Genie.Responses.json(user_data)
end
```

## Example 5: Data Analysis

Analyze datasets interactively:

```julia
using DataFrames, CSV

df = CSV.read("data.csv", DataFrame)
describe(df)
```

See the `pages/examples/` directory for complete notebook examples.
