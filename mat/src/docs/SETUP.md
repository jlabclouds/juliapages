# 🚀 Setup & Deployment Quick Guide

## Local Setup (5 minutes)

### Step 1: Install Julia
```bash
# macOS (using Homebrew)
brew install julia

# Ubuntu/Debian
sudo apt-get install julia

# Windows
# Download from https://julialang.org/downloads/
```

### Step 2: Clone Repository
```bash
git clone https://github.com/YOUR_USERNAME/math-tracks.git
cd math-tracks
```

### Step 3: Install Dependencies
```bash
julia --project -e "using Pkg; Pkg.instantiate()"
```

### Step 4: Start Local Server
```bash
julia --project -e "using PlutoPages; PlutoPages.serve()"
```

Visit: `http://localhost:8000`

---

## One-Click Deployment Options

### ⭐ Recommended for Beginners: **Netlify**

1. Push code to GitHub
2. Go to [netlify.com](https://netlify.com)
3. Click "New site from Git"
4. Connect GitHub account
5. Select repository
6. Build command: `julia --project -e "using PlutoPages; PlutoPages.build()"`
7. Publish directory: `build`
8. Click "Deploy"

**Done!** Your site is live. Get free SSL, automatic deployments, and 100 GB bandwidth.

---

### ⚡ Best Performance: **Cloudflare Pages**

1. Push code to GitHub
2. Go to [dash.cloudflare.com](https://dash.cloudflare.com)
3. Pages → Create project
4. Connect Git → Select repository
5. Build command: `julia --project -e "using PlutoPages; PlutoPages.build()"`
6. Build output: `build`
7. Deploy

**Bonus**: Automatic HTTPS, instant CDN, unlimited bandwidth.

---

### 🐙 Integrated with GitHub: **GitHub Pages**

1. Push to GitHub
2. Go to Settings → Pages
3. Select branch: `main`
4. Use GitHub Actions (automated with `.github/workflows/deploy.yml`)
5. Commits trigger automatic deployment

**Included**: Free, integrated with GitHub, HTTPS by default.

---

### 🎡 Premium Options: **Vercel**

1. Go to [vercel.com](https://vercel.com)
2. Import Git → Select repository
3. Framework: "Other"
4. Build Command: `julia --project -e "using PlutoPages; PlutoPages.build()"`
5. Output Directory: `build`
6. Deploy

**Perks**: Analytics, previews, edge functions.

---

## Advanced: Self-Hosted with Docker

```bash
# Build Docker image
docker build -t math-tracks .

# Run locally
docker run -p 8080:80 math-tracks

# Push to container registry
docker tag math-tracks myregistry/math-tracks:latest
docker push myregistry/math-tracks:latest

# Deploy to Heroku
heroku container:push web
heroku container:release web
```

---

## Cost Comparison

| Platform | Cost | Best For |
|----------|------|----------|
| GitHub Pages | **Free** | Static sites, open source |
| Netlify | **Free** (300 min/mo) | Jamstack, automated deployments |
| Cloudflare | **Free** (500 min/mo) | Performance, CDN |
| Vercel | **Free** | Next.js, serverless functions |
| Self-hosted | $5-20/mo | Full control, custom needs |

---

## Domain Setup

### Using a Custom Domain

**On Netlify:**
- Domain settings → Add custom domain
- Update DNS CNAME to `yoursite.netlify.app`

**On Cloudflare:**
- Add domain to Cloudflare
- Cloudflare handles DNS + hosting

**On GitHub Pages:**
- Settings → Pages → Custom domain
- Update DNS A records to GitHub IPs

---

## Troubleshooting

### "Build Command Failed"
```bash
# Test locally first
julia --project -e "using PlutoPages; PlutoPages.build()"

# If error, check logs and ensure Project.toml is valid
julia --project -e "using Pkg; Pkg.status()"
```

### "Julia not found"
Ensure your deployment platform has Julia available. Most platforms require specifying Julia version in environment variables.

### Blank Page
- Check browser console for JavaScript errors
- Verify `build/` directory exists and contains `index.html`
- Test locally first with `PlutoPages.serve()`

---

## Next Steps

1. ✅ **Deploy**: Choose a platform above
2. 📝 **Customize**: Edit `navbar.jl` to match your needs
3. 📚 **Add Content**: Create `.jl` files in track directories
4. 🎨 **Style**: Modify CSS in chapter files or add custom CSS
5. 📢 **Share**: Tell people about your platform!

---

## Learning Resources

- [PlutoPages Docs](https://github.com/JuliaPluto/PlutoPages.jl)
- [Pluto.jl Tutorial](https://plutojl.org/)
- [Julia Manual](https://docs.julialang.org/)
- [Netlify Docs](https://docs.netlify.com/)
- [Cloudflare Pages](https://developers.cloudflare.com/pages/)

---

**Need help?** Open an issue on GitHub or check the main README.md
