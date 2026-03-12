"""
Tavily search integration for AIHelpMe.
"""

"""
    tavily_search(query::String; max_results=3)::Vector{String}

Search using Tavily API and return formatted results.
"""
function tavily_search(query::String; max_results=3)::Vector{String}
    api_key = get(ENV, "TAVILY_API_KEY", "")
    
    if isempty(api_key)
        @warn "TAVILY_API_KEY not set, skipping search"
        return String[]
    end
    
    url = "https://api.tavily.com/search"
    
    body = Dict(
        "api_key" => api_key,
        "query" => query,
        "max_results" => max_results,
        "include_answer" => true
    )
    
    try
        response = HTTP.post(
            url,
            ["Content-Type" => "application/json"],
            JSON.json(body);
            timeout=10,
            status_exception=false
        )
        
        if response.status != 200
            @warn "Tavily API error: $(String(response.body))"
            return String[]
        end
        
        result = JSON.parse(String(response.body))
        
        results = String[]
        
        # Add direct answer if available
        if haskey(result, "answer") && !isempty(result["answer"])
            push!(results, "**Search Summary**: " * result["answer"])
        end
        
        # Add top results
        for item in get(result, "results", [])
            formatted = "- [$(item["title"])]($(item["url"])): $(item["content"])"
            push!(results, formatted)
        end
        
        return results
        
    catch e
        @warn "Tavily search error: $e"
        return String[]
    end
end
