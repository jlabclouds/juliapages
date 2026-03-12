"""
Utility functions for MyTemplate
"""

"""
    render_markdown(content::String)

Convert markdown content to HTML.
"""
function render_markdown(content::String)
    # In production, use a markdown parser like Markdown.jl
    "<div class=\"markdown\">$content</div>"
end

"""
    get_navbar_html()

Generate HTML for the navigation bar.
"""
function get_navbar_html()
    nav_items = get_navigation_structure()
    config = get_site_config()
    
    html = """
    <nav class="navbar">
        <div class="navbar-container">
            <div class="navbar-brand">
                <a href="/" class="logo">$(config["title"])</a>
                <span class="subtitle">$(config["subtitle"])</span>
            </div>
            <ul class="navbar-menu">
    """
    
    for item in nav_items
        external = get(item, :external, false)
        target = external ? "target=\"_blank\" rel=\"noopener noreferrer\"" : ""
        html *= """
        <li><a href="$(item.path)" $target class="nav-link">$(item.title)</a></li>
        """
    end
    
    html *= """
            </ul>
        </div>
    </nav>
    """
    
    html
end

"""
    get_footer_html()

Generate HTML for the site footer.
"""
function get_footer_html()
    config = get_site_config()
    
    """
    <footer class="footer">
        <div class="footer-content">
            <p>&copy; 2024-2026 $(config["author"]). All rights reserved.</p>
            <p>Built with <a href="https://genieframework.com">Genie</a>, 
               <a href="https://plutojl.org">Pluto</a>, and 
               <a href="https://documenter.juliadocs.org">Documenter.jl</a></p>
            <p>
                <a href="$(config["github_url"])">Source Code</a> |
                <a href="https://github.com/yourusername/mytemplate/issues">Issues</a>
            </p>
        </div>
    </footer>
    """end

"""
    get_sidebar_html()

Generate HTML for the left sidebar navigation.
"""
function get_sidebar_html()
    nav_items = get_navigation_structure()
    config = get_site_config()
    
    html = """
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="/" class="logo-sidebar">$(config["title"])</a>
        </div>
        <nav class="sidebar-nav">
            <ul class="sidebar-menu">
    """
    
    for item in nav_items
        external = get(item, :external, false)
        target = external ? "target=\"_blank\" rel=\"noopener noreferrer\"" : ""
        html *= """
            <li><a href=\"$(item.path)\" $target class=\"sidebar-link\">$(item.title)</a></li>
        """
    end
    
    html *= """
            </ul>
        </nav>
    </aside>
    """
    
    html
end

"""
    read_docs_index()

Read and return the documentation index.md content.
"""
function read_docs_index()
    try
        docs_path = joinpath(dirname(dirname(@__FILE__)), "docs", "src", "index.md")
        if isfile(docs_path)
            read(docs_path, String)
        else
            "# Documentation not found"
        end
    catch
        "# Error reading documentation"
    end
end

"""
    read_doc_page(subdir::String, page::String)

Read and return documentation page content from a specific subdirectory.
"""
function read_doc_page(subdir::String, page::String)
    try
        # Sanitize page name to prevent directory traversal
        page = replace(page, r"[.\\/]+" => "")
        
        # Build the path
        if isempty(subdir)
            doc_path = joinpath(dirname(dirname(@__FILE__)), "docs", "src", page * ".md")
        else
            doc_path = joinpath(dirname(dirname(@__FILE__)), "docs", "src", subdir, page * ".md")
        end
        
        if isfile(doc_path)
            read(doc_path, String)
        else
            "# Page not found\n\nThe page you're looking for doesn't exist: $subdir/$page"
        end
    catch e
        "# Error reading page\n\n$e"
    end
end

"""
    markdown_to_html(md_content::String)

Convert markdown content to HTML.
"""
function markdown_to_html(md_content::String)
    html = md_content
    
    # Convert headers
    html = replace(html, r"^# (.+)$"m => s"<h1>\1</h1>")
    html = replace(html, r"^## (.+)$"m => s"<h2>\1</h2>")
    html = replace(html, r"^### (.+)$"m => s"<h3>\1</h3>")
    html = replace(html, r"^#### (.+)$"m => s"<h4>\1</h4>")
    
    # Convert bold and italic
    html = replace(html, r"\*\*(.+?)\*\*" => s"<strong>\1</strong>")
    html = replace(html, r"_(.+?)_" => s"<em>\1</em>")
    html = replace(html, r"\*(.+?)\*" => s"<em>\1</em>")
    
    # Convert inline code
    html = replace(html, r"`([^`]+)`" => s"<code>\1</code>")
    
    # Convert links - remove .md extensions from internal links
    html = replace(html, r"\[(.+?)\]\((.+?)(\.md)?\)" => s"<a href=\"\2\">\1</a>")
    
    # Convert line breaks to paragraphs
    paragraphs = split(html, r"\n\n+")
    html = join(["<p>" * strip(p) * "</p>" for p in paragraphs if !isempty(strip(p))], "\n")
    
    "<div class=\"markdown\">" * html * "</div>"
end

"""
    get_base_template()

Return the base HTML template structure.
"""
function get_base_template()
    """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>::TITLE:: - MyTemplate</title>
        <link rel="stylesheet" href="/css/style.css">
        <link rel="stylesheet" href="/css/highlight.css">
    </head>
    <body>
        <div class="mobile-header">
            <button class="sidebar-toggle" id="sidebar-toggle" aria-label="Toggle sidebar">☰</button>
            <span class="mobile-title">::TITLE::</span>
        </div>
        <div class="page-wrapper">
            ::SIDEBAR::
            <div class="main-wrapper">
                <main class="main-content">
                    ::CONTENT::
                </main>
                ::FOOTER::
            </div>
        </div>
        <script src="/js/main.js"></script>
    </body>
    </html>
    """
end
