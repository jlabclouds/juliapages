"""
Core functionality for MyTemplate
"""

"""
    get_site_config()

Return the site configuration dictionary.
"""
function get_site_config()
    Dict(
        "title" => "MyTemplate",
        "subtitle" => "A Julia Documentation Template",
        "version" => "0.1.0",
        "author" => "Your Name",
        "github_url" => "https://github.com/yourusername/mytemplate",
        "docs_url" => "/docs",
        "theme" => "light",
        "analytics" => false,
    )
end

"""
    get_navigation_structure()

Return the site navigation structure.
"""
function get_navigation_structure()
    [
        (title = "Home", path = "/", icon = "home"),
        (title = "Docs", path = "/docs", icon = "book"),
        (title = "Tutorials", path = "/tutorials", icon = "graduation-cap"),
        (title = "Examples", path = "/examples", icon = "code"),
        (title = "API Reference", path = "/api", icon = "cube"),
        (title = "GitHub", path = "https://github.com", icon = "github", external = true),
    ]
end
