# Contributing to MyTemplate

Thank you for your interest in contributing to MyTemplate! This document provides guidelines and instructions for contributing.

## Code of Conduct

Be respectful, inclusive, and constructive in all interactions.

## How to Contribute

### Reporting Issues

1. Check if the issue already exists
2. Provide a clear title and description
3. Include steps to reproduce (if applicable)
4. Mention your environment (OS, Julia version)

### Suggesting Enhancements

1. Describe the enhancement clearly
2. Explain the use case and benefits
3. Provide examples if possible

### Pull Requests

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Make your changes
4. Add/update tests if needed
5. Update documentation
6. Commit with clear messages: `git commit -m "feat: add my feature"`
7. Push to your fork
8. Open a pull request

## Coding Standards

### Julia Code Style

- Follow the [Julia Style Guide](https://docs.julialang.org/en/v1/manual/style-guide/)
- Use 4-space indentation
- Use meaningful variable names
- Add docstrings to functions

### Documentation

- Update relevant documentation files
- Add docstring comments to new functions
- Include examples where appropriate

### Testing

- Write tests for new functionality
- Ensure all tests pass: `] test`
- Aim for >80% code coverage

### Commit Messages

Use conventional commits:
- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation
- `style:` for formatting
- `refactor:` for code restructuring
- `test:` for tests

Example: `feat: add dark mode toggle`

## Development Setup

### Prerequisites

- Julia 1.9+
- Git

### Local Development

```bash
git clone https://github.com/yourusername/MyTemplate.git
cd MyTemplate
julia --project
] instantiate
] dev .
```

### Running Tests Locally

```julia
] test
```

### Building Documentation Locally

```julia
using MyTemplate
MyTemplate.build_docs()
# Open: docs/build/index.html
```

## File Naming and Organization

- Source code: `src/`
- Documentation: `docs/src/`
- Notebooks: `pages/`
- Tests: `test/`
- Public assets: `public/`

## Review Process

1. Code review by maintainers
2. Automated tests must pass
3. Documentation must be complete
4. Changes should follow project conventions

## Questions?

- Open a discussion on GitHub
- Check existing documentation
- Review similar pull requests

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for helping improve MyTemplate! 🙏
