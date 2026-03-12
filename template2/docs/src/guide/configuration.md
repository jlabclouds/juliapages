# Configuration

Learn how to configure MyTemplate for your needs.

## Environment Variables

You can customize the application using environment variables:

```julia
# Port configuration
ENV["PORT"] = "8080"

# Host configuration
ENV["HOST"] = "localhost"

# Environment
ENV["ENVIRONMENT"] = "development"  # or "production"

# Enable analytics
ENV["ANALYTICS_ENABLED"] = "false"
```

## Configuration File

Create a `config.toml` in your project root:

```toml
[server]
host = "0.0.0.0"
port = 8000
async = false

[documentation]
builder = "documenter.jl"
output_dir = "docs/build"

[site]
title = "MyTemplate"
subtitle = "A Julia Documentation Template"
theme = "light"
```

## Programmatic Configuration

In your Julia code:

```julia
using MyTemplate

# Custom configuration
config = MyTemplate.get_site_config()
config["title"] = "My Custom Site"
config["theme"] = "dark"

# Start server
MyTemplate.serve(port=3000)
```

## Customizing Routes

Add custom routes in `src/routes.jl`:

```julia
route("/custom-page") do
    "<h1>Custom Page</h1>"
end
```

## Theme Customization

Modify CSS in `public/css/style.css` to customize the appearance.
