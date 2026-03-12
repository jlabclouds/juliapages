.PHONY: help test docs clean build install format lint dev plutopages

help:
	@echo "TemplatePackage.jl - Development Commands"
	@echo "=========================================="
	@echo "  make test           - Run tests"
	@echo "  make docs           - Build Documenter.jl documentation"
	@echo "  make plutopages     - Build PlutoPages interactive notebooks"
	@echo "  make docs-all       - Build both Documenter and PlutoPages"
	@echo "  make docs-serve     - Serve docs locally with LiveServer"
	@echo "  make clean          - Clean build artifacts"
	@echo "  make format         - Format code"
	@echo "  make lint           - Run linting checks"
	@echo "  make dev            - Setup development environment"
	@echo "  make install        - Install package"
	@echo "  make repl           - Start Julia REPL with package loaded"

test:
	julia --project=. -e "using Pkg; Pkg.test()"

docs:
	julia --project=docs docs/make.jl

plutopages:
	julia --project=docs docs/build_plutopages.jl

docs-all: plutopages docs
	@echo "\n✓ Documenter and PlutoPages build complete!"
	@echo "  View HTML: open docs/build/index.html"
	@echo "  Or serve:  make docs-serve"

docs-serve:
	julia --project=docs -e "using LiveServer, Documenter; LiveServer.serve(dir=\"docs/build\")"

clean:
	rm -rf docs/build
	rm -rf .coverage
	rm -rf htmlcov
	find . -name "*.cov" -delete
	find . -name ".DS_Store" -delete

format:
	julia -e "using Pkg; Pkg.add(\"JuliaFormatter\"); using JuliaFormatter; format(\"src\"); format(\"test\")"

lint:
	julia -e "using Pkg; Pkg.add(\"JuliaFormatter\"); using JuliaFormatter; @show format(\"src\"; overwrite=false); format(\"test\"; overwrite=false)"

dev:
	julia --project=. -e "using Pkg; Pkg.instantiate()"

install:
	julia --project=. -e "using Pkg; Pkg.instantiate()"

build:
	julia --project=. -e "using Pkg; Pkg.build()"

repl:
	julia --project=.

.PHONY: all
all: install test docs

# Default target
.DEFAULT_GOAL := help
