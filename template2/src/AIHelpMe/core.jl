"""
Core AIHelpMe functionality and response structures.
"""

"""Data structure for AI responses."""
mutable struct AIResponse
    answer::String
    sources::Vector{String}
    provider::String
    tokens_used::Int
    confidence::Float64
    conversation_id::String
    timestamp::DateTime
end

"""
    build_context(doc_chunks::Vector{String}, search_results::Vector{String})::String

Build context string from documentation and search results.
"""
function build_context(doc_chunks::Vector{String}, search_results::Vector{String})::String
    context = "## Documentation Context\n\n"
    
    for chunk in doc_chunks
        context *= "- $chunk\n"
    end
    
    if !isempty(search_results)
        context *= "\n## Search Results\n\n"
        for result in search_results
            context *= "- $result\n"
        end
    end
    
    return context
end

"""
    get_or_create_session(conversation_id::String)::Dict

Get existing session or create new one.
"""
function get_or_create_session(conversation_id::String)::Dict
    if haskey(SESSIONS, conversation_id)
        return SESSIONS[conversation_id]
    end
    
    session = Dict(
        "id" => conversation_id,
        "messages" => [],
        "created_at" => now(),
        "updated_at" => now(),
        "token_count" => 0
    )
    
    SESSIONS[conversation_id] = session
    return session
end

"""
    cleanup_expired_sessions()

Remove sessions older than TTL.
"""
function cleanup_expired_sessions()
    config = get_config()
    ttl_seconds = config.session_ttl
    current_time = now()
    
    expired = String[]
    for (id, session) in SESSIONS
        age = Dates.value(current_time - session["updated_at"]) / 1000  # Convert to seconds
        if age > ttl_seconds
            push!(expired, id)
        end
    end
    
    for id in expired
        delete!(SESSIONS, id)
    end
    
    return length(expired)
end
