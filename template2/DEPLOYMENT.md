# Deployment Guide

This guide covers deploying MyTemplate to various hosting platforms.

## Prerequisites

- Julia 1.9 or higher
- Git repository (GitHub, GitLab, etc.)
- SSH access (for traditional servers)
- Docker (for containerized deployments)

## Deployment Options

### 1. GitHub Pages (Recommended for Documentation)

Automatic deployment via GitHub Actions.

**Setup:**

```bash
# In your repository settings:
# 1. Go to Settings > Pages
# 2. Set source to "Deploy from a branch"
# 3. Select branch: gh-pages
# 4. Save
```

The workflow in `.github/workflows/docs.yml` handles automatic builds.

**Deployment:**

```bash
git push origin main
```

Documentation automatically builds and deploys to `yourusername.github.io/MyTemplate`

### 2. Heroku

Deploy the web application to Heroku.

**Prerequisites:**
- Heroku account
- Heroku CLI

**Setup:**

```bash
# Create Heroku app
heroku create my-template

# Set buildpack
heroku buildpacks:set https://github.com/Julia-BESB/heroku-buildpack-julia.git

# Deploy
git push heroku main

# Check logs
heroku logs --tail
```

### 3. DigitalOcean App Platform

Easy containerized deployment.

**Steps:**

1. Create DigitalOcean account
2. Create new app
3. Connect GitHub repository
4. Auto-detect Julia runtime
5. Configure environment variables
6. Deploy

### 4. AWS

Deploy to AWS using EC2 or Lambda.

**EC2 Setup:**

```bash
# SSH into instance
ssh ubuntu@your-instance-ip

# Install Julia
curl -fsSL https://install.julialang.org | sh

# Clone repository
git clone https://github.com/yourusername/MyTemplate.git
cd MyTemplate

# Install dependencies
julia --project -e 'using Pkg; Pkg.instantiate()'

# Run server
julia --project web/server.jl
```

**Lambda Setup:**

See AWS Lambda documentation for Julia support.

### 5. Docker

Deploy using Docker containers.

**Create Dockerfile:**

```dockerfile
FROM julia:1.9

WORKDIR /app

COPY . .

RUN julia --project -e 'using Pkg; Pkg.instantiate()'

EXPOSE 8000

CMD ["julia", "--project", "-e", "using MyTemplate; MyTemplate.serve(host=\"0.0.0.0\")"]
```

**Build and Run:**

```bash
docker build -t my-template .
docker run -p 8000:8000 my-template
```

### 6. Traditional Server (Linux/Unix)

Deploy to your own server.

**Setup:**

```bash
# Install Julia
curl -fsSL https://install.julialang.org | sh

# Clone repository
git clone https://github.com/yourusername/MyTemplate.git
cd MyTemplate

# Install dependencies
julia --project -e 'using Pkg; Pkg.instantiate()'

# Create systemd service
sudo tee /etc/systemd/system/mytemplate.service > /dev/null <<EOF
[Unit]
Description=MyTemplate Service
After=network.target

[Service]
Type=simple
User=julia
WorkingDirectory=/path/to/MyTemplate
ExecStart=/usr/local/julia/bin/julia --project -e "using MyTemplate; MyTemplate.serve(host=\"0.0.0.0\", port=8000)"
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

# Enable and start service
sudo systemctl enable mytemplate
sudo systemctl start mytemplate
```

### 7. Nginx Reverse Proxy

Set up Nginx as a reverse proxy.

**Configuration:**

```nginx
upstream mytemplate {
    server localhost:8000;
}

server {
    listen 80;
    server_name yourdomain.com;

    location / {
        proxy_pass http://mytemplate;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

**Enable:**

```bash
sudo ln -s /etc/nginx/sites-available/mytemplate /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

## Environment Configuration

### Production Environment Variables

```bash
export ENVIRONMENT=production
export PORT=8000
export HOST=0.0.0.0
export LOG_LEVEL=info
export ENABLE_ANALYTICS=true
```

### Configuration for Production

Edit `config.toml`:

```toml
[server]
port = 8000
timeout = 60

[docs]
strict = true

[deploy]
method = "github-pages"
base_url = "https://yourdomain.com"
```

## SSL/TLS Certificates

### Let's Encrypt (Free)

```bash
# Install certbot
sudo apt-get install -y certbot python3-certbot-nginx

# Generate certificate
sudo certbot certonly --nginx -d yourdomain.com

# Auto-renew
sudo systemctl enable certbot.timer
sudo systemctl start certbot.timer
```

## Performance Optimization

### Caching Headers

```julia
# In routes.jl
route("/:path", method=GET) do
    Genie.Responses.setheader("Cache-Control", "public, max-age=3600")
    # ... route handler
end
```

### Gzip Compression

Enable in Genie config.

### Database Query Optimization

If using a database, add indexes and optimize queries.

## Monitoring & Health Checks

### Health Endpoint

```bash
curl http://localhost:8000/api/health
# Returns: {"status":"ok","version":"0.1.0"}
```

### Logging

```bash
# Check systemd logs
sudo journalctl -u mytemplate -f
```

### Uptime Monitoring

- [UptimeRobot](https://uptimerobot.com/) - Free tier available
- [Pingdom](https://www.pingdom.com/) - Monitor uptime
- [New Relic](https://newrelic.com/) - Performance monitoring

## Backup & Recovery

```bash
# Backup documentation builds
tar -czf mytemplate-docs-$(date +%Y%m%d).tar.gz docs/build/

# Backup configuration
cp config.toml config.toml.backup
```

## Troubleshooting Deployment

### Port Conflicts

```bash
# Find process using port
lsof -i :8000

# Kill process
kill -9 <PID>
```

### Memory Issues

```bash
# Monitor memory usage
free -h

# Increase Julia heap size
export JULIA_HEAP_SIZE_HINT=4G
```

### Slow Build Times

```bash
# Use precompiled files
julia --project -e 'using PackageCompiler; create_sysimage()'
```

## Post-Deployment

1. ✅ Test all endpoints
2. ✅ Verify SSL/TLS
3. ✅ Check monitoring
4. ✅ Set up auto-renewal
5. ✅ Configure backups
6. ✅ Document deployment
7. ✅ Set up monitoring alerts

---

For questions, check the [Documentation](docs/src/index.md) or open an issue.
