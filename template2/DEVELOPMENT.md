# Development Guide

Guide for developers working on MyTemplate itself.

## Project Overview

MyTemplate is a complete documentation and web framework template combining:
- **Genie.jl** - Lightweight, high-performance Julia web framework
- **PlutoPages** - Interactive notebook-based content
- **Documenter.jl** - Professional API documentation generation

## Development Workflow

### Setting Up Development Environment

```bash
git clone https://github.com/yourusername/MyTemplate.git
cd MyTemplate
julia --project
] dev .
] instantiate
```

### Project Structure

```
src/
├── MyTemplate.jl          # Main module
├── core.jl               # Core functionality
├── utils.jl              # Utility functions
└── routes.jl             # Web routes

docs/
├── make.jl               # Documentation builder
└── src/                  # Documentation source

pages/
└── *.pluto.jl           # Pluto notebooks

test/
└── runtests.jl          # Test suite
```

### Running Tests

```julia
] test

# Run with coverage
using Coverage
covdir = coverage_statistics(
    dir_patterns=[Regex(".*src.*jl\$")],
    process_file=(line, filename) -> contains(filename, "MyTemplate.jl"),
)
```

### Building Locally

```julia
using MyTemplate
MyTemplate.serve()

# Or for development
MyTemplate.run_dev_server()
```

## Code Organization

### Module Structure

- **Core Module** (`MyTemplate.jl`) - Main module definition
- **Core Logic** (`core.jl`) - Business logic and data structures  
- **Utilities** (`utils.jl`) - Helper functions for HTML/template generation
- **Routes** (`routes.jl`) - HTTP route handlers

### Naming Conventions

- Functions: `lowercase_with_underscores`
- Types: `CamelCase`
- Constants: `CONSTANT_NAME`
- Private functions: `_leading_underscore`

### Docstring Format

```julia
"""
    my_function(arg1::String, arg2::Int)::String

Brief description of what the function does.

# Arguments
- `arg1::String`: Description
- `arg2::Int`: Description

# Returns
- `String`: Description

# Examples
```jldoctest
julia> my_function("test", 42)
"result"
```
"""
function my_function(arg1::String, arg2::Int)::String
    # Implementation
end
```

## Adding New Features

### 1. Adding a Route

Edit `src/routes.jl`:

```julia
route("/my-route", method=GET) do
    html = "<h1>My Route</h1>"
    html
end
```

### 2. Adding Documentation

Create markdown in `docs/src/`:

```markdown
# My Topic

Description...

## Subsection

More content...
```

Add to `docs/make.jl` pages list.

### 3. Adding Tests

Edit `test/runtests.jl`:

```julia
@testset "My Feature" begin
    result = my_function()
    @test result == expected
end
```

### 4. Adding an Example Notebook

Create `pages/example.pluto.jl`:

```julia
### A Pluto.jl notebook ###
# v0.19.27

using Markdown

# ╔═╡ 00000000-0000-0000-0000-000000000001
md"""
# My Example
"""
```

## Performance Considerations

### Route Performance

```julia
# Good - simple and direct
route("/fast") do
    "Hello"
end

# Bad - unnecessary allocations
route("/slow") do
    result = ""
    for i in 1:1000
        result *= string(i)
    end
    result
end
```

### Documentation Build Time

- Keep documentation modular
- Use lazy imports
- Cache heavy computations

## Testing Guidelines

### Unit Tests

Test individual functions in isolation:

```julia
@testset "Function Logic" begin
    @test my_function("input") == "expected"
end
```

### Integration Tests

Test component interactions:

```julia
@testset "Route Integration" begin
    response = GET("/my-route")
    @test response.status == 200
end
```

### Coverage Goals

- Aim for >80% coverage
- Cover happy paths and error cases
- Test edge conditions

## Documentation Standards

- Write clear, concise docstrings
- Provide usage examples
- Document parameters and return values
- Keep README updated
- Update CHANGELOG for changes

## Version Management

This project follows [Semantic Versioning](https://semver.org/):

- **MAJOR.MINOR.PATCH**
- Increment MAJOR for breaking changes
- Increment MINOR for new features
- Increment PATCH for bug fixes

## CI/CD Pipeline

### GitHub Actions

Located in `.github/workflows/`:

- `docs.yml` - Build and deploy documentation
- `tests.yml` - Run tests on multiple platforms

### Local Testing

Before pushing:

```bash
# Run tests
julia --project -e '] test'

# Build docs
julia --project/docs docs/make.jl

# Check formatting
```

## Release Process

1. **Update Version**
   - `Project.toml`
   - `docs/src/index.md`
   - `CHANGELOG.md`

2. **Test Everything**
   - Run local tests
   - Build documentation
   - Test deployment

3. **Tag Release**
   ```bash
   git tag -a v0.2.0 -m "Release version 0.2.0"
   git push origin v0.2.0
   ```

4. **Update Release Notes**
   - Copy CHANGELOG entry to GitHub release
   - Add download links

## Debugging Tips

### Enable Verbose Logging

```julia
using Logging
logger = SimpleLogger(stdout, Logging.Debug)
with_logger(logger) do
    # Your code here
end
```

### Julia REPL Debugging

```julia
using Debugger
@enter my_function(args)

# In debug session:
# help - Show commands
# n - Next line
# c - Continue
# s - Step into function
```

### HTTP Debugging

```julia
using HTTP
auth = HTTP.BasicAuth("user", "pass")
response = HTTP.get(url, auth=auth)
```

## Common Issues

### Module Reload Problems

```julia
# Clear precompiled code
] build MyTemplate

# Or restart Julia
```

### Import Conflicts

```julia
using MyTemplate: serve
# Explicitly import needed functions
```

### Memory Leaks

```julia
# Monitor memory in long-running sessions
import Sys
Sys.free_memory()
```

## Resources

- [Genie Documentation](https://docs.genieframework.com/)
- [Julia Manual](https://docs.julialang.org/)
- [Pluto Documentation](https://plutojl.org/)
- [Documenter.jl Guide](https://documenter.juliadocs.org/)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

---

Happy coding! 🎉
