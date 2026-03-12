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

"""
    get_ai_help_config()

Return the AI Help configuration with switchable options.
"""
function get_ai_help_config()
    Dict(
        # AI Model Provider - "placeholder", "openai", "anthropic", "azure", "local"
        "ai_provider" => get(ENV, "AI_PROVIDER", "placeholder"),
        "ai_model_name" => get(ENV, "AI_MODEL_NAME", "placeholder-model"),
        "ai_api_endpoint" => get(ENV, "AI_API_ENDPOINT", ""),
        
        # Help Scope - "docs-only" or "full-site"
        "help_scope" => get(ENV, "HELP_SCOPE", "docs-only"),
        
        # UI Style - "chat", "qa-panel", "suggestions", or "hybrid"
        "help_ui_style" => get(ENV, "HELP_UI_STYLE", "chat"),
        
        # UI Position - "bottom-right", "bottom-left", or "side-panel"
        "help_ui_position" => get(ENV, "HELP_UI_POSITION", "bottom-right"),
        
        # UI Theme - "light", "dark", or "auto"
        "help_ui_theme" => get(ENV, "HELP_UI_THEME", "auto"),
        
        # Enable/Disable AI Help
        "help_enabled" => parse(Bool, get(ENV, "HELP_ENABLED", "true")),
        
        # Deployment - "cloud" or "local"
        "deployment_mode" => get(ENV, "DEPLOYMENT_MODE", "cloud"),
    )
end
