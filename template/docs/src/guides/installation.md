# Installation Guide

Complete installation instructions for TemplatePackage.jl.

## Requirements

- **Julia** ≥ 1.10
- Modern operating system (Windows, macOS, Linux)
- Internet connection for initial setup
- ~50 MB disk space

## Installation Methods

### Method 1: Julia Package Manager (Recommended)

This is the easiest and recommended way to install TemplatePackage.

```julia
julia> using Pkg
julia> Pkg.add("TemplatePackage")
```

Or enter Pkg mode by pressing `]`:

```julia
julia> ]
(@v1.10) pkg> add TemplatePackage
```

### Method 2: From GitHub Repository

For the latest development version:

```julia
julia> using Pkg
julia> Pkg.add(url="https://github.com/username/TemplatePackage.jl.git")
```

### Method 3: Development / Local Installation

For package development:

```bash
git clone https://github.com/username/TemplatePackage.jl.git
cd TemplatePackage.jl
julia --project
```

Then in Julia:

```julia
julia> using Pkg
julia> Pkg.instantiate()
julia> Pkg.test()
```

Or using dev mode:

```julia
julia> ]
(@v1.10) pkg> dev /path/to/TemplatePackage.jl
```

## Verification

Verify the installation was successful:

```julia
julia> using TemplatePackage
julia> basic_function(42)
"The answer is 42"
```

## Version Information

Check your installed version:

```julia
julia> using Pkg
julia> Pkg.status("TemplatePackage")
```

Or within the package:

```julia
julia> using TemplatePackage
julia> @info "TemplatePackage loaded successfully"
```

## Updating

### Update to Latest Stable Version

```julia
julia> using Pkg
julia> Pkg.update("TemplatePackage")
```

### Update All Dependencies

```julia
julia> using Pkg
julia> Pkg.update()
```

## Troubleshooting

### "Package TemplatePackage not found"

Make sure you have the correct package name:

```julia
julia> using Pkg
julia> Pkg.add("TemplatePackage")
```

### Dependency Conflicts

If you encounter dependency conflicts:

```julia
julia> using Pkg
julia> Pkg.resolve()
```

### Julia Version Issues

Ensure you have Julia 1.10 or later:

```julia
julia> VERSION
v1.10.2

# If older version, download from https://julialang.org/downloads/
```

### Network Issues

If behind a proxy, configure Julia:

```julia
julia> using Pkg
julia> Pkg.set_build_timeout(1000)
```

### Installation Fails on Windows

If you see Unicode path issues on Windows:

```julia
julia> ENV["USER"] = "User"
julia> using Pkg
julia> Pkg.add("TemplatePackage")
```

## Platform-Specific Guides

### Windows

1. [Download Julia](https://julialang.org/downloads/) for Windows
2. Run the installer
3. Open Julia command prompt
4. Follow standard installation steps above

### macOS

```bash
# Using Homebrew
brew install julia

# Or download from https://julialang.org/downloads/
```

### Linux (Ubuntu/Debian)

```bash
sudo apt-add-repository ppa:staticfloat/juliareleases
sudo apt-get update
sudo apt-get install julia
```

## Docker Installation

If you prefer Docker:

```dockerfile
FROM julia:latest

RUN julia -e 'using Pkg; Pkg.add("TemplatePackage")'

CMD ["julia"]
```

## Uninstallation

To remove TemplatePackage:

```julia
julia> using Pkg
julia> Pkg.rm("TemplatePackage")
```

To completely reinstall:

```julia
julia> using Pkg
julia> Pkg.rm("TemplatePackage")
julia> Pkg.add("TemplatePackage")
```

## Getting Help

- 📖 [Documentation Home](../index.md)
- 💬 [GitHub Discussions](https://github.com/username/TemplatePackage.jl/discussions)
- 🐛 [Report Issues](https://github.com/username/TemplatePackage.jl/issues)

## Next Steps

Once installed, continue with:

- [Getting Started Guide](getting-started.md)
- [Basic Examples](../examples/basic-example.md)
- [API Reference](../api.md)

---

Having installation issues? Please [open an issue](https://github.com/username/TemplatePackage.jl/issues) with details about your system and the error message.
