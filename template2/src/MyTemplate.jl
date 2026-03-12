"""
    MyTemplate

A professional template combining Genie Framework and Documenter.jl
with support for Pluto notebooks

# Key Components:
- **Genie**: Web framework for serving the site and API endpoints
- **Documenter.jl**: API documentation generation
- **Pluto Notebooks**: Interactive notebook support

# Basic Usage:
```julia
using MyTemplate

# Start the web server
MyTemplate.serve()

# Build documentation
MyTemplate.build_docs()
```
"""
module MyTemplate

using Genie, Genie.Router, Genie.Requests, Genie.Responses
using Documenter
using HTTP
using JSON
using Dates

export serve, build_docs, run_dev_server

# Configuration
const DEFAULT_PORT = 8000
const DEFAULT_HOST = "0.0.0.0"

include("core.jl")
include("utils.jl")
include("routes.jl")

# Include AIHelpMe module
include("AIHelpMe/AIHelpMe.jl")
using .AIHelpMe

# Include AIHelpUI module
include("AIHelpUI/routes.jl")

"""
    serve(; host=DEFAULT_HOST, port=DEFAULT_PORT)

Start the Genie web server serving the site.

# Arguments:
- `host::String`: Host address (default: "0.0.0.0")
- `port::Int`: Port number (default: 8000)
"""
function serve(; host=DEFAULT_HOST, port=DEFAULT_PORT)
    setup_routes()
    Genie.config.server_host = host
    Genie.config.server_port = port
    Genie.up(async=false)
    # Keep the process alive
    while true
        sleep(1)
    end
end

"""
    run_dev_server(; host="localhost", port=8000)

Start development server with auto-reload.
"""
function run_dev_server(; host="localhost", port=8000)
    setup_routes()
    Genie.config.server_host = host
    Genie.config.server_port = port
    Genie.up()
end

"""
    build_docs()

Build documentation using Documenter.jl
"""
function build_docs()
    include("../docs/make.jl")
end

end # module
