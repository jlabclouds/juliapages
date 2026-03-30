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
                <a href="/notebooks" class="feature-card">
                    <h3>📚 Interactive Notebooks</h3>
                    <p>Explore and run interactive Pluto notebooks directly in your browser</p>
                </a>
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

    # Notebooks landing page
    route("/notebooks") do
        notebooks_content = """
        <div class="notebooks-container">
            <h1>📚 Interactive Notebooks</h1>
            <p class="subtitle">Explore interactive Pluto notebooks and learn by doing</p>
            
            <div class="notebooks-grid">
                <div class="notebook-card">
                    <h3>Welcome Guide</h3>
                    <p>Start here! Introduction to MyTemplate and key concepts of interactive notebooks.</p>
                    <a href="/notebooks/index" class="btn btn-primary">Open Notebook</a>
                </div>
                
                <div class="notebook-card">
                    <h3>Getting Started</h3>
                    <p>Step-by-step guide to installing, configuring, and running MyTemplate on your machine.</p>
                    <a href="/notebooks/getting-started" class="btn btn-primary">Open Notebook</a>
                </div>
                
                <div class="notebook-card">
                    <h3>Data Visualization</h3>
                    <p>Explore interactive data visualization examples using Plots.jl and StatsPlots.jl.</p>
                    <a href="/notebooks/visualization" class="btn btn-primary">Open Notebook</a>
                </div>
            </div>
            
            <div class="notebooks-info">
                <h2>About Pluto Notebooks</h2>
                <p>Pluto is a reactive environment for Julia. All cells are reactive, so whenever you change a variable, Pluto automatically re-runs the cells that depend on it. This makes it an ideal tool for teaching, learning, and exploring data.</p>
                <p><a href="https://plutojl.org/" target="_blank">Learn more about Pluto →</a></p>
            </div>
        </div>
        """
        
        html = get_base_template()
        html = replace(html, "::TITLE::" => "Interactive Notebooks")
        html = replace(html, "::SIDEBAR::" => get_sidebar_html())
        html = replace(html, "::CONTENT::" => notebooks_content)
        html = replace(html, "::FOOTER::" => get_footer_html())
        
        html
    end

    # Individual notebook pages
    route("/notebooks/:notebook", method=GET) do
        notebook_name = string(payload(:notebook))
        notebook_path = joinpath(dirname(dirname(@__FILE__)), "..", "pages", "$(notebook_name).pluto.jl")
        
        if isfile(notebook_path)
            notebook_content = read(notebook_path, String)
            
            # Create readable title from notebook name
            title_map = Dict(
                "index" => "Welcome Guide",
                "getting-started" => "Getting Started",
                "visualization" => "Data Visualization"
            )
            
            title = get(title_map, notebook_name, titlecase(replace(notebook_name, "-" => " ")))
            
            page_content = """
            <div class="notebook-viewer">
                <div class="notebook-header">
                    <h1>$title</h1>
                    <p class="notebook-meta">Pluto Interactive Notebook</p>
                </div>
                
                <div class="notebook-info-box">
                    <p>This is a Pluto notebook. To interact with this notebook, download it and open it with Pluto:</p>
                    <pre><code>using Pluto
Pluto.run()</code></pre>
                    <p><a href="/pages/$(notebook_name).pluto.jl" download>Download Notebook</a></p>
                </div>
                
                <div class="notebook-preview">
                    <h2>Notebook Preview</h2>
                    <pre><code>$notebook_content</code></pre>
                </div>
            </div>
            """
            
            html = get_base_template()
            html = replace(html, "::TITLE::" => title)
            html = replace(html, "::SIDEBAR::" => get_sidebar_html())
            html = replace(html, "::CONTENT::" => page_content)
            html = replace(html, "::FOOTER::" => get_footer_html())
            
            html
        else
            page_content = """
            <div class="error-container">
                <h1>Notebook Not Found</h1>
                <p>The notebook "$notebook_name" could not be found.</p>
                <a href="/notebooks" class="btn btn-primary">Back to Notebooks</a>
            </div>
            """
            
            html = get_base_template()
            html = replace(html, "::TITLE::" => "Notebook Not Found")
            html = replace(html, "::SIDEBAR::" => get_sidebar_html())
            html = replace(html, "::CONTENT::" => page_content)
            html = replace(html, "::FOOTER::" => get_footer_html())
            
            Genie.Responses.html(html; status=404)
        end
    end

    # API Status endpoint
    route("/api/health", method=GET) do
        Genie.Responses.text(JSON.json(Dict("status" => "ok", "version" => "0.1.0")), "application/json")
    end

    # Return version information
    route("/api/version", method=GET) do
        Genie.Responses.text(JSON.json(Dict(
            "name" => "MyTemplate",
            "version" => "0.1.0",
            "julia_version" => string(VERSION)
        )), "application/json")
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
