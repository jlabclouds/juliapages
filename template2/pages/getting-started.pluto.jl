### A Pluto.jl notebook ###
# v0.19.27

using Markdown

# ╔═╡ 00000000-0000-0000-0000-000000000001
md"""
# Getting Started with MyTemplate

This guide walks through the basic setup and usage.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
md"""
## Installation

### Step 1: Clone Repository
\`\`\`bash
git clone https://github.com/yourusername/MyTemplate.git
cd MyTemplate
\`\`\`

### Step 2: Activate Environment
\`\`\`bash
julia --project
\`\`\`

### Step 3: Install Dependencies
In Julia REPL:
\`\`\`julia
] instantiate
\`\`\`
"""

# ╔═╡ 00000000-0000-0000-0000-000000000003
md"""
## Running the Application

In the Julia REPL:
\`\`\`julia
using MyTemplate
MyTemplate.serve()
\`\`\`

Then open your browser to: **http://localhost:8000**
"""

# ╔═╡ 00000000-0000-0000-0000-000000000004
md"""
## Creating Your First Page

1. Add a Markdown file to `docs/src/guide/`
2. Add it to the pages list in `docs/make.jl`
3. Rebuild and refresh

Example in `docs/make.jl`:
\`\`\`julia
pages=[
    "Home" => "index.md",
    "Guide" => [
        "Getting Started" => "guide/getting-started.md",
        "My New Page" => "guide/my-new-page.md",
    ],
]
\`\`\`
"""

# ╔═╡ 00000000-0000-0000-0000-000000000005
md"""
## Adding Custom Routes

Edit `src/routes.jl` to add custom endpoints:

\`\`\`julia
route("/custom") do
    "<h1>My Custom Page</h1>"
end
\`\`\`

Restart the server to see changes.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000006
md"""
## Building Documentation

Generate the full documentation site:

\`\`\`julia
using MyTemplate
MyTemplate.build_docs()
\`\`\`

Output will be in `docs/build/`
"""

# ╔═╡ 00000000-0000-0000-0000-000000000007
md"""
## Troubleshooting

**Port already in use?**
\`\`\`julia
MyTemplate.serve(port=8001)
\`\`\`

**Module not found?**
\`\`\`julia
] dev .
\`\`\`

**Clear cache?**
\`\`\`bash
rm -rf ~/.julia/compiled
\`\`\`
"""

# ╔═╡ 00000000-0000-0000-0000-000000000008
md"""
## Next Steps

- ✅ Customize the site configuration
- ✅ Add your own content to `docs/src/`
- ✅ Create interactive Pluto notebooks
- ✅ Deploy to GitHub Pages or a server

See the [Configuration Guide](../guide/configuration) for more options.
"""

# ╔═╡ Cell order:
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
# ╟─00000000-0000-0000-0000-000000000003
# ╟─00000000-0000-0000-0000-000000000004
# ╟─00000000-0000-0000-0000-000000000005
# ╟─00000000-0000-0000-0000-000000000006
# ╟─00000000-0000-0000-0000-000000000007
# ╟─00000000-0000-0000-0000-000000000008
