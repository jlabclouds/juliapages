using Documenter, MyTemplate

# Build documentation
makedocs(;
    modules=[MyTemplate],
    authors="Your Name <you@example.com>",
    repo="https://github.com/yourusername/MyTemplate",
    sitename="MyTemplate",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", nothing) == "true",
        canonical="https://yourusername.github.io/MyTemplate",
        assets = String[],
    ),
    pages=[
        "Home" => "index.md",
        "Guide" => [
            "Getting Started" => "guide/getting-started.md",
            "Installation" => "guide/installation.md",
            "Configuration" => "guide/configuration.md",
        ],
        "Tutorials" => [
            "Basic Usage" => "tutorials/basic.md",
            "Advanced Topics" => "tutorials/advanced.md",
        ],
        "Examples" => "examples.md",
        "API Reference" => "api/reference.md",
        "FAQ" => "faq.md",
    ],
    strict = !("--allow-warnings" in ARGS),
    checkdocs = :exports,
)

# Deploy documentation
deploydocs(;
    repo="github.com/yourusername/MyTemplate.git",
    target="build",
    branch="gh-pages",
    devbranch="main",
    devurl="dev",
    push_preview=true,
)
