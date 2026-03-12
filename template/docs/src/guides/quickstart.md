# Quick Start Guide

Get started with TemplatePackage.jl in minutes!

## Installation

### Option 1: Package Manager (Recommended)

```julia
julia> using Pkg
julia> Pkg.add("TemplatePackage")
```

### Option 2: Development Mode

```bash
git clone https://github.com/username/TemplatePackage.jl.git
cd TemplatePackage.jl
chmod +x setup.sh
./setup.sh
```

## First Steps

### 1. Verify Installation

```julia
julia> using TemplatePackage
julia> basic_function(42)
"The answer is 42"
```

### 2. Explore Basic Functions

```julia
julia> advanced_function(10, 20)
30

julia> process_data([1, 2, 3, 4, 5])
Dict{String, Any} with 4 entries:
  "count" => 5
  "mean"  => 3.0
  "min"   => 1
  "max"   => 5
```

### 3. Read Documentation

- **Getting Started**: `docs/src/guides/getting-started.md`
- **API Reference**: `docs/src/api.md`
- **Examples**: `docs/src/examples/`

## Development

### Setup Development Environment

```bash
make dev
```

### Run Tests

```bash
make test
```

### Build Documentation

```bash
make docs
```

### Format Code

```bash
make format
```

## Test Your Changes

Before pushing, run:

```bash
make test      # Run tests
make docs      # Build docs
make lint      # Check formatting
```

## Build Artifacts

After building documentation, access it at:

```
docs/build/index.html
```

## Key Files

| File | Purpose |
|------|---------|
| `src/TemplatePackage.jl` | Main code |
| `test/runtests.jl` | Test suite |
| `docs/make.jl` | Doc configuration |
| `docs/src/` | Documentation source |
| `Project.toml` | Package manifest |
| `Makefile` | Development commands |

## Common Tasks

### Add New Function

1. Add to `src/TemplatePackage.jl`
2. Add tests to `test/runtests.jl`
3. Add to `docs/src/api.md` or examples
4. Run `make test` and `make docs`

### Update Documentation

Edit files in `docs/src/` and run:

```bash
make docs
```

### Deploy Documentation

Push to `main` branch. GitHub Actions automatically deploys to `gh-pages`.

## Troubleshooting

### Tests Fail

```bash
julia --project=. -e "using Pkg; Pkg.status()"
```

### Documentation Won't Build

```bash
rm -rf docs/build
make docs
```

### Package Not Found

```julia
julia> using Pkg
julia> Pkg.add("TemplatePackage")
```

## Next Steps

- 📖 Read [Getting Started](docs/src/guides/getting-started.md)
- 🔍 Check [API Reference](docs/src/api.md)
- 💡 Explore [Examples](docs/src/examples/)
- 🤝 See [Contributing Guidelines](CONTRIBUTING.md)

## Resources

- [Julia Documentation](https://docs.julialang.org)
- [Package Guide](https://pkgdocs.julialang.org)
- [Documenter.jl](https://documenter.juliadocs.org)

---

**Happy coding!** 🚀
