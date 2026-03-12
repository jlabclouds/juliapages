"""
Documentation context management - loads and searches project docs.
"""

"""Global docs index."""
const DOCS_INDEX = Ref(Dict{String, String}())

"""
    load_docs_index(docs_path::String)

Load all markdown documentation into memory index.
"""
function load_docs_index(docs_path::String)
    index = Dict{String, String}()
    
    if !isdir(docs_path)
        @warn "Docs path not found: $docs_path"
        return
    end
    
    # Recursively walk markdown files
    for (root, dirs, files) in walkdir(docs_path)
        for file in files
            if endswith(file, ".md")
                filepath = joinpath(root, file)
                try
                    content = read(filepath, String)
                    # Store with relative path as key
                    rel_path = relpath(filepath, docs_path)
                    index[rel_path] = content
                catch e
                    @warn "Error loading doc file $filepath: $e"
                end
            end
        end
    end
    
    DOCS_INDEX[] = index
    @info "Loaded $(length(index)) documentation files"
end

"""
    search_docs(query::String; max_chunks=5)::Vector{String}

Full-text search against documentation with BM25-like scoring.
"""
function search_docs(query::String; max_chunks=5)::Vector{String}
    query_lower = lowercase(query)
    query_terms = split(query_lower, r"\W+")
    
    # Score each document
    scored_docs = Tuple{String, Int, String}[]
    
    for (path, content) in DOCS_INDEX[]
        content_lower = lowercase(content)
        score = 0
        
        # Simple term matching with relevance weighting
        for term in query_terms
            if !isempty(term) && length(term) > 2  # Skip short words
                count = length(collect(eachmatch(Regex("\\b$term\\b"), content_lower)))
                score += count * 10
            end
        end
        
        if score > 0
            push!(scored_docs, (path, score, content))
        end
    end
    
    # Sort by score descending
    sort!(scored_docs, by=x -> x[2], rev=true)
    
    # Extract top chunks with some context
    chunks = String[]
    for (path, score, content) in scored_docs[1:min(max_chunks, length(scored_docs))]
        # Extract first 500 chars and cite the source
        preview = strip(content[1:min(500, length(content))])
        chunk = "**$path**: " * preview * (length(content) > 500 ? "..." : "")
        push!(chunks, chunk)
    end
    
    return chunks
end

"""
    search_docs_for_context(query::String)::String

Search docs and return formatted context for LLM.
"""
function search_docs_for_context(query::String)::String
    chunks = search_docs(query)
    
    if isempty(chunks)
        return "No matching documentation found for: $query"
    end
    
    context = join(chunks, "\n\n")
    return context
end
