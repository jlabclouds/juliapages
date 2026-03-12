# Cloud Deployment Guide

## Prerequisites

- Docker image built: `docker build -t mytemplate:latest .`
- Environment variables configured
- Container registry (Docker Hub, Azure Container Registry, etc.)

## Platform-Specific Deployments

### Railway.app (Recommended - Easiest)

1. **Create Account** at https://railway.app/

2. **Push Docker Image**:
```bash
docker login --username=yourusername
docker tag mytemplate:latest yourusername/mytemplate:latest
docker push yourusername/mytemplate:latest
```

3. **Deploy**:
- Create new project
- Choose "Docker image"
- Enter image: `yourusername/mytemplate:latest`
- Add environment variables from `.env`
- Deploy

4. **Access**: https://mytemplate-prod.up.railway.app

### Render.com

1. **Create Account** at https://render.com/

2. **Docker Push**:
```bash
# Login to Docker Hub
docker login

# Push image
docker tag mytemplate:latest yourusername/mytemplate:latest
docker push yourusername/mytemplate:latest
```

3. **Create New Service**:
- Container Registry (Docker Image)
- Image URL: `yourusername/mytemplate:latest`
- Port: 8000
- Add environment variables
- Deploy

### Azure Container Instances

```bash
# Create resource group
az group create --name mytemplate-rg --location eastus

# Push to Azure Container Registry
az acr create --resource-group mytemplate-rg \
  --name mytemplateregistry --sku Basic

# Build and push
az acr build --registry mytemplateregistry \
  --image mytemplate:latest .

# Deploy
az container create \
  --resource-group mytemplate-rg \
  --name mytemplate \
  --image mytemplateregistry.azurecr.io/mytemplate:latest \
  --ports 8000 \
  --ip-address Public \
  --environment-variables \
    OPENAI_API_KEY=$OPENAI_API_KEY \
    COHERE_API_KEY=$COHERE_API_KEY \
    TAVILY_API_KEY=$TAVILY_API_KEY

# Get public IP
az container show --resource-group mytemplate-rg \
  --name mytemplate --query ipAddress.ip
```

### AWS Elastic Container Service (ECS)

```bash
# Create ECR repository
aws ecr create-repository --repository-name mytemplate

# Build and push
aws ecr get-login-password --region us-east-1 | \
  docker login --username AWS --password-stdin 123456789.dkr.ecr.us-east-1.amazonaws.com

docker tag mytemplate:latest 123456789.dkr.ecr.us-east-1.amazonaws.com/mytemplate:latest
docker push 123456789.dkr.ecr.us-east-1.amazonaws.com/mytemplate:latest

# Create task definition (save as task-def.json):
# {
#   "family": "mytemplate",
#   "containerDefinitions": [{
#     "name": "mytemplate",
#     "image": "123456789.dkr.ecr.us-east-1.amazonaws.com/mytemplate:latest",
#     "portMappings": [{"containerPort": 8000}],
#     "environment": [
#       {"name": "OPENAI_API_KEY", "value": "..."},
#       ...similar for other keys
#     ],
#     "memory": 1024,
#     "cpu": 512
#   }]
# }

# Register task
aws ecs register-task-definition --cli-input-json file://task-def.json

# Create service
aws ecs create-service \
  --cluster default \
  --service-name mytemplate-service \
  --task-definition mytemplate \
  --desired-count 1
```

### DigitalOcean App Platform

1. **Create Account** at https://www.digitalocean.com/

2. **Connect GitHub Repository**:
- Fork your template repository
- Link to DigitalOcean Apps

3. **Create `app.yaml`** in repo root:
```yaml
name: mytemplate-ai
services:
- name: web
  github:
    branch: main
    repo: yourusername/mytemplate
  build_command: docker build -t mytemplate:latest .
  http_port: 8000
  envs:
  - key: OPENAI_API_KEY
    scope: RUN_AND_BUILD_TIME
    value: ${OPENAI_API_KEY}
  - key: COHERE_API_KEY
    scope: RUN_AND_BUILD_TIME
    value: ${COHERE_API_KEY}
  - key: TAVILY_API_KEY
    scope: RUN_AND_BUILD_TIME
    value: ${TAVILY_API_KEY}
```

4. **Deploy**: Automatic on push

### Heroku (Alternative)

```bash
# Login
heroku login

# Create app
heroku create mytemplate-ai

# Set buildpack to Julia
heroku buildpacks:set https://github.com/Julia-BESB/heroku-buildpack-julia.git

# Set environment variables
heroku config:set OPENAI_API_KEY=$OPENAI_API_KEY
heroku config:set COHERE_API_KEY=$COHERE_API_KEY
heroku config:set TAVILY_API_KEY=$TAVILY_API_KEY

# Deploy
git push heroku main

# View logs
heroku logs --tail
```

## Production Checklist

- [ ] Environment variables set (no hardcoded secrets)
- [ ] Rate limiting configured
- [ ] CORS headers properly set
- [ ] Health checks passing
- [ ] Logging enabled
- [ ] Database backups configured (if using sessions)
- [ ] SSL/TLS certificate installed
- [ ] API keys rotated regularly
- [ ] Monitoring alerts set up
- [ ] Disaster recovery plan documented

## Monitoring & Observability

### Application Insights (Azure)

```julia
# Add to dependencies
using ApplicationInsights

# Initialize in server.jl
insights = ApplicationInsights("your-instrumentation-key")

# Track events
track_event(insights, "ai_query_success", Dict(
    "provider" => "openai",
    "tokens" => 245
))
```

### CloudWatch (AWS)

```bash
# Configure in Docker
ENV AWS_REGION=us-east-1

# Logs automatically sent to CloudWatch Logs
```

### Datadog

```bash
# Environment variable
DD_AGENT_HOST=datadog-agent
DD_TRACE_ENABLED=true
```

## Scaling Considerations

### Single Container (Current)
- ✅ Easy deployment
- ✅ Low cost
- ❌ Limited concurrent users
- ❌ No redundancy

### Load Balanced (Recommended for prod)
```yaml
# docker-compose production
version: '3.9'
services:
  web1:
    image: mytemplate:latest
    environment: ...
  web2:
    image: mytemplate:latest
    environment: ...
  
  nginx:
    image: nginx:latest
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - web1
      - web2
```

### Redis for Sessions
```julia
# In AIHelpMe.jl, replace SESSIONS Dict with Redis

using Redis
const redis_pool = RedisConnectionPool()

# Store sessions
set_session(conversation_id, session_data)

# Recover sessions across containers
get_session(conversation_id)
```

## Cost Optimization

| Platform | Estimated Cost | Notes |
|----------|---|---|
| Railway.app | $5-50/mo | Generous free tier |
| Render.com | Free-$50/mo | Free tier available |
| Azure Container | $20-100/mo | Pay per request |
| AWS ECS | $5-50/mo | Auto-scaling available |
| DigitalOcean | $5-100/mo | Droplet + database |
| Heroku | $100+/mo | Dyno pricing |

**Recommendation**: Start with Railway or Render free tier, migrate to Azure/AWS if needed for scale.

## Rollback & Updates

### Blue-Green Deployment
```bash
# Deploy new version alongside old
docker-compose up -d web-v2 nginx

# Route traffic to new version
# nginx.conf: upstream backend { server web-v2:8000; }

# Rollback if needed
# nginx.conf: upstream backend { server web-v1:8000; }
```

### Git-based Deployment
```bash
# Railway/Render auto-redeploy on push
git push origin main

# Done! Platform handles deployment
```

---

**Choose the platform that best fits your needs.** Most users should start with **Railway.app** or **Render.com** for simplicity.
