"""
AI Help UI routes and page rendering.
"""

"""
    setup_aihelp_routes()

Register AIHelpUI routes with Genie.
"""
function setup_aihelp_routes()
    # AI Help main page
    route("/ai-help") do
        render_aihelp_page()
    end

    # API endpoints for chat (handled by api_handlers in AIHelpMe)
    # These are registered separately in main routes.jl
    
    return true
end

"""
    render_aihelp_page()::String

Render the AI Help chat interface.
"""
function render_aihelp_page()::String
    html = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>AI Research Helper - MyTemplate</title>
        <link rel="stylesheet" href="/static/css/style.css">
        <link rel="stylesheet" href="/static/css/aihelp.css">
    </head>
    <body>
        <div class="aihelp-container">
            <!-- Header -->
            <header class="aihelp-header">
                <div class="header-content">
                    <h1>🤖 AI Research Helper</h1>
                    <p class="subtitle">Ask questions about the documentation</p>
                </div>
                <div class="header-controls">
                    <select id="provider-select" class="provider-selector">
                        <option value="openai">OpenAI</option>
                        <option value="cohere">Cohere</option>
                    </select>
                    <label class="search-toggle">
                        <input type="checkbox" id="enable-search" checked>
                        <span>Web Search</span>
                    </label>
                </div>
            </header>

            <!-- Main Chat Area -->
            <main class="aihelp-main">
                <!-- Chat Messages -->
                <div class="chat-messages" id="chat-messages">
                    <div class="message welcome">
                        <div class="message-content">
                            <p>👋 Welcome to the AI Research Helper!</p>
                            <p>Ask me anything about the documentation. I'll search the docs and provide helpful answers.</p>
                            <div class="quick-questions">
                                <button class="quick-btn" onclick="askQuestion('How do I get started?')">Get Started</button>
                                <button class="quick-btn" onclick="askQuestion('What features are available?')">Features</button>
                                <button class="quick-btn" onclick="askQuestion('How do I install this?')">Install</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Input Area -->
                <footer class="aihelp-footer">
                    <form id="chat-form" class="chat-input-form">
                        <div class="input-wrapper">
                            <textarea 
                                id="question-input" 
                                class="question-input"
                                placeholder="Ask a question..."
                                rows="1"></textarea>
                            <button type="submit" class="send-btn" id="send-btn">
                                <span>Send</span>
                                <span class="spinner" id="spinner" style="display:none;">⟳</span>
                            </button>
                        </div>
                        <div class="input-hints">
                            <small>💡 Tip: Press Shift+Enter for new line, Enter to send</small>
                        </div>
                    </form>
                </footer>
            </main>
        </div>

        <!-- Scripts -->
        <script src="/static/js/chat.js"></script>
        <script>
            // Initialize on page load
            document.addEventListener('DOMContentLoaded', function() {
                initializeChat();
                loadConversation();
            });
        </script>
    </body>
    </html>
    """
    return html
end

"""
    get_aihelp_html()::String

Get complete HTML for AI Help page (with layout).
"""
function get_aihelp_html()::String
    return render_aihelp_page()
end
