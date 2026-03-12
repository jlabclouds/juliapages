# Contributing to TemplatePackage.jl

We welcome contributions! Here are some guidelines to help you get started.

## Getting Started

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/your-username/TemplatePackage.jl.git
   cd TemplatePackage.jl
   ```
3. Create a branch for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Setup

```julia
julia> ]
(v1.10) pkg> dev .
(v1.10) pkg> test
```

## Running Tests

```bash
julia --project=. test/runtests.jl
# or
julia -e 'using Pkg; Pkg.test()'
```

## Code Style

- Follow [Julia Style Guide](https://docs.julialang.org/en/v1/manual/style-guide/)
- Use 4 spaces for indentation
- Keep functions concise and focused
- Add docstrings to public functions

## Documentation

When adding new features:
1. Add docstrings to your functions
2. Update relevant documentation files in `docs/src/`
3. Add examples if applicable
4. Run `julia docs/make.jl` to validate documentation builds

## Commit Messages

Use clear, descriptive commit messages:
- ✨ `feat:` for new features
- 🐛 `fix:` for bug fixes
- 📚 `docs:` for documentation changes
- ♻️ `refactor:` for code refactoring
- ✅ `test:` for test additions

Example: `feat: add new optimization algorithm`

## Pull Request Process

1. Update documentation and tests as needed
2. Ensure all tests pass locally
3. Push to your fork
4. Open a pull request with a clear description
5. Respond to any feedback from reviewers

## Issues

Found a bug? Have an idea? Please open an issue on GitHub with:
- Clear title
- Detailed description
- Steps to reproduce (for bugs)
- Expected behavior
- Actual behavior
- Julia version and system information

## Questions?

Feel free to open a discussion or reach out to the maintainers.

Thank you for contributing! 🎉
