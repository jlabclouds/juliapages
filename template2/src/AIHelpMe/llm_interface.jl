"""
LLM Provider interface and abstractions.
"""

"""Abstract base type for LLM providers."""
abstract type LLMProvider end

"""OpenAI provider."""
mutable struct OpenAIProvider <: LLMProvider
    api_key::String
    model::String
    temperature::Float64
    max_tokens::Int
end

"""Cohere provider."""
mutable struct CohereProvider <: LLMProvider
    api_key::String
    model::String
    temperature::Float64
    max_tokens::Int
end

"""
    get_provider(name::String)::LLMProvider

Get configured provider by name.
"""
function get_provider(name::String)::LLMProvider
    config = get_config()
    provider_config = get(config.providers, name, nothing)
    
    if isnothing(provider_config)
        error("Provider $name not configured")
    end
    
    if name == "openai"
        return OpenAIProvider(
            get(ENV, "OPENAI_API_KEY", ""),
            get(provider_config, "model", "gpt-4"),
            get(provider_config, "temperature", 0.7),
            config.max_tokens
        )
    elseif name == "cohere"
        return CohereProvider(
            get(ENV, "COHERE_API_KEY", ""),
            get(provider_config, "model", "command-r-plus"),
            get(provider_config, "temperature", 0.7),
            config.max_tokens
        )
    else
        error("Unknown provider: $name")
    end
end

"""
    format_system_prompt()::String

Create system prompt for documentation assistant.
"""
function format_system_prompt()::String
    return """You are a friendly and knowledgeable documentation assistant. 

Your role is to help users understand the project's documentation and features. 

Guidelines:
- Answer questions based on the provided documentation context
- If information is not in the docs, say so clearly
- Provide code examples when relevant
- Cite your sources when possible
- Be concise but thorough
- Use markdown for formatting
- Ask clarifying questions if needed"""
end

"""
    format_messages_for_api(system::String, history::Vector{Dict}, context::String)::Vector{Dict}

Format conversation history for API call.
"""
function format_messages_for_api(system::String, history::Vector{Dict}, context::String)::Vector{Dict}
    messages = [Dict("role" => "system", "content" => system)]
    
    # Add context as system message if available
    if !isempty(context)
        push!(messages, Dict(
            "role" => "system",
            "content" => "Additional context:\n\n$context"
        ))
    end
    
    # Add conversation history
    append!(messages, history)
    
    return messages
end
