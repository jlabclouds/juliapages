# Basic Usage

Learn the fundamentals of using MyTemplate.

## Starting the Server

The simplest way to get started:

```julia
using MyTemplate
MyTemplate.serve()
```

This starts the web server on `http://localhost:8000`.

## Creating Pages

Add new Pluto notebooks to the `pages/` directory:

```julia
# pages/my-page.pluto.jl
### A Pluto.jl notebook ###
# ...your notebook content...
```

## Adding Documentation

Add markdown files to `docs/src/`:

```markdown
# My Section

This is a new documentation page.
```

Then add it to the `pages` list in `docs/make.jl`.

## Creating API Endpoints

Add custom endpoints in `src/routes.jl`:

```julia
route("/api/data", method=GET) do
    Genie.Responses.json(Dict("message" => "Hello"))
end
```

## Running Tests

Execute the test suite:

```julia
using MyTemplate
] test
```

## Building Documentation

Generate the documentation site:

```julia
using MyTemplate
MyTemplate.build_docs()
```

The built documentation will be in `docs/build/`.

## Deployment

For production deployment, see [Deployment Guide](deployment.md).
