#!/usr/bin/env julia
# MyTemplate Development Server
# Starts the web server with development settings

using Pkg

# Ensure project is instantiated
Pkg.instantiate()

# Load the module
using MyTemplate
using MyTemplate.AIHelpMe

println("""
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  🚀 MyTemplate Development Server with AI Help
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  📍 Server: http://localhost:8000
  🤖 AI Help: http://localhost:8000/ai-help
  🔧 Environment: development
  📚 Docs: http://localhost:8000/docs
  🐛 Debug: enabled

  Press Ctrl+C to stop the server

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
""")

# Initialize AIHelpMe configuration
ai_config = Dict(
    "providers" => Dict(
        "openai" => Dict(
            "model" => get(ENV, "OPENAI_MODEL", "gpt-4"),
            "temperature" => 0.7
        ),
        "cohere" => Dict(
            "model" => get(ENV, "COHERE_MODEL", "command-r-plus"),
            "temperature" => 0.7
        )
    ),
    "tavily_enabled" => get(ENV, "ENABLE_SEARCH", "true") == "true",
    "max_tokens" => parse(Int, get(ENV, "MAX_TOKENS", "2048")),
    "max_doc_chunks" => parse(Int, get(ENV, "MAX_DOC_CHUNKS", "5")),
    "docs_path" => get(ENV, "DOCS_PATH", "./docs/src"),
    "session_ttl" => parse(Int, get(ENV, "SESSION_TTL", "3600")),
    "cache_sessions" => get(ENV, "CACHE_SESSIONS", "true") == "true"
)

try
    # Initialize AI Help
    println("Initializing AI Help system...")
    AIHelpMe.initialize(ai_config)
    println("✓ AI Help initialized successfully")
    
    # Start a background task for session cleanup
    # errormonitor(@async AIHelpMe.cleanup_old_sessions())
    
    # Start development server
    MyTemplate.serve(host="0.0.0.0", port=8000)
    
catch e
    if e isa InterruptException
        println("\n\n👋 Server stopped gracefully")
    else
        println("Error: $e")
        rethrow()
    end
end
