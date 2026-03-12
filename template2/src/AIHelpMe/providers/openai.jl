"""
OpenAI API integration for AIHelpMe.
"""

"""
    query_openai(question::String, context::String, history::Vector{Dict})::AIResponse

Query OpenAI API with docs context.
"""
function query_openai(question::String, context::String, history::Vector{Dict})::AIResponse
    provider = get_provider("openai")
    
    if isempty(provider.api_key)
        error("OPENAI_API_KEY not set")
    end
    
    # Format messages
    system_prompt = format_system_prompt()
    messages = format_messages_for_api(system_prompt, history, context)
    
    # API request
    url = "https://api.openai.com/v1/chat/completions"
    headers = [
        "Authorization" => "Bearer $(provider.api_key)",
        "Content-Type" => "application/json"
    ]
    
    body = Dict(
        "model" => provider.model,
        "messages" => messages,
        "temperature" => provider.temperature,
        "max_tokens" => provider.max_tokens,
        "top_p" => 0.9,
        "frequency_penalty" => 0.0,
        "presence_penalty" => 0.0
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
            error("OpenAI API error: $(String(response.body))")
        end
        
        result = JSON.parse(String(response.body))
        
        answer = result["choices"][1]["message"]["content"]
        tokens = get(result["usage"], "total_tokens", 0)
        
        # Extract sources from context
        sources = extract_sources(context)
        
        return AIResponse(
            answer,
            sources,
            "openai",
            tokens,
            0.95,  # High confidence for OpenAI
            "default",
            now()
        )
        
    catch e
        error("OpenAI query failed: $e")
    end
end

"""
    extract_sources(context::String)::Vector{String}

Extract source citations from context.
"""
function extract_sources(context::String)::Vector{String}
    sources = String[]
    
    # Parse markdown-formatted sources
    for line in split(context, "\n")
        if startswith(line, "- ") && (contains(line, ".md") || contains(line, "example"))
            push!(sources, strip(line[3:end]))
        end
    end
    
    return unique(sources)
end
