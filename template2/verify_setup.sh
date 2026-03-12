#!/bin/bash
# AI Research Helper - Setup Verification Script
# Run this to verify your installation is correct

echo "🔍 AI Research Helper - Setup Verification"
echo "=========================================="
echo ""

# Check Julia
echo "✓ Checking Julia installation..."
if ! command -v julia &> /dev/null; then
    echo "❌ Julia not found. Install from julia.julialang.org"
    exit 1
fi
echo "  Julia version: $(julia --version)"
echo ""

# Check .env file
echo "✓ Checking environment configuration..."
if [ ! -f ".env" ]; then
    if [ ! -f ".env.example" ]; then
        echo "❌ .env.example not found"
        exit 1
    fi
    echo "  ⚠️  .env not found. Creating from template..."
    cp .env.example .env
    echo "  Created .env - Update with your API keys!"
fi

# Check API keys
echo ""
echo "✓ Checking API keys..."
source .env 2>/dev/null || true

if [ -z "$OPENAI_API_KEY" ] || [ "$OPENAI_API_KEY" = "sk-your-api-key-here" ]; then
    echo "  ❌ OPENAI_API_KEY not set or demo value"
    echo "     Get key from: https://platform.openai.com/api-keys"
else
    echo "  ✅ OPENAI_API_KEY: configured (${OPENAI_API_KEY:0:10}...)"
fi

if [ -z "$COHERE_API_KEY" ] || [ "$COHERE_API_KEY" = "your-cohere-api-key-here" ]; then
    echo "  ⚠️  COHERE_API_KEY not set"
else
    echo "  ✅ COHERE_API_KEY: configured"
fi

if [ -z "$TAVILY_API_KEY" ] || [ "$TAVILY_API_KEY" = "your-tavily-api-key-here" ]; then
    echo "  ⚠️  TAVILY_API_KEY not set (search features disabled)"
else
    echo "  ✅ TAVILY_API_KEY: configured"
fi
echo ""

# Check file structure
echo "✓ Checking project structure..."
files=(
    "src/AIHelpMe/AIHelpMe.jl"
    "src/AIHelpMe/core.jl"
    "src/AIHelpMe/llm_interface.jl"
    "src/AIHelpMe/api_handlers.jl"
    "src/AIHelpMe/providers/openai.jl"
    "src/AIHelpMe/providers/cohere.jl"
    "src/AIHelpMe/search/tavily_search.jl"
    "src/AIHelpMe/context/doc_context.jl"
    "src/AIHelpMe/context/session_cache.jl"
    "src/AIHelpUI/routes.jl"
    "src/AIHelpUI/static/js/chat.js"
    "src/AIHelpUI/static/css/aihelp.css"
    "docker-compose.yml"
    "AI_HELP_SETUP.md"
    "IMPLEMENTATION_SUMMARY.md"
    "QUICK_REFERENCE_AI.md"
)

missing=0
for file in "${files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "  ❌ Missing: $file"
        ((missing++))
    fi
done

if [ $missing -eq 0 ]; then
    echo "  ✅ All required files present (${#files[@]} files)"
else
    echo "  ❌ Missing $missing files"
fi
echo ""

# Check Docker
echo "✓ Checking Docker installation..."
if command -v docker &> /dev/null; then
    echo "  ✅ Docker: $( docker --version)"
    if command -v docker-compose &> /dev/null; then
        echo "  ✅ Docker Compose: $(docker-compose --version)"
    else
        echo "  ⚠️  Docker Compose not found"
    fi
else
    echo "  ⚠️  Docker not found (optional for local dev)"
fi
echo ""

# Check documentation exists
echo "✓ Checking documentation..."
if [ -d "docs/src" ]; then
    doc_count=$(find docs/src -name "*.md" 2>/dev/null | wc -l)
    echo "  ✅ Documentation: $doc_count .md files found"
else
    echo "  ❌ docs/src directory not found"
fi
echo ""

# Summary
echo "=========================================="
echo "✅ Verification Complete!"
echo ""
echo "Next Steps:"
echo "1. Add API keys to .env (if not already done)"
echo "2. Run: source .env && julia --project server.jl"
echo "3. Visit: http://localhost:8000/ai-help"
echo ""
echo "Documentation:"
echo "- Setup: AI_HELP_SETUP.md"
echo "- Details: IMPLEMENTATION_SUMMARY.md"
echo "- Quick Start: QUICK_REFERENCE_AI.md"
echo ""
