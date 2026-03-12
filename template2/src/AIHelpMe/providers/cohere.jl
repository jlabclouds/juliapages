"""
Cohere API integration for AIHelpMe.
"""

"""
    query_cohere(question::String, context::String, history::Vector{Dict})::AIResponse

Query Cohere API with docs context.
"""
function query_cohere(question::String, context::String, history::Vector{Dict})::AIResponse
    provider = get_provider("cohere")
    
    if isempty(provider.api_key)
        error("COHERE_API_KEY not set")
    end
    
    # Convert history to Cohere format (chat_history)
    chat_history = []
    for msg in history[1:end-1]  # Exclude the last user message
        push!(chat_history, Dict(
            "role" => msg["role"] == "user" ? "USER" : "CHATBOT",
            "message" => msg["content"]
        ))
    end
    
    # API request
    url = "https://api.cohere.ai/v1/chat"
    headers = [
        "Authorization" => "Bearer $(provider.api_key)",
        "Content-Type" => "application/json"
    ]
    
    body = Dict(
        "model" => provider.model,
        "message" => question,
        "chat_history" => chat_history,
        "documents" => parse_context_docs(context),
        "temperature" => provider.temperature,
        "max_tokens" => provider.max_tokens
    )
    
    try
        response = HTTP.post(
            url,
            headers,
            JSON.json(body);
            timeout=30,
            status_exception=false
        )
        
        if response.status != 200
            error("Cohere API error: $(String(response.body))")
        end
        
        result = JSON.parse(String(response.body))
        
        answer = result["text"]
        
        # Extract citations from Cohere response
        citations = get(result, "citations", [])
        sources = [c["text"] for c in citations]
        
        return AIResponse(
            answer,
            sources,
            "cohere",
            0,  # Cohere doesn't return token count in free tier
            0.90,
            "default",
            now()
        )
        
    catch e
        error("Cohere query failed: $e")
    end
end

"""
    parse_context_docs(context::String)::Vector{Dict}

Parse context string into Cohere document format.
"""
function parse_context_docs(context::String)::Vector{Dict}
    docs = []
    
    # Split into sections
    sections = split(context, "##")
    
    for (idx, section) in enumerate(sections[2:end])
        lines = split(strip(section), "\n")
        title = strip(lines[1])
        content = join(lines[2:end], "\n")
        
        push!(docs, Dict(
            "id" => string(idx),
            "title" => title,
            "snippet" => strip(content)
        ))
    end
    
    return docs
end
