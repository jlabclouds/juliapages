#!/bin/bash
# Build and serve documentation locally

set -e

echo "🔨 Building TemplatePackage documentation..."

cd "$(dirname "$0")/docs"

if ! command -v julia &> /dev/null; then
    echo "❌ Julia is not installed or not in PATH"
    exit 1
fi

echo "📦 Installing documentation dependencies..."
julia --project=. -e "using Pkg; Pkg.instantiate()"

echo "🔨 Building documentation..."
julia --project=. -e "include(\"make.jl\")"

echo "✅ Documentation built successfully!"
echo ""
echo "📂 Documentation location: $(pwd)/build/index.html"
echo ""
echo "To serve locally, run:"
echo "  julia --project=. -e \"using LiveServer, Documenter; LiveServer.serve(dir=\\\"build\\\")\""
