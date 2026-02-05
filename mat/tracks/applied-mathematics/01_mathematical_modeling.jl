### 1. Mathematical Modeling 🌍

Principles and practice of translating real-world problems into mathematics.

#### What You'll Learn
- Problem formulation and scoping
- Identifying variables and parameters
- Choosing mathematical frameworks
- Model validation and refinement
- Sensitivity analysis

#### The Modeling Cycle

1. **Understand** - Carefully study the real-world problem
2. **Simplify** - Identify key features, ignore details
3. **Formulate** - Translate to mathematical language
4. **Analyze** - Use mathematics to derive solutions
5. **Interpret** - Translate solutions back to real-world context
6. **Validate** - Compare predictions with reality
7. **Refine** - Improve model based on validation

#### Example: Population Growth

\`\`\`julia
using DifferentialEquations, Plots

# Exponential model: dp/dt = r*p
function exponential_model(u, p, t)
    r = p[1]
    return r * u
end

# Logistic model: dp/dt = r*p(1 - p/K)
function logistic_model(u, p, t)
    r, K = p
    return r * u * (1 - u / K)
end

# Compare models
p₀ = 100  # Initial population
tspan = (0.0, 10.0)

# Exponential
sol_exp = solve(ODEProblem(exponential_model, p₀, tspan, [0.2]))

# Logistic with carrying capacity
sol_log = solve(ODEProblem(logistic_model, p₀, tspan, [0.2, 1000]))

plot(sol_exp, label="Exponential", linewidth=2)
plot!(sol_log, label="Logistic", linewidth=2)
xlabel!("Time")
ylabel!("Population")
\`\`\`

#### Key Principles
- **Clarity**: Model assumptions should be explicit
- **Parsimony**: Use simplest model that explains phenomena
- **Testability**: Model predictions must be verifiable
- **Transferability**: Understanding should apply broadly

#### Applications
- Epidemiology (disease spread modeling)
- Climate science
- Economics and finance
- Engineering and physics

---

**Next Chapter**: [Asymptotic Analysis](./02_asymptotic_analysis.jl)
