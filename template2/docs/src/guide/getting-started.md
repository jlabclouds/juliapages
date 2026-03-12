# Getting Started

This guide will help you get up and running with MyTemplate in minutes.

## Installation

### Requirements

- Julia 1.9 or higher
- Git

### Steps

1. Clone the repository:

```bash
git clone https://github.com/yourusername/MyTemplate.git
cd MyTemplate
```

2. Activate the project environment:

```bash
julia --project
```

3. Instantiate dependencies:

```julia
] instantiate
```

## Running the Server

Once you have the dependencies installed, start the development server:

```julia
using MyTemplate
MyTemplate.serve()
```

Open your browser to `http://localhost:8000` to see the site.

## File Structure

```
MyTemplate/
├── src/              # Main package code
├── docs/             # Documentation (Documenter.jl)
├── pages/            # Pluto notebooks
├── web/              # Web server configuration
└── test/             # Tests
```

## Next Steps

- Check out the [Examples](../examples.md)
- Read the [Configuration Guide](configuration.md)
- Explore the [API Reference](../api/reference.md)
