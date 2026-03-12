#!/bin/bash
# Quick setup script for new Julia project based on this template

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  TemplatePackage.jl Setup Script${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check Julia installation
if ! command -v julia &> /dev/null; then
    echo -e "${YELLOW}⚠️  Julia is not installed or not in PATH${NC}"
    echo "Download Julia from: https://julialang.org/downloads/"
    exit 1
fi

JULIA_VERSION=$(julia -e "println(VERSION)")
echo -e "${GREEN}✓${NC} Julia $JULIA_VERSION found"

# Setup development environment
echo ""
echo -e "${BLUE}Setting up development environment...${NC}"
julia --project=. -e "using Pkg; Pkg.instantiate(); Pkg.status()" 2>&1 | grep -E "^(Status|  \[)" || true

# Documentation environment
echo ""
echo -e "${BLUE}Setting up documentation environment...${NC}"
julia --project=docs -e "using Pkg; Pkg.instantiate()" 2>&1 | tail -1 || true

# Run tests
echo ""
echo -e "${BLUE}Running tests...${NC}"
if julia --project=. -e "using Pkg; Pkg.test()" 2>&1 | tail -5; then
    echo -e "${GREEN}✓ All tests passed!${NC}"
else
    echo -e "${YELLOW}⚠️  Some tests may have failed${NC}"
fi

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ Setup Complete!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Next steps:"
echo "  1. Review Project.toml and update project details"
echo "  2. Start developing in src/"
echo "  3. Run tests with: make test"
echo "  4. Build docs with: make docs"
echo ""
echo "Useful commands:"
echo "  make help     - Show all available commands"
echo "  make test     - Run the test suite"
echo "  make docs     - Build documentation"
echo "  make format   - Format code"
echo "  make clean    - Clean build artifacts"
echo ""
echo "Documentation:"
echo "  - Read: docs/src/guides/getting-started.md"
echo "  - Structure: PROJECT_STRUCTURE.md"
echo "  - Contributing: CONTRIBUTING.md"
echo ""
