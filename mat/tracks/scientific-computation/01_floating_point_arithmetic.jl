### 1. Floating Point Arithmetic 🖥️

Understanding how computers represent and compute with numbers.

#### What You'll Learn
- IEEE 754 floating point standard
- Machine epsilon and rounding errors
- Error propagation in computations
- Numerical stability considerations

#### Floating Point Representation

A floating point number is represented as: ±m × bᵉ where:
- **m** is the mantissa (significand)
- **b** is the base (typically 2)
- **e** is the exponent

#### Key Concepts

\`\`\`julia
# Machine epsilon: smallest ε such that 1 + ε ≠ 1
eps(Float64)  # ≈ 2.22e-16

# Demonstrate rounding errors
x = 0.1 + 0.2
println("0.1 + 0.2 = \$x")
println("x == 0.3: \$(x == 0.3)")

# Catastrophic cancellation
a = 1.0
b = 1.0e-10
result = a + b - a
println("Catastrophic cancellation: \$result")
\`\`\`

#### Avoiding Numerical Errors
- Avoid subtracting nearly equal numbers
- Order operations to minimize accumulation of rounding errors
- Use higher precision when necessary
- Be aware of overflow and underflow

#### Applications
- Scientific computing
- Machine learning algorithms
- Financial computations

---

**Next Chapter**: [Linear Systems](./02_linear_systems.jl)
