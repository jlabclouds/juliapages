### 1. Vectors and Matrices 🔢

This chapter introduces the fundamental concepts of linear algebra: vectors and matrices.

#### What You'll Learn
- Vector spaces and linear operations
- Matrix representation and properties
- Special matrices (identity, diagonal, triangular)
- Matrix operations and their computational complexity

#### Interactive Examples

\`\`\`julia
using LinearAlgebra, PlutoUI

# Vector operations
v₁ = [1, 2, 3]
v₂ = [4, 5, 6]

# Dot product
dot_product = dot(v₁, v₂)

# Cross product
cross_product = cross(v₁, v₂)

println("Dot product: \$dot_product")
println("Cross product: \$cross_product")
\`\`\`

#### Key Concepts
- **Linear combination**: aᵥ₁ + bᵥ₂
- **Basis**: Minimal spanning set of vectors
- **Norm**: ||v|| = √(v·v)
- **Orthogonality**: v⊥w if v·w = 0

#### Applications
- Computer graphics transformations
- Data representation in machine learning
- Network analysis
- Physics simulations

---

**Next Chapter**: [Linear Transformations](./02_linear_transformations.jl)
