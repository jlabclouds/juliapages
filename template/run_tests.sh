#!/bin/bash
# Run all tests for TemplatePackage

set -e

echo "🧪 Running TemplatePackage tests..."

if ! command -v julia &> /dev/null; then
    echo "❌ Julia is not installed or not in PATH"
    exit 1
fi

echo "📦 Setting up test environment..."
julia --project=. -e "using Pkg; Pkg.instantiate()"

echo "🧪 Running tests..."
julia --project=. -e "using Pkg; Pkg.test()"

echo "✅ All tests passed!"
