# 🚀 QUICK REFERENCE CARD

## Local Development
```bash
cd /home/jesse/juliapages/mat
julia --project -e "using PlutoPages; PlutoPages.serve()"
# Visit http://localhost:8000
```

## Deploy in 2 Minutes

### GitHub Pages (FREE)
1. `git push` to main branch
2. ✅ Auto-deployed via GitHub Actions

### Netlify (FREE, 100GB bandwidth)
1. Go to netlify.com → Connect Git → Select repo
2. Build: `julia --project -e "using PlutoPages; PlutoPages.build()"`
3. Publish: `build`
4. ✅ Live in 2 minutes

### Cloudflare Pages (FREE, Unlimited bandwidth)
1. Go to dash.cloudflare.com → Pages → Connect Git
2. Same build config as Netlify
3. ✅ Live in 1 minute

## Project Structure
```
mat/
├── src/index.jl              ← Homepage
├── navbar.jl                 ← Track definitions
├── tracks/
│   ├── algebra/              ← Math track
│   ├── analysis/
│   ├── geometry-topology/
│   ├── scientific-computation/
│   └── applied-mathematics/
├── README.md                 ← Full deployment guide
├── SETUP.md                  ← Quick start
├── STRUCTURE.md              ← Directory guide
└── Project.toml              ← Dependencies
```

## Add New Chapter
1. Create file: `tracks/[trackname]/NN_chapter_name.jl`
2. Use Pluto markdown syntax
3. Add to `navbar.jl` chapter list
4. Test: `julia --project -e "using PlutoPages; PlutoPages.serve()"`
5. Push & deploy!

## Edit Tracks
Edit `navbar.jl` MATH_TRACKS dictionary:
```julia
const MATH_TRACKS = Dict(
    "algebra" => (
        title = "Your Title",
        emoji = "🔢",
        description = "Your description",
        courses = ["COURSE1", "COURSE2"],
        chapters = ["01_chapter_name", ...]
    ),
    ...
)
```

## Available Tracks
- 🔢 **Algebra** (MATH 676, 677)
- 📈 **Analysis** (MATH 653, 656)
- 🔷 **Geometry-Topology** (MATH 681, 680)
- 🖥️ **Scientific Computation** (MATH 661, 662)
- 🌍 **Applied Mathematics** (MATH 668, 669)

## Documentation
- **README.md** - Everything about deployment
- **SETUP.md** - Quick start guide
- **STRUCTURE.md** - Directory structure
- **CONTRIBUTING.md** - Contributing guide
- **IMPLEMENTATION_SUMMARY.md** - What was built

## Key Files
| File | Purpose |
|------|---------|
| navbar.jl | Track navigation & sidebar |
| Project.toml | Julia dependencies |
| netlify.toml | Netlify config |
| .github/workflows/deploy.yml | GitHub Actions CI/CD |
| config.toml | Site settings |

## Build Commands
```bash
# Local development
julia --project -e "using PlutoPages; PlutoPages.serve()"

# Production build
julia --project -e "using PlutoPages; PlutoPages.build(minify=true)"

# Install dependencies
julia --project -e "using Pkg; Pkg.instantiate()"

# Update dependencies
julia --project -e "using Pkg; Pkg.update()"
```

## Troubleshooting
```bash
# Clear cache and rebuild
rm -rf build/
julia --project -e "using PlutoPages; PlutoPages.build()"

# Test locally
julia --project -e "using PlutoPages; PlutoPages.serve()"
```

## Cost Comparison
| Platform | Cost | Setup |
|----------|------|-------|
| GitHub Pages | Free | Auto |
| Netlify | Free | 2 min |
| Cloudflare | Free | 1 min |
| Vercel | Free | 2 min |
| Self-hosted | $5-20/mo | Manual |

## Next Steps
1. ✅ Read README.md (deployment options)
2. ✅ Choose deployment platform
3. ✅ Run locally to test
4. ✅ Push to GitHub
5. ✅ Watch it deploy!

---
**All files ready. Deployment-ready. Happy teaching! 🎓**
