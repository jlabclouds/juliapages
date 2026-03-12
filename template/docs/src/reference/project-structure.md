# Project Structure

This document describes the organization of the TemplatePackage.jl repository.

## Directory Layout

```
TemplatePackage.jl/
├── src/                          # Source code
│   └── TemplatePackage.jl        # Main module file
│
├── docs/                         # Documentation (Documenter.jl)
│   ├── make.jl                   # Documentation build script
│   ├── Project.toml              # Documentation dependencies
│   └── src/
│       ├── index.md              # Homepage
│       ├── api.md                # API reference
│       ├── assets/
│       │   └── custom.css        # Custom styling
│       ├── guides/
│       │   ├── getting-started.md
│       │   ├── installation.md
│       │   └── faq.md
│       └── examples/
│           ├── basic-example.md
│           └── advanced-usage.md
│
├── test/                         # Unit tests
│   └── runtests.jl               # Test suite
│
├── .github/                      # GitHub configuration
│   ├── workflows/
│   │   ├── CI.yml                # Continuous Integration
│   │   └── docs.yml              # Documentation deployment
│   └── ISSUE_TEMPLATE/
│       ├── bug_report.md
│       └── feature_request.md
│
├── Project.toml                  # Project manifest
├── README.md                     # Project overview
├── LICENSE                       # MIT License
├── CONTRIBUTING.md               # Contribution guidelines
├── Makefile                      # Development commands
├── build_docs.sh                 # Documentation build script
├── run_tests.sh                  # Test runner script
└── .gitignore                    # Git ignore rules
```

## Key Files

### Source Code

- **`src/TemplatePackage.jl`** - Main module containing:
  - `basic_function()` - Simple string generation
  - `advanced_function()` - Mathematical operations
  - `process_data()` - Statistical analysis

### Documentation

- **`docs/make.jl`** - Documenter.jl build configuration
- **`docs/src/index.md`** - Main documentation page
- **`docs/src/api.md`** - Complete API reference
- **`docs/src/guides/`** - User guides and tutorials
- **`docs/src/examples/`** - Practical examples

### Testing

- **`test/runtests.jl`** - Comprehensive test suite
  - Unit tests for all functions
  - Edge case testing
  - Error handling tests

### CI/CD

- **`.github/workflows/CI.yml`** - Testing on multiple Julia versions
- **`.github/workflows/docs.yml`** - Automated docs building and deployment

### Configuration

- **`Project.toml`** - Package metadata and dependencies
- **`docs/Project.toml`** - Documentation dependencies
- **`Makefile`** - Convenient development commands

## File Relationships

```
TemplatePackage
    ├── exports (src/TemplatePackage.jl)
    │   ├── basic_function
    │   ├── advanced_function
    │   └── process_data
    │
    ├── documented in (docs/src/)
    │   ├── API reference (api.md)
    │   ├── Getting started (guides/getting-started.md)
    │   ├── Installation (guides/installation.md)
    │   ├── Examples (examples/basic-example.md)
    │   └── Advanced (examples/advanced-usage.md)
    │
    ├── tested in (test/runtests.jl)
    │   └── Unit tests for all functions
    │
    └── configured via
        ├── docs/make.jl (Documenter setup)
        └── .github/workflows/ (CI/CD)
```

## Development Workflow

### Before Starting

1. **Clone the repository**
   ```bash
   git clone https://github.com/username/TemplatePackage.jl.git
   cd TemplatePackage.jl
   ```

2. **Set up development environment**
   ```bash
   make dev
   ```

### During Development

3. **Make code changes** in `src/`
4. **Add tests** in `test/`
5. **Update docs** in `docs/src/`
6. **Run tests locally**
   ```bash
   make test
   ```

7. **Build docs locally**
   ```bash
   make docs
   ```

8. **Format code**
   ```bash
   make format
   ```

### Before Pushing

9. **Run full test suite**
   ```bash
   make test
   ```

10. **Verify documentation builds**
    ```bash
    make docs
    ```

11. **Commit and push**
    ```bash
    git add .
    git commit -m "feat: description of changes"
    git push
    ```

## Important Notes

### Adding New Functionality

When adding new functions:

1. **Update `src/TemplatePackage.jl`**
   - Add function signature
   - Include comprehensive docstring
   - Add to exports if public

2. **Add tests in `test/runtests.jl`**
   - Unit tests for normal cases
   - Edge case tests
   - Error handling tests

3. **Update documentation**
   - Add to `api.md` automatically via docstring
   - Add examples to relevant guide
   - Update homepage if significant feature

### Documentation Build Details

- Uses **Documenter.jl** for automatic API documentation
- DocTests are run during build (tests in docstrings)
- Custom CSS in `docs/src/assets/custom.css`
- Deployed to GitHub Pages via `.github/workflows/docs.yml`

### Testing Strategy

- **Unit tests** for each function
- **Integration tests** for combined operations
- **Error tests** for edge cases and invalid inputs
- **Coverage tracking** via codecov

## Customization Guide

To adapt this template for your project:

1. **Update Project.toml**
   - Change `name` from "TemplatePackage"
   - Update `authors` and `uuid`

2. **Update docs/make.jl**
   - Change `sitename`
   - Update `canonical` URL
   - Modify `pages` structure

3. **Rename src/TemplatePackage.jl**
   - Should match project name
   - Update in `test/runtests.jl`

4. **Update GitHub URLs**
   - `.github/workflows/docs.yml`
   - `docs/make.jl`
   - `README.md`

5. **Customize styling**
   - Edit `docs/src/assets/custom.css`
   - Adjust colors and fonts

## Resources

- [Julia Package Guide](https://pkgdocs.julialang.org/)
- [Documenter.jl](https://documenter.juliadocs.org/)
- [Julia Style Guide](https://docs.julialang.org/en/v1/manual/style-guide/)
- [GitHub Actions](https://docs.github.com/en/actions)

## Support

For questions about this template structure:
- Check [CONTRIBUTING.md](../CONTRIBUTING.md)
- Review [FAQ](../docs/src/guides/faq.md)
- Open an issue on GitHub
