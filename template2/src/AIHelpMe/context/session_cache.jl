"""
Session cache management for AIHelpMe conversations.
"""

"""
    cleanup_old_sessions()

Periodically clean up expired sessions (run in background).
"""
function cleanup_old_sessions()
    while true
        sleep(300)  # Run every 5 minutes
        try
            deleted = cleanup_expired_sessions()
            if deleted > 0
                @info "Cleaned up $deleted expired sessions"
            end
        catch e
            @warn "Error during session cleanup: $e"
        end
    end
end

"""
    save_session_to_file(conversation_id::String, filepath::String)

Persist session to JSON file for recovery.
"""
function save_session_to_file(conversation_id::String, filepath::String)
    session = get_session(conversation_id)
    
    if isnothing(session)
        error("Session not found: $conversation_id")
    end
    
    # Convert to JSON-serializable format
    data = Dict(
        "id" => session["id"],
        "messages" => session["messages"],
        "created_at" => string(session["created_at"]),
        "updated_at" => string(session["updated_at"]),
        "token_count" => session["token_count"]
    )
    
    write(filepath, JSON.json(data, 2))
end

"""
    load_session_from_file(filepath::String)::Dict

Load session from persistent storage.
"""
function load_session_from_file(filepath::String)::Dict
    if !isfile(filepath)
        error("Session file not found: $filepath")
    end
    
    data = JSON.parse(read(filepath, String))
    
    # Reconstruct session with proper types
    session = Dict(
        "id" => data["id"],
        "messages" => data["messages"],
        "created_at" => DateTime(data["created_at"]),
        "updated_at" => DateTime(data["updated_at"]),
        "token_count" => data["token_count"]
    )
    
    return session
end

"""
    get_conversation_summary(conversation_id::String)::Dict

Get a brief summary of conversation for display.
"""
function get_conversation_summary(conversation_id::String)::Dict
    session = get_session(conversation_id)
    
    if isnothing(session)
        return Dict()
    end
    
    messages = session["messages"]
    user_messages = filter(m -> m["role"] == "user", messages)
    
    first_question = !isempty(user_messages) ? user_messages[1]["content"] : "New conversation"
    
    return Dict(
        "id" => conversation_id,
        "first_question" => first_question,
        "message_count" => length(messages),
        "created_at" => session["created_at"],
        "updated_at" => session["updated_at"],
        "token_count" => session["token_count"]
    )
end
