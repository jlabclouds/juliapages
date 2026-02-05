### 1. Real Numbers and Topology 📈

Introduction to the real numbers and topological foundations.

#### What You'll Learn
- Properties of real numbers
- Completeness axiom
- Topology of the real line
- Open and closed sets
- Limit points and closure

#### Key Definitions

**Completeness Axiom**: Every non-empty subset of ℝ that is bounded above has a least upper bound (supremum).

**Neighborhood**: An open interval (a, b) containing point x is a neighborhood of x.

**Open Set**: A set U is open if every point in U has a neighborhood contained in U.

**Closed Set**: A set F is closed if ℝ \ F is open.

#### Properties

\`\`\`julia
using Plots

# Visualizing open and closed intervals
p = plot(legend=false, xlabel="x", ylabel="Set membership")

# Open interval (a,b)
plot!(p, [1, 3], [1, 1], linewidth=3, label="(1,3) - Open", color=:blue)
scatter!(p, [1, 3], [1, 1], markersize=4, color=:white, markerstroke=2)

# Closed interval [a,b]
plot!(p, [5, 7], [0.5, 0.5], linewidth=3, label="[5,7] - Closed", color=:red)
scatter!(p, [5, 7], [0.5, 0.5], markersize=6, color=:red)

p
\`\`\`

#### Applications
- Foundation for real analysis
- Understanding limits and continuity
- Metric spaces and general topology

---

**Next Chapter**: [Sequences and Series](./02_sequences_series.jl)
