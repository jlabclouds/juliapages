# 🚀 Quick Reference - AI Research Helper

## ⚡ Quick Start (60 seconds)

```bash
# 1. Copy env template
cp .env.example .env

# 2. Add API keys to .env
nano .env
# Add: OPENAI_API_KEY, COHERE_API_KEY, TAVILY_API_KEY

# 3. Start server
source .env
julia --project server.jl

# 4. Open in browser
# http://localhost:8000/ai-help
```

## 🐳 Docker Quick Start

```bash
# Copy .env, add API keys, then:
docker-compose up --build

# Access: http://localhost:8000/ai-help
```

---

## 🔑 Getting API Keys (5 minutes each)

### OpenAI
```
1. Go to platform.openai.com/api-keys
2. Click "Create new secret key"
3. Copy value to OPENAI_API_KEY
```

### Cohere  
```
1. Go to dashboard.cohere.com
2. Navigate to API Keys
3. Create key, copy to COHERE_API_KEY
```

### Tavily
```
1. Go to tavily.com
2. Sign up → Get API key
3. Copy to TAVILY_API_KEY
```

---

## 📂 File Structure at a Glance

```
AIHelpMe/                    Backend AI Engine
├── core.jl                  Query orchestration
├── llm_interface.jl         Provider selection
├── providers/               OpenAI, Cohere
├── search/                  Tavily integration  
├── context/                 Doc indexing & sessions
└── api_handlers.jl          HTTP handlers

AIHelpUI/                    Frontend Chat
├── routes.jl                Page rendering
└── static/
    ├── js/chat.js           Chat logic
    └── css/aihelp.css       Styling
```

---

## 🌐 Endpoints Cheat Sheet

```bash
# Query AI
curl -X POST http://localhost:8000/api/ai/query \
  -H "Content-Type: application/json" \
  -d '{
    "question": "How do I get started?",
    "provider": "openai",
    "search": true,
    "conversation_id": "user1"
  }'

# Get config
curl http://localhost:8000/api/ai-help/config

# Search docs
curl -X POST http://localhost:8000/api/ai/search \
  -H "Content-Type: application/json" \
  -d '{"query": "routing", "max_chunks": 5}'
```

---

## ⚙️ Key Configuration

| Variable | Default | Purpose |
|----------|---------|---------|
| OPENAI_API_KEY | - | Required |
| OPENAI_MODEL | gpt-4 | LLM model |
| COHERE_API_KEY | - | Optional |
| COHERE_MODEL | command-r-plus | LLM model |
| TAVILY_API_KEY | - | Optional (search) |
| MAX_TOKENS | 2048 | Response limit |
| MAX_DOC_CHUNKS | 5 | Context docs |
| SESSION_TTL | 3600 | Session timeout |
| ENABLE_SEARCH | true | Toggle search |

---

## 🔧 Development Commands

```bash
# Install dependencies
julia --project -e "using Pkg; Pkg.instantiate()"

# Run server
julia --project server.jl

# Run tests (after implementing)
julia --project -e "using Pkg; Pkg.test()"

# Access REPL
julia --project

# In REPL:
julia> using MyTemplate
julia> using MyTemplate.AIHelpMe
julia> AIHelpMe.initialize(config)
julia> AIHelpMe.query("Question here?")
```

---

## 🎯 Core Functions Reference

### Query AI
```julia
response = AIHelpMe.query(
    "Your question",
    provider="openai",
    search=true,
    conversation_id="user123"
)
# Returns AIResponse struct with:
# - answer::String
# - sources::Vector{String}
# - provider::String
# - tokens_used::Int
```

### Initialize
```julia
AIHelpMe.initialize(Dict(
    "providers" => Dict("openai" => true, "cohere" => true),
    "tavily_enabled" => true,
    "max_tokens" => 2048,
    "max_doc_chunks" => 5,
    "docs_path" => "./docs/src",
    "session_ttl" => 3600,
    "cache_sessions" => true
))
```

### Get Config
```julia
config = AIHelpMe.get_config()
# Returns AIHelpMeConfig struct
```

---

## 🐛 Troubleshooting Checklist

- [ ] API keys set in .env?
- [ ] `source .env` before running?
- [ ] Server running (port 8000 free)?
- [ ] Can access http://localhost:8000?
- [ ] Can access http://localhost:8000/ai-help?
- [ ] Can hit http://localhost:8000/api/ai-help/config?

---

## 📊 Performance Tips

1. **Reduce context size** for faster responses
   ```bash
   MAX_DOC_CHUNKS=3
   ```

2. **Use GPT-3.5** for speed (vs GPT-4)
   ```bash
   OPENAI_MODEL=gpt-3.5-turbo
   ```

3. **Disable search** if not needed
   ```bash
   ENABLE_SEARCH=false
   ```

4. **Cache session aggressively**
   ```bash
   SESSION_TTL=7200
   ```

---

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| `AI_HELP_SETUP.md` | Complete setup guide |
| `IMPLEMENTATION_SUMMARY.md` | Full documentation |
| `DEPLOYMENT.md` | Deploy to cloud |
| `this file` | Quick reference |

---

## 🚨 Common Issues

**"API key not found"**
```bash
# Make sure environment is sourced:
source .env
echo $OPENAI_API_KEY  # Should print key
```

**"Connection refused"**
```bash
# Check if server is running:
curl http://localhost:8000/api/health
```

**"Docs not indexed"**
```julia
julia> AIHelpMe.DOCS_INDEX[]  # Check contents
julia> reload reload doc loading with:
julia> AIHelpMe.load_docs_index("./docs/src")
```

**"No providers available"**
```julia
julia> AIHelpMe.get_available_providers()
# Should show ["openai", "cohere"]
```

---

## 📞 Support

- **Setup Questions:** See `AI_HELP_SETUP.md`
- **Technical Details:** See `IMPLEMENTATION_SUMMARY.md`
- **Deployment:** See `DEPLOYMENT.md`
- **Code:** Check `src/AIHelpMe/` and `src/AIHelpUI/`

---

**Last Updated:** March 12, 2026  
**Version:** 1.0 (Phase 1-3 Complete)
