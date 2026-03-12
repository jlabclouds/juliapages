#!/usr/bin/env julia
# MyTemplate Development Server
# Starts the web server with development settings

using Pkg

# Ensure project is instantiated
Pkg.instantiate()

# Load the module
using MyTemplate

# Print startup information
println("""
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  🚀 MyTemplate Development Server
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  📍 Server: http://localhost:8000
  🔧 Environment: development
  📚 Docs: http://localhost:8000/docs
  🐛 Debug: enabled

  Press Ctrl+C to stop the server

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
""")

# Start development server
try
    MyTemplate.serve(host="0.0.0.0", port=8000)
catch e
    if e isa InterruptException
        println("\n\n👋 Server stopped gracefully")
    else
        println("Error: $e")
        rethrow()
    end
end
