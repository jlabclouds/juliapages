"""
API route handlers for AIHelpMe.
"""

"""
    handle_query(body_dict::Dict)::String

Handle AI query from request body.
"""
function handle_query(body_dict::Dict)::String
    try
        question = get(body_dict, "question", "")
        provider = get(body_dict, "provider", "openai")
        search = get(body_dict, "search", true)
        conversation_id = get(body_dict, "conversation_id", "default")
        
        if isempty(question)
            return JSON.json(Dict(
                :error => "Question required"
            ))
        end
        
        # Query AIHelpMe
        response = query(
            question,
            provider=provider,
            search=search,
            conversation_id=conversation_id
        )
        
        return JSON.json(Dict(
            :answer => response.answer,
            :sources => response.sources,
            :provider => response.provider,
            :tokens_used => response.tokens_used,
            :conversation_id => conversation_id,
            :timestamp => string(response.timestamp)
        ))
        
    catch e
        return JSON.json(Dict(
            :error => string(e)
        ))
    end
end

"""
    handle_session_info(conversation_id::String)::String

Get session information.
"""
function handle_session_info(conversation_id::String)::String
    try
        summary = get_conversation_summary(conversation_id)
        
        if isempty(summary)
            return JSON.json(Dict(
                :error => "Session not found"
            ))
        end
        
        return JSON.json(summary)
        
    catch e
        return JSON.json(Dict(
            :error => string(e)
        ))
    end
end

"""
    handle_config()::String

Get current AIHelpMe configuration.
"""
function handle_config()::String
    try
        config = get_config()
        
        return JSON.json(Dict(
            :providers => collect(keys(config.providers)),
            :tavily_enabled => config.tavily_enabled,
            :max_tokens => config.max_tokens,
            :session_ttl => config.session_ttl,
            :doc_count => length(DOCS_INDEX[])
        ))
        
    catch e
        return JSON.json(Dict(
            :error => string(e)
        ))
    end
end

"""
    handle_search_docs(body_dict::Dict)::String

Search documentation endpoint.
"""
function handle_search_docs(body_dict::Dict)::String
    try
        query_str = get(body_dict, "query", "")
        max_chunks = get(body_dict, "max_chunks", 5)
        
        if isempty(query_str)
            return JSON.json(Dict(
                :error => "Query required"
            ))
        end
        
        chunks = search_docs(query_str, max_chunks=max_chunks)
        
        return JSON.json(Dict(
            :query => query_str,
            :results => chunks,
            :count => length(chunks)
        ))
        
    catch e
        return JSON.json(Dict(
            :error => string(e)
        ))
    end
end
