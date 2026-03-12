# AI Research Helper - Setup & Usage Guide

## 🚀 Quick Start

### Local Development (Recommended)

1. **Copy environment template:**
   ```bash
   cp .env.example .env
   ```

2. **Add your API keys to `.env`:**
   ```bash
   # Edit .env with your API keys
   nano .env
   ```
   
   Required keys:
   - `OPENAI_API_KEY` - Get from https://platform.openai.com/api-keys
   - `COHERE_API_KEY` - Get from https://dashboard.cohere.com/
   - `TAVILY_API_KEY` - Get from https://tavily.com/

3. **Load environment and start server:**
   ```bash
   # Using bash/zsh
   set -a && source .env && set +a && julia --project server.jl
   
   # Or on Windows/PowerShell
   $env:OPENAI_API_KEY="your-key-here"
   $env:COHERE_API_KEY="your-key-here"
   $env:TAVILY_API_KEY="your-key-here"
   julia --project server.jl
   ```

4. **Access the application:**
   - Web Server: http://localhost:8000
   - AI Help: http://localhost:8000/ai-help
   - API Config: http://localhost:8000/api/ai-help/config

---

## 🐳 Docker Deployment

### Local Docker Development

1. **Create `.env` file with your API keys** (skip if already done)

2. **Build and run with Docker Compose:**
   ```bash
   docker-compose up --build
   ```

3. **Access the application:**
   - http://localhost:8000

### Cloud Deployment (Docker)

1. **Build Docker image:**
   ```bash
   docker build -f deployment/Dockerfile -t mytemplate-ai:latest .
   ```

2. **Deploy to:**
   - **Heroku:** See DEPLOYMENT.md
   - **DigitalOcean:** See DEPLOYMENT.md
   - **Azure Container Instances:** See DEPLOYMENT.md
   - **AWS EC2:** See DEPLOYMENT.md

---

## 📖 AI Research Helper Features

### Access Points

- **Web UI:** http://localhost:8000/ai-help
- **Sidebar Link:** "🤖 AI Help" in the navigation menu

### Features

✅ **Multi-Provider LLM Support**
- OpenAI (GPT-4, GPT-3.5)
- Cohere (command-r-plus, etc.)

✅ **Web Search Integration**
- Powered by Tavily API
- Toggle search on/off per query

✅ **Documentation-Only Context**
- Automatically indexes project docs
- Provides source citations
- 5-document context window (configurable)

✅ **Session Management**
- Persistent conversation history
- Automatic session cleanup
- 1-hour TTL (default)

---

## 🔧 Configuration

### Environment Variables

```bash
# LLM Provider Keys
OPENAI_API_KEY=sk-...                 # Required for OpenAI provider
OPENAI_MODEL=gpt-4                    # Model to use (default: gpt-4)

COHERE_API_KEY=...                    # Required for Cohere provider
COHERE_MODEL=command-r-plus           # Model to use (default: command-r-plus)

TAVILY_API_KEY=...                    # Required for web search
ENABLE_SEARCH=true                    # Enable/disable search (default: true)

# AI Configuration
MAX_TOKENS=2048                       # Max tokens per response (default: 2048)
MAX_DOC_CHUNKS=5                      # Max doc chunks for context (default: 5)
SESSION_TTL=3600                      # Session timeout in seconds (default: 3600)
CACHE_SESSIONS=true                   # Cache sessions (default: true)
DOCS_PATH=./docs/src                  # Path to documentation

# Server Configuration
APP_ENV=development                   # Environment: development, docker, production
SERVER_PORT=8000                      # Server port
SERVER_HOST=0.0.0.0                   # Server host
```

### Configuration Files

- **Local Dev:** `config/local.toml`
- **Docker Dev:** `config/docker.toml`
- **Production:** `config/cloud.toml`

---

## 🌐 API Endpoints

### Query AI Help

**POST** `/api/ai/query`

Request:
```json
{
  "question": "How do I get started?",
  "provider": "openai",
  "search": true,
  "conversation_id": "user123"
}
```

Response:
```json
{
  "answer": "Here's how to get started...",
  "sources": ["getting-started.md", "tutorial.md"],
  "provider": "openai",
  "tokens_used": 245,
  "conversation_id": "user123",
  "timestamp": "2024-03-12T10:30:00"
}
```

### Get Configuration

**GET** `/api/ai-help/config`

Response:
```json
{
  "providers": ["openai", "cohere"],
  "tavily_enabled": true,
  "max_tokens": 2048,
  "session_ttl": 3600,
  "doc_count": 12
}
```

### Get Session Info

**GET** `/api/ai/session/:id`

Response:
```json
{
  "id": "user123",
  "first_question": "How do I get started?",
  "message_count": 5,
  "created_at": "2024-03-12T10:00:00",
  "updated_at": "2024-03-12T10:30:00",
  "token_count": 1250
}
```

### Search Documentation

**POST** `/api/ai/search`

Request:
```json
{
  "query": "routing",
  "max_chunks": 5
}
```

Response:
```json
{
  "query": "routing",
  "results": ["guide/routing.md: Learn about ...", "..."],
  "count": 3
}
```

---

## 🔑 Getting API Keys

### OpenAI
1. Go to https://platform.openai.com/api-keys
2. Click "Create new secret key"
3. Copy and save securely

### Cohere
1. Go to https://dashboard.cohere.com/
2. Navigate to API Keys
3. Create new key
4. Copy and save securely

### Tavily
1. Go to https://tavily.com/
2. Sign up for account
3. Get API key from dashboard

---

## 📝 Troubleshooting

### API Keys Not Working

```bash
# Verify keys are loaded:
julia> ENV["OPENAI_API_KEY"]

# Reload environment:
source .env
```

### Documentation Not Indexed

```julia
julia> using MyTemplate
julia> using MyTemplate.AIHelpMe
julia> AIHelpMe.DOCS_INDEX[]  # Check indexed docs
```

### No Response from API

```bash
# Check server is running:
curl http://localhost:8000/api/health

# Check config:
curl http://localhost:8000/api/ai-help/config
```

### Session Not Persisting

- Ensure `CACHE_SESSIONS=true` in environment
- Check `SESSION_TTL` is not too short (default: 3600 seconds)

---

## 📚 Project Structure

```
src/
├── MyTemplate.jl                 # Main module
├── routes.jl                     # Web routes + AI endpoints
├── AIHelpMe/                     # AI Backend Module
│   ├── AIHelpMe.jl              # Entry point
│   ├── core.jl                  # Core query logic
│   ├── llm_interface.jl         # Provider abstraction
│   ├── providers/
│   │   ├── openai.jl            # OpenAI integration
│   │   └── cohere.jl            # Cohere integration
│   ├── search/
│   │   └── tavily_search.jl     # Web search
│   ├── context/
│   │   ├── doc_context.jl       # Doc indexing
│   │   └── session_cache.jl     # Session management
│   └── api_handlers.jl          # API request handlers
└── AIHelpUI/                     # Frontend Module
    ├── routes.jl                # UI routes
    └── static/
        ├── js/chat.js           # Chat logic
        └── css/aihelp.css       # Styling

docs/src/                         # Documentation (auto-indexed)
deployment/
├── Dockerfile                    # Container image
└── docker-compose.yml           # Local orchestration

.env.example                      # Environment template
config/
├── local.toml                    # Development config
├── docker.toml                   # Docker config
└── cloud.toml                    # Production config
```

---

## 🚀 Next Steps

1. **Start the server** with API keys configured
2. **Visit** http://localhost:8000/ai-help
3. **Ask a question** about your documentation
4. **Explore** different providers and search options
5. **Deploy** using Docker when ready

---

## 📖 Documentation

- Full docs: http://localhost:8000/docs
- API Reference: http://localhost:8000/api
- Getting Started: http://localhost:8000/guide/getting-started
- Deployment: See `DEPLOYMENT.md`

---

## 💡 Tips

- **Use shift+enter** for newlines in chat
- **Press enter** to send message
- **Toggle search** on/off depending on needs
- **Switch providers** to compare responses
- **View sources** to verify documentation

---

## 🤝 Support

For issues or questions:
- Check the docs at http://localhost:8000/docs
- Review logs in the terminal
- See troubleshooting section above
