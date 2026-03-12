# AI Help Implementation Guide

## Overview

This project now includes a complete AI Research Helper system (Phases 1-3) with:
- **Backend**: AIHelpMe.jl module with multi-provider LLM support (OpenAI, Cohere)
- **Frontend**: AIHelpUI with modern chat interface
- **Search**: Tavily integration for web search
- **Context**: Docs-only filtering for LLM context
- **Deployment**: Docker + Docker Compose for local and cloud

## Quick Start

### 1. Setup Environment Variables

```bash
# Copy the example .env file
cp .env.example .env

# Edit .env with your API keys
nano .env
```

Required variables:
```bash
OPENAI_API_KEY=sk-...
COHERE_API_KEY=...
TAVILY_API_KEY=...
```

### 2. Local Development (Docker Compose)

```bash
# Start both web and AI services
docker-compose up

# Access the application
# - Main site: http://localhost:8000
# - AI Helper: http://localhost:8000/ai-help
# - API health: http://localhost:8000/api/ai-help/config
```

### 3. Local Development (Direct Julia)

```bash
# Install dependencies
julia --project -e "using Pkg; Pkg.instantiate()"

# Start server (initializes AIHelpMe with docs)
julia server.jl
```

## Project Structure

### AIHelpMe Module (`src/AIHelpMe/`)

Core AI backend with docs-only context:

```
AIHelpMe/
├── AIHelpMe.jl          # Main module entry (includes all submodules)
├── core.jl              # AIResponse struct, session management
├── llm_interface.jl     # Provider abstractions (OpenAI, Cohere)
├── api_handlers.jl      # HTTP handlers for API endpoints
├── providers/
│   ├── openai.jl        # OpenAI API integration
│   └── cohere.jl        # Cohere API integration
├── search/
│   └── tavily_search.jl # Tavily web search
└── context/
    ├── doc_context.jl   # Full-text search over ./docs/src
    └── session_cache.jl # Session persistence & cleanup
```

**Key Functions:**
- `AIHelpMe.initialize(config)` - Initialize with configuration
- `AIHelpMe.query(question; provider, search, conversation_id)` - Ask a question
- `AIHelpMe.get_session(id)` - Retrieve conversation
- `AIHelpMe.clear_session(id)` - Delete conversation

### AIHelpUI Module (`src/AIHelpUI/`)

Frontend chat interface:

```
AIHelpUI/
├── routes.jl            # HTML template rendering
├── static/
│   ├── js/
│   │   └── chat.js      # Chat interface logic (WebSocket-ready)
│   └── css/
│       └── aihelp.css   # Dark theme styling
└── templates/           # (For future component separation)
```

**Features:**
- 🎨 Dark theme with modern UI
- 💬 Real-time message rendering
- 🔍 Multi-provider selector (OpenAI/Cohere)
- 🌐 Web search toggle
- 📝 Auto-expanding textarea
- 💾 LocalStorage conversation persistence
- 📱 Responsive mobile design

### API Endpoints

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/ai/query` | POST | Submit question to AI |
| `/api/ai/session/:id` | GET | Get conversation info |
| `/api/ai-help/config` | GET | Get system config |
| `/api/ai/search` | POST | Search docs directly |
| `/ai-help` | GET | Render chat UI |

### Configuration Files

**Local Dev** (`config/local.toml`):
```toml
[ai]
providers = ["openai", "cohere"]
primary_provider = "openai"
search_enabled = true
max_tokens = 2048
docs_path = "./docs/src"

[server]
port = 8000
debug = true
```

**Docker** (`config/docker.toml`): Similar but with `/app` paths

**Cloud** (`config/cloud.toml`): Production settings (debug=false, longer TTL)

### Environment Variables

See `.env.example` for full list:

```bash
# LLM APIs
OPENAI_API_KEY=sk-...
OPENAI_MODEL=gpt-4  # Default

COHERE_API_KEY=...
COHERE_MODEL=command-r-plus  # Default

# Search
TAVILY_API_KEY=...

# Session Management
SESSION_TTL=3600  # 1 hour
CACHE_SESSIONS=true

# Context
MAX_CONTEXT_TOKENS=2048
MAX_DOC_CHUNKS=5  # Return top 5 matching docs
DOCS_PATH=./docs/src
```

## Deployment Options

### Option 1: Docker Compose (Recommended for Local)

```bash
# Development
docker-compose up

# Production (optimized)
docker-compose -f docker-compose.prod.yml up -d
```

### Option 2: Docker Only

```bash
docker build -t mytemplate:latest .
docker run -p 8000:8000 \
  -e OPENAI_API_KEY=$OPENAI_API_KEY \
  -e COHERE_API_KEY=$COHERE_API_KEY \
  -e TAVILY_API_KEY=$TAVILY_API_KEY \
  mytemplate:latest
```

### Option 3: Cloud Platforms

**Railway/Render/Fly.io:**
```bash
# Set environment variables in dashboard
# Deploy Docker image
```

**Azure Container Instances:**
```bash
az container create \
  --resource-group mygroup \
  --name mytemplate \
  --image mytemplate:latest \
  --environment-variables OPENAI_API_KEY=$OPENAI_API_KEY ...
```

## API Usage Examples

### Query AI with Search

```bash
curl -X POST http://localhost:8000/api/ai/query \
  -H "Content-Type: application/json" \
  -d '{
    "question": "How do I get started?",
    "provider": "openai",
    "search": true,
    "conversation_id": "user123"
  }'
```

Response:
```json
{
  "answer": "To get started...",
  "sources": ["docs/guide/getting-started.md", "docs/guide/installation.md"],
  "provider": "openai",
  "tokens_used": 245,
  "conversation_id": "user123",
  "timestamp": "2024-03-12T10:30:00.000"
}
```

### Search Documentation

```bash
curl -X POST http://localhost:8000/api/ai/search \
  -H "Content-Type: application/json" \
  -d '{"query": "installation", "max_chunks": 3}'
```

### Get Session Info

```bash
curl http://localhost:8000/api/ai/session/user123
```

## Architecture Decisions

### Docs-Only Context
- All context comes from `./docs/src/**/*.md`
- No external knowledge or training data
- Ensures accuracy and traceability
- Optional: Tavily search for external context

### Multi-Provider Support
- **OpenAI (Default)**: GPT-4 for best quality
- **Cohere**: Command-R for cost efficiency
- Easy provider switching via UI
- Seamless fallback if one fails

### Session Management
- Conversations stored in-memory (Dict)
- TTL-based cleanup to prevent memory leaks
- Optional: Persist to disk for recovery
- LocalStorage on client for UI state

### Deployment Strategy
- **Single Container**: Web server + AI all-in-one
- **Kubernetes-Ready**: Can split into separate services
- **Scalable**: Session cache can move to Redis/Memcached

## Next Steps (Phase 4)

1. **Add Web Sockets** for streaming responses
2. **Implement Redis** for distributed sessions
3. **Add Logging** with structured logging
4. **Monitor Performance** with Application Insights
5. **Kubernetes** deployment manifests
6. **Advanced UI Features**:
   - Conversation management sidebar
   - Export conversations as PDF
   - Share conversation links
   - Custom system prompts

## Troubleshooting

### API Key Issues
```bash
# Check if keys are loaded
curl http://localhost:8000/api/ai-help/config

# Should show available providers
```

### Docs Not Loading
```bash
# Verify docs path exists
ls -la docs/src/

# Check AIHelpMe logs for load errors
```

### Session Memory Growing
```julia
# Trigger cleanup manually
using MyTemplate.AIHelpMe
cleaned = AIHelpMe.cleanup_expired_sessions()
println("Cleaned $cleaned sessions")
```

### Docker Build Issues
```bash
# Rebuild without cache
docker-compose build --no-cache

# Check logs
docker-compose logs web
```

## Support

- 📚 [Genie Framework](https://genieframework.com)
- 🤖 [OpenAI API Docs](https://platform.openai.com/docs)
- 🧠 [Cohere API Docs](https://docs.cohere.com)
- 🔍 [Tavily Search API](https://tavily.com)

---

**Implementation Complete!** ✨ You now have a fully functional AI Research Helper integrated with your Julia documentation site.
