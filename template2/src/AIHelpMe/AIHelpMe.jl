"""
    AIHelpMe

AI-powered documentation research helper with multi-provider LLM support.

Provides intelligent Q&A over project documentation using:
- OpenAI & Cohere LLMs
- Tavily web search
- Docs-only context management
- Session-based caching

# Quick Start:
```julia
using AIHelpMe

# Initialize with config
AIHelpMe.initialize(config)

# Ask a question
response = AIHelpMe.query(
    "How do I get started?",
    provider="openai",
    search=true,
    conversation_id="user123"
)

# Get response with citations
println(response.answer)
println("Sources: \$(response.sources)")
```
"""
module AIHelpMe

using HTTP, JSON, Dates, UUIDs

export initialize, query, update_config, get_session, clear_session
export OpenAIProvider, CohereProvider, TavilySearch, DocContext

# Configuration holder
mutable struct AIHelpMeConfig
    providers::Dict{String, Any}
    tavily_enabled::Bool
    max_tokens::Int
    max_doc_chunks::Int
    docs_path::String
    session_ttl::Int
    cache_sessions::Bool
end

# Global state
const GLOBAL_CONFIG = Ref{AIHelpMeConfig}()
const SESSIONS = Dict{String, Dict}()

include("core.jl")
include("llm_interface.jl")
include("providers/openai.jl")
include("providers/cohere.jl")
include("search/tavily_search.jl")
include("context/doc_context.jl")
include("context/session_cache.jl")
include("api_handlers.jl")

"""
    initialize(config::Dict)

Initialize AIHelpMe with configuration.
"""
function initialize(config::Dict)
    global GLOBAL_CONFIG
    
    GLOBAL_CONFIG[] = AIHelpMeConfig(
        get(config, "providers", Dict("openai" => true, "cohere" => true)),
        get(config, "tavily_enabled", true),
        get(config, "max_tokens", 2048),
        get(config, "max_doc_chunks", 5),
        get(config, "docs_path", "./docs/src"),
        get(config, "session_ttl", 3600),
        get(config, "cache_sessions", true)
    )
    
    # Load documentation index
    load_docs_index(GLOBAL_CONFIG[].docs_path)
    
    return true
end

"""
    query(question::String; provider::String="openai", search::Bool=true, conversation_id::String="default")

Query the AI help system.
"""
function query(
    question::String;
    provider::String="openai",
    search::Bool=true,
    conversation_id::String="default"
)
    # Get or create session
    session = get_or_create_session(conversation_id)
    
    # Add to conversation history
    push!(session["messages"], Dict("role" => "user", "content" => question))
    
    # Fetch relevant documentation
    doc_chunks = search_docs(question, max_chunks=GLOBAL_CONFIG[].max_doc_chunks)
    
    # Optional: web search for additional context
    search_results = String[]
    if search && GLOBAL_CONFIG[].tavily_enabled
        search_results = tavily_search(question)
    end
    
    # Prepare context
    context = build_context(doc_chunks, search_results)
    
    # Get LLM response
    response = if provider == "openai"
        query_openai(question, context, session["messages"])
    elseif provider == "cohere"
        query_cohere(question, context, session["messages"])
    else
        error("Unknown provider: $provider")
    end
    
    # Add assistant response to history
    push!(session["messages"], Dict("role" => "assistant", "content" => response.answer))
    
    # Update session timestamp
    session["updated_at"] = now()
    
    return response
end

"""
    update_config(config::Dict)

Update AIHelpMe configuration at runtime.
"""
function update_config(config::Dict)
    initialize(config)
end

"""
    get_session(conversation_id::String)

Retrieve a session by ID.
"""
function get_session(conversation_id::String)
    return get(SESSIONS, conversation_id, nothing)
end

"""
    clear_session(conversation_id::String)

Clear a session from cache.
"""
function clear_session(conversation_id::String)
    delete!(SESSIONS, conversation_id)
end

"""
    get_config()

Get current AIHelpMe configuration (internal use).
"""
function get_config()
    return GLOBAL_CONFIG[]
end

end # module
