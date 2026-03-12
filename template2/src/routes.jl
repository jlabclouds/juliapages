"""
Route handlers for the web server
"""

using JSON

"""
    setup_routes()

Configure all application routes.
"""
function setup_routes()
    # Home page
    route("/") do
        page_content = """
        <div class="hero-section">
            <h1>Welcome to MyTemplate</h1>
            <p class="subtitle">A professional Julia documentation template combining Pluto, Genie, and Documenter</p>
            <div class="cta-buttons">
                <a href="/docs" class="btn btn-primary">Read the Docs</a>
                <a href="https://github.com" class="btn btn-secondary">View on GitHub</a>
            </div>
        </div>
        
        <section class="features">
            <h2>Features</h2>
            <div class="feature-grid">
                <div class="feature-card">
                    <h3>📚 Interactive Notebooks</h3>
                    <p>Explore and run interactive Pluto notebooks directly in your browser</p>
                </div>
                <div class="feature-card">
                    <h3>📖 API Documentation</h3>
                    <p>Auto-generated API docs powered by Documenter.jl</p>
                </div>
                <div class="feature-card">
                    <h3>🚀 Web Framework</h3>
                    <p>Built on Genie for blazing fast performance</p>
                </div>
                <div class="feature-card">
                    <h3>🎨 Modern Design</h3>
                    <p>Responsive, accessible design following web standards</p>
                </div>
            </div>
        </section>
        
        <section class="quick-start">
            <h2>Quick Start</h2>
            <pre><code>using MyTemplate
MyTemplate.serve()</code></pre>
        </section>
        """
        
        html = get_base_template()
        html = replace(html, "::TITLE::" => "Home")
        html = replace(html, "::SIDEBAR::" => get_sidebar_html())
        html = replace(html, "::CONTENT::" => page_content)
        html = replace(html, "::FOOTER::" => get_footer_html())
        
        html
    end

    # Documentation index
    route("/docs") do
        docs_content = read_docs_index()
        page_content = markdown_to_html(docs_content)
        
        html = get_base_template()
        html = replace(html, "::TITLE::" => "Documentation")
        html = replace(html, "::SIDEBAR::" => get_sidebar_html())
        html = replace(html, "::CONTENT::" => page_content)
        html = replace(html, "::FOOTER::" => get_footer_html())
        
        html
    end

    # Documentation guide pages
    route("/guide/:page", method=GET) do
        page = string(payload(:page))
        docs_content = read_doc_page("guide", page)
        page_content = markdown_to_html(docs_content)
        
        html = get_base_template()
        html = replace(html, "::TITLE::" => titlecase(replace(page, "-" => " ")))
        html = replace(html, "::SIDEBAR::" => get_sidebar_html())
        html = replace(html, "::CONTENT::" => page_content)
        html = replace(html, "::FOOTER::" => get_footer_html())
        
        html
    end

    # Documentation tutorial pages
    route("/tutorials/:page", method=GET) do
        page = string(payload(:page))
        docs_content = read_doc_page("tutorials", page)
        page_content = markdown_to_html(docs_content)
        
        html = get_base_template()
        html = replace(html, "::TITLE::" => titlecase(replace(page, "-" => " ")))
        html = replace(html, "::SIDEBAR::" => get_sidebar_html())
        html = replace(html, "::CONTENT::" => page_content)
        html = replace(html, "::FOOTER::" => get_footer_html())
        
        html
    end

    # Documentation example pages
    route("/examples/:page", method=GET) do
        page = string(payload(:page))
        docs_content = read_doc_page("", page)
        page_content = markdown_to_html(docs_content)
        
        html = get_base_template()
        html = replace(html, "::TITLE::" => titlecase(replace(page, "-" => " ")))
        html = replace(html, "::SIDEBAR::" => get_sidebar_html())
        html = replace(html, "::CONTENT::" => page_content)
        html = replace(html, "::FOOTER::" => get_footer_html())
        
        html
    end

    # Documentation API reference pages
    route("/api/:page", method=GET) do
        page = string(payload(:page))
        docs_content = read_doc_page("api", page)
        page_content = markdown_to_html(docs_content)
        
        html = get_base_template()
        html = replace(html, "::TITLE::" => titlecase(replace(page, "-" => " ")))
        html = replace(html, "::SIDEBAR::" => get_sidebar_html())
        html = replace(html, "::CONTENT::" => page_content)
        html = replace(html, "::FOOTER::" => get_footer_html())
        
        html
    end

    # Tutorials page
    route("/tutorials") do
        """
        <div class="tutorials-container">
            <h1>Tutorials</h1>
            <ul>
                <li><a href="/tutorials/getting-started">Getting Started</a></li>
                <li><a href="/tutorials/advanced">Advanced Usage</a></li>
            </ul>
        </div>
        """
    end

    # Examples page
    route("/examples") do
        """
        <div class="examples-container">
            <h1>Examples</h1>
            <p>Explore example notebooks and use cases.</p>
        </div>
        """
    end

    # API Status endpoint
    route("/api/health", method=GET) do
        JSON.json(Dict("status" => "ok", "version" => "0.1.0"))
    end

    # Return version information
    route("/api/version", method=GET) do
        JSON.json(Dict(
            "name" => "MyTemplate",
            "version" => "0.1.0",
            "julia_version" => string(VERSION)
        ))
    end

    # AI Help endpoint - Process user queries with AI
    route("/api/ai-help", method=POST) do
        try
            request_data = Genie.Requests.jsonpayload()
            user_query = get(request_data, "query", "")
            page_context = get(request_data, "context", "")
            
            # Process the help request
            response = process_help_request(user_query, page_context)
            
            JSON.json(response)
        catch e
            error_response = Dict(
                "success" => false,
                "error" => "Failed to process help request",
                "details" => string(e)
            )
            HTTP.Response(400, JSON.json(error_response))
        end
    end

    # AI Help configuration endpoint - Return current config to frontend
    route("/api/ai-help/config", method=GET) do
        config = get_ai_help_config()
        response = Dict(
            "ui_style" => config["help_ui_style"],
            "ui_position" => config["help_ui_position"],
            "ui_theme" => config["help_ui_theme"],
            "help_scope" => config["help_scope"],
            "help_enabled" => config["help_enabled"],
            "ai_provider" => config["ai_provider"]
        )
        JSON.json(response)
    end

    # Static files - serve CSS
    route("/css/:filename", method=GET) do
        filename = payload(:filename)
        css_path = joinpath(dirname(dirname(@__FILE__)), "public", "css", filename)
        if isfile(css_path)
            css_content = read(css_path, String)
            Genie.Responses.text(css_content, "text/css")
        else
            Genie.Responses.text("/* File not found */", "text/css"; status=404)
        end
    end

    # Static files - serve JavaScript
    route("/js/:filename", method=GET) do
        filename = payload(:filename)
        js_path = joinpath(dirname(dirname(@__FILE__)), "public", "js", filename)
        if isfile(js_path)
            js_content = read(js_path, String)
            Genie.Responses.text(js_content, "text/javascript")
        else
            Genie.Responses.text("/* File not found */", "text/javascript"; status=404)
        end
    end

    nothing
end
