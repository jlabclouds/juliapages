# Deployment Guide

Instructions for deploying TemplatePackage.jl and its documentation.

## Documentation Deployment

### Automatic Deployment (Recommended)

Documentation is automatically deployed to GitHub Pages when you push to `main` branch.

**Prerequisites:**
1. Repository must be on GitHub
2. Enable GitHub Pages in repository settings
3. Set source to `gh-pages` branch
4. Create `DOCUMENTER_KEY` secret (see below)

### Setup GitHub Pages

1. **Go to Repository Settings**
   - Navigate to Settings → Pages
   - Source: Deploy from a branch
   - Branch: `gh-pages`
   - Folder: `/ (root)`

2. **Create Documentation Key**
   ```bash
   # On your local machine
   julia -e "using DocumenterTools; DocumenterTools.genkeys(user=\"username\", repo=\"TemplatePackage.jl\")"
   ```

3. **Add to GitHub Secrets**
   - Go to Settings → Secrets and variables → Actions
   - New repository secret: `DOCUMENTER_KEY`
   - Paste the generated key

### Manual Documentation Build

If you need to build locally:

```bash
# Install dependencies
julia --project=docs -e "using Pkg; Pkg.instantiate()"

# Build documentation
julia --project=docs docs/make.jl

# View locally
julia --project=docs -e "using LiveServer, Documenter; LiveServer.serve(dir=\"docs/build\")"
```

## Package Registration

### Register on JuliaHub (Julia Package Registry)

1. **Fork the General Registry**
   ```bash
   git clone https://github.com/JuliaRegistries/General.git
   cd General
   git checkout -b TemplatePackage
   ```

2. **Add Registration Script**
   ```bash
   # Create registrator comment on GitHub PR
   @JuliaRegistrator register
   ```

3. **Use Registrator Bot**
   - Push a release tag: `v0.1.0`
   - Comment on the release: `@JuliaRegistrator register`
   - Follow the bot's instructions

### Prerequisites for Registration

- ✅ Package passes tests
- ✅ Documentation is complete
- ✅ Code follows Julia style guide
- ✅ LICENSE file included
- ✅ README with installation instructions
- ✅ Public repository on GitHub
- ✅ Julia 1.0+ compatible

## Release Process

### Creating a Release

1. **Update version in Project.toml**
   ```toml
   version = "0.2.0"
   ```

2. **Update CHANGELOG (optional but recommended)**
   ```markdown
   ## [0.2.0] - 2024-01-15
   ### Added
   - New feature
   
   ### Fixed
   - Bug fix
   ```

3. **Commit and tag**
   ```bash
   git add Project.toml CHANGELOG.md
   git commit -m "bump: version 0.2.0"
   git tag -a v0.2.0 -m "Release version 0.2.0"
   git push origin main --tags
   ```

4. **Create GitHub Release**
   - Go to Releases → Create new release
   - Tag: v0.2.0
   - Title: TemplatePackage.jl v0.2.0
   - Description: Paste changelog content
   - Optional: Comment `@JuliaRegistrator register`

## Docker Deployment

### Build Docker Image

Create `Dockerfile`:

```dockerfile
FROM julia:latest

WORKDIR /app
COPY . .

RUN julia -e 'using Pkg; Pkg.instantiate()'

CMD ["julia"]
```

Build and run:

```bash
docker build -t template-package .
docker run -it template-package
```

## CI/CD Pipeline

### Current Workflows

**CI.yml** - Runs on every push/PR:
- Tests on Julia 1.10, 1.11, nightly
- Multi-platform (Linux, macOS, Windows)
- Code formatting check
- Documentation build test

**docs.yml** - Runs on push to main:
- Builds documentation
- Deploys to GitHub Pages
- Uploads coverage reports

### Monitoring Workflows

1. Go to repository Actions tab
2. Click workflow to see details
3. Check logs for any failures

## Troubleshooting Deployment

### Docs Won't Deploy

**Problem:** Workflow fails with documentation error

**Solution:**
```bash
# Test locally
julia --project=docs docs/make.jl

# Check for errors
# Common: missing @docs, broken links
```

### Package Won't Register

**Problem:** Registrator bot returns errors

**Solution:**
- Ensure version is higher than previous
- Check Project.toml syntax
- Verify all required fields
- Review compat section

### GitHub Pages Not Showing

**Problem:** Documentation URL returns 404

**Solution:**
1. Check Settings → Pages
2. Verify `gh-pages` branch exists
3. Check workflow completed successfully
4. Clear browser cache
5. Wait 5 minutes for propagation

## Advanced Deployment

### Custom Domain

1. Update `docs/make.jl`:
   ```julia
   deploydocs(
       repo = "...",
       custom_domain = "mypackage.com",
   )
   ```

2. Add CNAME file to `gh-pages` branch:
   ```bash
   echo "mypackage.com" > docs/CNAME
   ```

### Organization Packages

To deploy as organization:

```julia
deploydocs(
    repo = "github.com/organization/TemplatePackage.jl.git",
)
```

## Update Checklist

Before each release:

- [ ] Update version in `Project.toml`
- [ ] Update `CHANGELOG.md`
- [ ] Run tests: `make test`
- [ ] Build docs: `make docs`
- [ ] Check for lint issues: `make lint`
- [ ] Commit changes
- [ ] Create git tag
- [ ] Push to GitHub
- [ ] Wait for CI/CD to pass
- [ ] Create GitHub release
- [ ] Register package (if new)

## Support

For deployment issues:
- Check [GitHub Actions documentation](https://docs.github.com/en/actions)
- Review [Documenter.jl guide](https://documenter.juliadocs.org/)
- Search [Julia Discourse](https://discourse.julialang.org/)
- Open an issue on GitHub

---

**Ready to deploy?** Follow the checklist above! 🚀
