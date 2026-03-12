# Installation

Detailed installation instructions for different scenarios.

## Standard Installation

### From GitHub

Clone the repository and activate the Julia environment:

```bash
git clone https://github.com/yourusername/MyTemplate.git
cd MyTemplate
julia --project
```

Then in the Julia REPL:

```julia
] instantiate
using MyTemplate
```

### Development Installation

For contributing to MyTemplate:

```bash
git clone https://github.com/yourusername/MyTemplate.git
cd MyTemplate
julia --project
```

From the Julia REPL:

```julia
] dev .
using MyTemplate
```

## Troubleshooting

### Issue: Package not found

Make sure you're in the correct directory with `Project.toml`:

```julia
pwd()  # Should show MyTemplate directory
readdir()  # Should include "Project.toml"
```

### Issue: Port already in use

Specify a different port:

```julia
MyTemplate.serve(port=8001)
```

### Issue: SSL/Certificate errors

Clear Julia's package cache:

```bash
rm -rf ~/.julia/compiled
```

Then try again.
