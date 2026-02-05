# 📚 Mathematics Learning Tracks Platform

A comprehensive, interactive learning platform built with Julia and Pluto notebooks. Choose your mathematical track and dive into carefully structured courses designed to minimize learning overlap while providing depth and rigor.

## 🎓 Available Tracks

| Track | Code | Description | Level |
|-------|------|-------------|-------|
| **🔢 Linear Algebra** | MATH 676, 677 | Vectors, matrices, eigenvalues, decompositions | Undergraduate |
| **📈 Real Analysis** | MATH 653, 656 | Limits, continuity, differentiation, integration | Undergraduate |
| **🔷 Geometry & Topology** | MATH 681, 680 | Manifolds, topological spaces, differential geometry | Graduate |
| **🖥️ Scientific Computation** | MATH 661, 662 | Numerical methods, ODEs, PDEs, optimization | Undergraduate |
| **🌍 Applied Mathematics** | MATH 668, 669 | Modeling, asymptotic methods, variational principles | Graduate |

## 🚀 Quick Start

### Local Development

**Prerequisites**: Julia 1.7+

```bash
# Clone or download this repository
cd mat/

# Start local Pluto server
julia
my_site_source = "./mat"
using PlutoPages
PlutoPages.develop(my_site_source)

# Or serve directlys
julia --project -e "using PlutoPages; PlutoPages.serve()"
```

The site will be available at `http://localhost:8000`

### Project Structure

```
mat/
├── src/
│   └── index.jl              # Homepage
├── navbar.jl                 # Navigation configuration
├── tracks/
│   ├── algebra/              # Linear Algebra track
│   ├── analysis/             # Real Analysis track
│   ├── geometry-topology/    # Geometry & Topology track
│   ├── scientific-computation/  # Scientific Computation track
│   └── applied-mathematics/  # Applied Mathematics track
├── Project.toml              # Julia dependencies
└── README.md                 # This file
```

## 📦 Deployment Guides

### 1. **GitHub Pages** (Free, Built-in)

#### Setup Steps:

1. **Push to GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
   git push -u origin main
   ```

2. **Enable GitHub Pages**
   - Go to repository Settings → Pages
   - Select "Deploy from a branch" (or "GitHub Actions")
   - Choose `main` branch and `/root` directory
   - Or use the provided GitHub Actions workflow (automatic)

3. **GitHub Actions Workflow** (Recommended)
   - The `.github/workflows/deploy.yml` file automates builds
   - Commits to `main` branch trigger automatic deployment
   - No additional configuration needed

4. **Configure Custom Domain** (Optional)
   - In Settings → Pages → Custom domain
   - Update DNS records at your domain registrar
   - CNAME record pointing to `USERNAME.github.io`

**Pros**: Free, integrated with GitHub, automatic deployments
**Cons**: Public repository required (unless using Pro)

---

### 2. **Netlify** (Free, Easy Setup)

#### Setup Steps:

1. **Connect Repository**
   - Go to [netlify.com](https://netlify.com)
   - Click "New site from Git"
   - Connect your GitHub/GitLab/Bitbucket account
   - Select your repository

2. **Configure Build Settings**
   - **Build command**: `julia --project -e "using PlutoPages; PlutoPages.build()"`
   - **Publish directory**: `build`
   - **Node version**: 18+ (or skip if not needed)

3. **Environment Variables** (Optional)
   ```
   JULIA_NUM_THREADS=4
   JULIA_VERSION=1.9
   ```

4. **Deploy**
   - Push to your repository's main branch
   - Netlify automatically builds and deploys
   - Your site appears at `your-site.netlify.app`

5. **Custom Domain** (Optional)
   - In Netlify dashboard → Domain settings
   - Add your custom domain
   - Update DNS records

**Pros**: Free tier with 100 GB bandwidth, automatic deployments, built-in CI/CD
**Cons**: Build times limited on free tier

---

### 3. **Cloudflare Pages** (Free, Ultra-fast)

#### Setup Steps:

1. **Connect Repository**
   - Go to [dash.cloudflare.com](https://dash.cloudflare.com)
   - Select account → Pages
   - Click "Create a project" → "Connect to Git"
   - Authorize and select your repository

2. **Configure Build Settings**
   - **Framework preset**: None
   - **Build command**: `julia --project -e "using PlutoPages; PlutoPages.build()"`
   - **Build output directory**: `build`

3. **Environment Variables**
   ```
   JULIA_VERSION=1.9
   JULIA_NUM_THREADS=4
   ```

4. **Deploy**
   - Complete setup and trigger first build
   - Cloudflare automatically builds and deploys
   - Site appears at `your-project.pages.dev`

5. **Custom Domain**
   - Add your domain through Cloudflare dashboard
   - Point nameservers to Cloudflare (if not already)

**Pros**: Free with excellent performance, Cloudflare edge network, instant deployments
**Cons**: Free tier has build time limits (500 minutes/month)

---

### 4. **Vercel** (Free tier available)

#### Setup Steps:

1. **Import Repository**
   - Go to [vercel.com](https://vercel.com)
   - Click "Add New..." → "Project"
   - Import your Git repository

2. **Configure Project**
   - **Framework**: Other
   - **Build Command**: `julia --project -e "using PlutoPages; PlutoPages.build()"`
   - **Output Directory**: `build`
   - **Install Command**: (leave blank)

3. **Environment Variables**
   ```
   JULIA_NUM_THREADS=4
   NODE_VERSION=18
   ```

4. **Deploy**
   - Click "Deploy"
   - Vercel automatically builds and deploys
   - Site appears at `your-project.vercel.app`

**Pros**: Free tier with good performance, git-integrated, analytics included
**Cons**: Function/API features require paid tier for some use cases

---

### 5. **Docker Deployment** (Self-hosted)

#### Dockerfile:

```dockerfile
FROM julia:1.9-slim

WORKDIR /app

COPY Project.toml Manifest.toml ./
RUN julia -e 'using Pkg; Pkg.instantiate()'

COPY . .
RUN julia -e 'using PlutoPages; PlutoPages.build()'

FROM nginx:alpine
COPY --from=0 /app/build /usr/share/nginx/html
EXPOSE 80
```

#### Build and Run:

```bash
# Build image
docker build -t math-tracks .

# Run container
docker run -p 8080:80 math-tracks

# Visit http://localhost:8080
```

#### Deploy to Services:
- **Heroku**: `heroku container:push web` then `heroku container:release web`
- **Google Cloud Run**: Similar Docker build process
- **AWS**: Use Elastic Container Service (ECS)
- **DigitalOcean**: App Platform supports container deployments
- **Your own server**: Use Docker Compose

---

### 6. **Traditional Web Server** (Full Control)

#### Build Locally:

```bash
# Build static site
julia --project -e "using PlutoPages; PlutoPages.build(minify=true)"

# Contents in `build/` directory
```

#### Deploy to Web Server:

```bash
# Via SCP
scp -r build/* user@server.com:/var/www/html/

# Via FTP/SFTP
# Upload build/ directory to your web root

# Via git hooks
# Push to repository, use server-side git hook to auto-deploy
```

**Popular Hosts**:
- **Namecheap**: Shared hosting, FTP upload
- **Bluehost/SiteGround**: WordPress-style hosting
- **Linode/DigitalOcean**: VPS with full control
- **AWS S3 + CloudFront**: Serverless static hosting

---

## 🔄 Continuous Deployment Comparison

| Platform | Cost | Build Time | Bandwidth | Setup Difficulty |
|----------|------|-----------|-----------|------------------|
| GitHub Pages | Free | ~2 min | Unlimited | Easy |
| Netlify | Free (300 min/mo) | ~3 min | 100 GB/mo | Easy |
| Cloudflare Pages | Free (500 min/mo) | ~1 min | Unlimited | Easy |
| Vercel | Free | ~1 min | 100 GB/mo | Easy |
| Docker + Self-hosted | ~$5-20/mo | Custom | Custom | Moderate |
| Traditional Hosting | ~$5-15/mo | Manual | Varies | Moderate |

## 📋 Development Workflow

### Prerequisites
```bash
julia --version  # Should be 1.7+
```

### Install Dependencies
```bash
julia --project -e "using Pkg; Pkg.instantiate()"
```

### Local Testing
```bash
julia --project -e "using PlutoPages; PlutoPages.serve()"
```

### Build for Production
```bash
julia --project -e "using PlutoPages; PlutoPages.build(; minify=true)"
```

### Deployment Checklist
- [ ] All notebooks tested locally
- [ ] No broken links
- [ ] Images optimized
- [ ] Metadata updated
- [ ] Custom domain configured (if applicable)
- [ ] HTTPS enabled (automatic on Netlify/Vercel/Pages)

## 📖 Learning Path Recommendations

### First Time?
1. Start with **Linear Algebra** - fundamental to all quantitative fields
2. Explore **Real Analysis** - theoretical foundations
3. Progress to specialized tracks

### Computer Science/ML Focus
1. **Scientific Computation** - numerical foundations
2. **Linear Algebra** - data structures and transformations
3. **Applied Mathematics** - optimization and modeling

### Pure Mathematics Focus
1. **Real Analysis** - rigorous foundations
2. **Topology** - abstract structures
3. **Geometry** - geometric intuition

### Physics/Engineering Focus
1. **Linear Algebra** - essential math
2. **Scientific Computation** - numerical methods
3. **Applied Mathematics** - modeling real systems

## 🛠️ Customization

### Add Your Content
1. Create `.jl` file in appropriate track directory
2. Add to chapter list in `navbar.jl`
3. Use PlutoPages syntax for navigation

### Styling
- Edit CSS in chapter files
- Use PlutoUI for components
- Responsive design by default

### Adding Tracks
1. Create directory under `tracks/`
2. Add to `MATH_TRACKS` dictionary in `navbar.jl`
3. Create chapter files following naming convention

## 🐛 Troubleshooting

### Build Fails Locally
```bash
# Clear cache and reinstall
rm -rf build/ __pycache__
julia --project -e "using Pkg; Pkg.instantiate(); Pkg.build()"
```

### Module Not Found
```bash
# Update dependencies
julia --project -e "using Pkg; Pkg.update()"
```

### Deployment Timeout
- Increase build timeout in platform settings
- Reduce notebook complexity
- Use parallel execution for notebooks

## 📚 Resources

- [PlutoPages.jl Documentation](https://github.com/JuliaPluto/PlutoPages.jl)
- [Pluto.jl Documentation](https://plutojl.org/)
- [Julia Language](https://julialang.org/)
- [GitHub Pages Help](https://docs.github.com/en/pages)
- [Netlify Documentation](https://docs.netlify.com/)
- [Cloudflare Pages Docs](https://developers.cloudflare.com/pages/)

## 📝 License

This project is provided as-is for educational purposes.

---

**Last Updated**: February 2026
**Maintained by**: Your Organization
**Contributions**: Welcome!
