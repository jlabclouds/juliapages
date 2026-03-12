# API Reference

Complete API documentation for MyTemplate.

## Core Functions

### `serve()`

```julia
serve(; host=DEFAULT_HOST, port=DEFAULT_PORT)
```

Start the Genie web server.

**Arguments:**
- `host::String`: Host address (default: "0.0.0.0")
- `port::Int`: Port number (default: 8000)

**Example:**
```julia
MyTemplate.serve(port=3000)
```

### `run_dev_server()`

```julia
run_dev_server(; host="localhost", port=8000)
```

Start development server with auto-reload capabilities.

### `build_docs()`

```julia
build_docs()
```

Build documentation using Documenter.jl.

## Configuration Functions

### `get_site_config()`

```julia
get_site_config()::Dict
```

Returns the site configuration dictionary containing:
- `title`: Site title
- `subtitle`: Site subtitle  
- `version`: Version string
- `author`: Author name
- `github_url`: GitHub repository URL
- `theme`: Theme name

### `get_navigation_structure()`

```julia
get_navigation_structure()::Vector
```

Returns the navigation menu structure.

## Utility Functions

### `render_markdown()`

```julia
render_markdown(content::String)::String
```

Convert markdown content to HTML.

### `get_navbar_html()`

```julia
get_navbar_html()::String
```

Generate navigation bar HTML.

### `get_footer_html()`

```julia
get_footer_html()::String
```

Generate footer HTML.

## Route Handlers

The following routes are automatically configured:

| Route | Method | Description |
|-------|--------|-------------|
| `/` | GET | Home page |
| `/docs` | GET | Documentation index |
| `/tutorials` | GET | Tutorials listing |
| `/examples` | GET | Examples listing |
| `/api/health` | GET | Health check endpoint |
| `/api/version` | GET | Version information |

## Environment Variables

- `GENIE_HOST`: Server host (default: "0.0.0.0")
- `GENIE_PORT`: Server port (default: 8000)
- `GENIE_ENV`: Environment (development/production)
