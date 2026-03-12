---
title: PlutoPages Integration
description: Integrate PlutoPages with your documentation to create interactive notebook-based pages
keywords: plutopages, pluto, notebooks, interactive, documentation, integration
author: Template Contributors
category: guides
order: 7
---

# PlutoPages Integration

[PlutoPages.jl](https://github.com/JuliaPluto/PlutoPages.jl) enables you to create interactive documentation using [Pluto.jl](https://plutojupyter.tech/) notebooks. This guide shows how to integrate PlutoPages with your TemplatePackage.jl documentation.

## What is PlutoPages?

PlutoPages is a deployment tool that converts Pluto notebooks into standalone HTML pages. It allows you to:
- Write interactive documentation as Pluto notebooks
- Include live code examples that users can modify
- Create computational narratives with embedded computations
- Deploy as static HTML (no Pluto server required for viewing)
- Mix with Documenter.jl pages seamlessly

## Setting Up PlutoPages

### 1. Add Dependencies

Add PlutoPages and Pluto to your documentation project:

```julia
# In docs/Project.toml, add:
[deps]
Documenter = "e30172f5-a6a5-5a46-863b-614d45cd2de4"
Pluto = "c3e4b0f3-bcc5-4296-890b-22f435e628f3"
PlutoPages = "c223e72b-c63d-4c8c-a18f-0a81e8b1d925"
```

Or use:

```bash
cd docs
julia --project=. -e 'using Pkg; Pkg.add(["Pluto", "PlutoPages"])'
```

### 2. Create A PlutoPages Directory

Create a dedicated directory for your Pluto notebooks:

```bash
mkdir docs/plutopages
```

This keeps notebooks separate from Markdown documentation.

## Creating PlutoPages Notebooks

### Basic Notebook Structure

Create a Pluto notebook at `docs/plutopages/example.jl`:

```julia
### A Julia Pluto Notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ Cell order: #uuid
# ╔═╡ 00000000-0000-0000-0000-000000000001
md"""
# Interactive Example

This is an interactive PlutoPages notebook!
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
md"""
## Live Code Execution

The code below runs in your browser:
"""

# ╔═╡ 00000000-0000-0000-0000-000000000003
x = 5
y = 10
x + y

# ╔═╡ 00000000-0000-0000-0000-000000000004
md"""
## Visualization

Create plots and visualizations:
"""

# ╔═╡ 00000000-0000-0000-0000-000000000005
using Plots
plot(sin, -π:0.01:π, label="sin(x)", legend=:bottomright)
```

### Using Pluto Directly

Alternatively, create notebooks interactively using Pluto:

```julia
julia> using Pluto
julia> Pluto.run()
```

Then save notebooks to the `docs/plutopages/` directory.

## Building PlutoPages

### Option 1: Standalone PlutoPages Build

Create `docs/build_plutopages.jl`:

```julia
using PlutoPages

# Build all notebooks in plutopages directory
PlutoPages.build(
    dirname = "docs/plutopages",
    output_dir = "docs/build/plutopages"
)
```

Run with:

```bash
cd docs
julia build_plutopages.jl
```

### Option 2: Integrate with Documenter.jl

Update `docs/make.jl` to build both Documenter and PlutoPages:

```julia
using Documenter, PlutoPages

# ... existing Documenter configuration ...

# Create PlutoPages
PlutoPages.build(
    dirname = joinpath(@__DIR__, "plutopages"),
    output_dir = joinpath(@__DIR__, "build", "plutopages")
)

# Build Documenter as usual
makedocs(
    # ... existing configuration ...
    pages = [
        "Home" => "index.md",
        "PlutoPages Examples" => [
            "Example Notebook" => "../plutopages/example.html",
        ],
        # ... rest of your pages ...
    ]
)
```

## Adding Pages to Your Documentation

### From Documenter (Markdown)

Create a `.md` file with frontmatter:

```markdown
---
title: My Documentation Page
description: A static documentation page
keywords: documentation, guide
---

# My Documentation Page

Content here...
```

### From PlutoPages (Notebooks)

1. **Create a Pluto notebook** in `docs/plutopages/my_page.jl`
2. **Build it** with PlutoPages
3. **Link it** in your documentation navigation

## Best Practices

### Organize Notebooks

Create subdirectories for different types of notebooks:

```
docs/plutopages/
├── tutorials/
│   ├── introduction.jl
│   └── advanced-usage.jl
├── examples/
│   ├── basic-example.jl
│   └── advanced-patterns.jl
└── reference/
    ├── api-reference.jl
    └── function-guide.jl
```

### Use Markdown Cells for Structure

Start notebooks with clear markdown headers:

```julia
md"""
# Page Title

Your introductory text here.
"""

md"""
## Section 1

Explain concepts before showing code.
"""

# Code implementation
my_function(x) = x^2
```

### Keep Cells Focused

Small, focused cells are easier to understand:

```julia
# ✓ Good: Single responsibility
calculate_mean(data) = sum(data) / length(data)

# ✗ Avoid: Multiple unrelated computations
result1 = calculate_mean(data1)
result2 = calculate_mean(data2)
plot1 = plot(data1)
plot2 = plot(data2)
```

### Document with Frontmatter

Add metadata to notebook files using comments:

```julia
#= 
# Frontmatter
title: Interactive Tutorial
description: Learn TemplatePackage through interactive examples  
keywords: tutorial, interactive, beginner
order: 1
=#
```

### Include Dependencies

Always declare required packages at the start:

```julia
using Plots, Statistics, LinearAlgebra
using TemplatePackage
```

### Add Navigation Links

Help users navigate between pages:

```julia
md"""
← [Back to Documentation](../index.html) | [Next: Advanced Usage](advanced.html) →
"""
```

## Frontmatter Support in PlutoPages

PlutoPages notebooks can use frontmatter-like metadata:

```julia
# docs/plutopages/my_notebook.jl

#= 
FRONTMATTER
title: My Interactive Page
description: An interactive notebook page
keywords: interactive, examples, tutorial
author: Template Contributors
=# 

md"""
# My Interactive Page

Content here...
"""
```

PlutoPages will extract this metadata for:
- HTML page titles
- Search indexing
- Documentation metadata

## Deployment

### GitHub Pages

Add to your GitHub Actions workflow (`.github/workflows/docs.yml`):

```yaml
- name: Build PlutoPages
  run: |
    cd docs
    julia build_plutopages.jl

- name: Build Documentation
  run: |
    cd docs
    julia make.jl
```

### Hosting

Both Documenter.jl and PlutoPages output static HTML, perfect for:
- GitHub Pages
- GitLab Pages
- Netlify
- Any static hosting service

## Advantages of PlutoPages

| Feature | PlutoPages | Documenter.jl |
|---------|-----------|-------------|
| **Interactive Code** | ✓ Live execution | ✗ Static |
| **Live Plots** | ✓ Interactive | ○ Static images |
| **User Code Editing** | ✓ Users can edit | ✗ Read-only |
| **Search** | ✓ Built-in | ✓ Built-in |
| **Build Speed** | Slower (notebooks) | Fast (markdown) |
| **Learning Curve** | Moderate | Gentle |
| **IDE Integration** | Pluto (web-based) | Any editor |

## Disadvantages

- **Build Time**: Notebooks take longer to execute during build
- **Complexity**: Requires Julia environment for building
- **Package Compatibility**: Some packages may not work in PlutoPages

## Troubleshooting

### Notebooks Don't Build

Check error messages:

```bash
julia docs/build_plutopages.jl 2>&1 | tee build.log
```

### Missing Dependencies

Ensure all packages used in notebooks are in `docs/Project.toml`:

```julia
cd docs
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

### Images Not Loading

Use relative paths consistently:

```julia
# ✓ Good
img = load("../assets/image.png")

# ✗ Avoid absolute paths
img = load("/home/user/project/assets/image.png")
```

### Slow Build Times

Optimize by:
- Moving heavy computations to separate notebooks
- Using caching when possible
- Running builds in parallel (if supported)

## Example Workflow

1. **Create a notebook** interactively using Pluto
2. **Save to** `docs/plutopages/my_page.jl`
3. **Build with** `julia docs/build_plutopages.jl`
4. **Add to navigation** in `docs/make.jl`
5. **Deploy** via GitHub Actions

## Next Steps

- Create your first Pluto notebook
- Integrate PlutoPages into your build system
- Combine with Documenter.jl for comprehensive documentation
- Deploy to GitHub Pages or your hosting service

## Resources

- **PlutoPages.jl**: https://github.com/JuliaPluto/PlutoPages.jl
- **Pluto.jl**: https://plutojupyter.tech/
- **Pluto Tutorials**: https://github.com/JuliaPluto/featured
- **Documenter.jl**: https://documenter.juliadocs.org/

## Questions?

If you encounter issues with PlutoPages integration:

1. Check the [PlutoPages GitHub issues](https://github.com/JuliaPluto/PlutoPages.jl/issues)
2. Review [Pluto documentation](https://plutojupyter.tech/)
3. Ensure all dependencies are installed and compatible
4. Check that notebooks follow Pluto cell structure correctly

