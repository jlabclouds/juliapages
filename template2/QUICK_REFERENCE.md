# Quick Reference Guide

Quick lookup guide for common MyTemplate tasks.

## Starting the Server

```julia
using MyTemplate

# Development mode
MyTemplate.serve()

# Custom port
MyTemplate.serve(port=3000)

# Custom host
MyTemplate.serve(host="localhost", port=8000)
```

## Building Documentation

```julia
using MyTemplate
MyTemplate.build_docs()

# Output: docs/build/index.html
```

## Running Tests

```bash
julia --project
] test
```

## Adding Content

### New Page

1. Create markdown file in `docs/src/guide/`
2. Add to pages list in `docs/make.jl`
3. Rebuild docs

### New Route

Add to `src/routes.jl`:

```julia
route("/mypage") do
    "<h1>My Page</h1>"
end
```

### New Notebook

Create in `pages/mynotebook.pluto.jl`

## File Locations

| Item | Location |
|------|----------|
| Source Code | `src/` |
| Documentation | `docs/src/` |
| Notebooks | `pages/` |
| Tests | `test/` |
| Styles | `public/css/` |
| Scripts | `public/js/` |
| Config | `config.toml` |

## Common Commands

### Update Dependencies

```julia
] update
] status
```

### Clear Cache

```bash
rm -rf ~/.julia/compiled
```

### Format Code

```julia
] format
```

### Check Package Health

```julia
] check
```

## Configuration

### Change Site Title

Edit `config.toml`:

```toml
[site]
title = "My New Title"
```

Or in `src/core.jl`:

```julia
"title" => "My New Title"
```

### Change Port

```julia
MyTemplate.serve(port=8001)
```

Or in `config.toml`:

```toml
[server]
port = 8001
```

## Troubleshooting

### Port already in use
```julia
MyTemplate.serve(port=8001)
```

### Module not found
```julia
] dev .
```

### Slow startup
```bash
rm -rf ~/.julia/compiled
```

### Cache issues
```julia
] build MyTemplate
```

## Deployment

### GitHub Pages
```bash
git push origin main
```
(Auto-deploys via GitHub Actions)

### Local Server
See [DEPLOYMENT.md](DEPLOYMENT.md)

## Documentation URLs

- **Home**: `/`
- **Docs**: `/docs`
- **Tutorials**: `/tutorials`
- **Examples**: `/examples`
- **API Status**: `/api/health`
- **Version Info**: `/api/version`

## Key Files

- **Main App**: `src/MyTemplate.jl`
- **Routes**: `src/routes.jl`
- **Docs Config**: `docs/make.jl`
- **Site Config**: `config.toml`
- **Tests**: `test/runtests.jl`
- **Styles**: `public/css/style.css`

## Useful Julia Commands

```julia
# Enter package manager
]

# Update packages
pkg> update

# Check dependencies
pkg> status

# Remove package
pkg> remove PackageName

# Exit package manager
# (press Ctrl+C or type 'exit')

# Clear REPL
# Ctrl+L (on Linux/Mac)
```

## Git Workflow

```bash
# Clone
git clone https://github.com/yourusername/MyTemplate.git
cd MyTemplate

# Create feature branch
git checkout -b feature/my-feature

# Make changes and commit
git add .
git commit -m "feat: add my feature"

# Push and create PR
git push origin feature/my-feature
```

## Testing Checklist

- [ ] Code follows style guide
- [ ] New functions have docstrings
- [ ] Tests written and passing
- [ ] Documentation updated
- [ ] No breaking changes
- [ ] Changelog updated

## Performance Tips

1. Use built-in caching for static content
2. Optimize route handlers
3. Precompile if long-running
4. Monitor memory usage
5. Use async for long operations

## Security Checklist

- [ ] Validate all user input
- [ ] Use HTTPS in production
- [ ] Keep dependencies updated
- [ ] Enable security headers
- [ ] Regular security audits
- [ ] Don't commit secrets

## Resources

- [Documentation](docs/src/index.md)
- [API Reference](docs/src/api/reference.md)
- [Examples](docs/src/examples.md)
- [FAQ](docs/src/faq.md)
- [Contributing](CONTRIBUTING.md)
- [Development](DEVELOPMENT.md)
- [Deployment](DEPLOYMENT.md)

---

For more help, check the full documentation or open an issue.
