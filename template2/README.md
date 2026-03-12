# MyTemplate

A professional, production-ready Julia documentation template combining **PlutoPages**, **Genie Framework**, and **Documenter.jl**.

## 🌟 Features

- ✨ **Interactive Pluto Notebooks** - Run code directly in your browser
- 🤖 **AI Research Helper** - Ask questions about your docs using OpenAI/Cohere
- 📚 **Auto-Generated API Docs** - Powered by Documenter.jl
- 🚀 **Fast Web Server** - Built on Genie Framework
- 🎨 **Modern, Responsive Design** - Works on all devices
- 📱 **Mobile-Friendly** - Optimized for mobile viewing
- 🔍 **SEO-Ready** - Proper meta tags and structure
- 🧪 **Comprehensive Examples** - Learn by doing
- ⚙️ **Easy to Customize** - Well-organized structure
- 🚀 **Deployment-Ready** - GitHub Actions CI/CD included
- 🐳 **Docker Support** - Containerized development & deployment

## 📋 Quick Start

### Installation

```bash
git clone https://github.com/yourusername/MyTemplate.git
cd MyTemplate
julia --project
```

### Start the Server

```julia
] instantiate
using MyTemplate
MyTemplate.serve()
```

Open http://localhost:8000 in your browser.

## 🤖 AI Research Helper (NEW!)

Access an intelligent research assistant that answers questions about your documentation:

```bash
# 1. Get API keys (OpenAI, Cohere, Tavily)
# 2. Configure .env file
# 3. Start the server
source .env
julia --project server.jl

# 4. Visit http://localhost:8000/ai-help
```

**Features:**
- 🧠 Multi-provider LLM support (OpenAI, Cohere)
- 🔍 Automatic documentation indexing
- 🌐 Optional web search via Tavily
- 💬 Persistent conversation history
- 📌 Source citations

For detailed setup: [AI_HELP_SETUP.md](AI_HELP_SETUP.md)

## 📁 Project Structure

```
MyTemplate/
├── src/                      # Main package source code
│   ├── MyTemplate.jl        # Package definition
│   ├── core.jl              # Core functionality
│   ├── utils.jl             # Utility functions
│   └── routes.jl            # Web routes
├── docs/                    # Documenter.jl documentation
│   ├── src/
│   │   ├── index.md
│   │   ├── guide/           # User guides
│   │   ├── tutorials/       # Tutorials
│   │   ├── api/             # API reference
│   │   ├── examples.md
│   │   └── faq.md
│   ├── make.jl              # Documentation builder
│   └── Project.toml
├── pages/                   # Pluto notebooks
│   ├── index.pluto.jl       # Home page
│   ├── getting-started.pluto.jl
│   └── visualization.pluto.jl
├── public/                  # Static assets
│   ├── css/                 # Stylesheets
│   └── js/                  # JavaScript
├── test/                    # Test suite
│   └── runtests.jl
├── web/                     # Web configuration (reserved)
├── .github/workflows/       # CI/CD workflows
├── Project.toml             # Package dependencies
├── config.toml              # Site configuration
└── README.md
```

## 🛠️ Usage

### Running the Web Server

```julia
using MyTemplate

# Start on default port (8000)
MyTemplate.serve()

# Or specify a custom port
MyTemplate.serve(port=3000)

# Development mode with auto-reload
MyTemplate.run_dev_server()
```

### Building Documentation

```julia
using MyTemplate
MyTemplate.build_docs()
```

Output will be in `docs/build/`

### Running Tests

```julia
] test
```

## 📖 Documentation

- [Getting Started](docs/src/guide/getting-started.md)
- [Installation Guide](docs/src/guide/installation.md)
- [Configuration](docs/src/guide/configuration.md)
- [Basic Usage](docs/src/tutorials/basic.md)
- [Advanced Topics](docs/src/tutorials/advanced.md)
- [Examples](docs/src/examples.md)
- [API Reference](docs/src/api/reference.md)
- [FAQ](docs/src/faq.md)

## 🎓 Examples

The template includes several example Pluto notebooks:

- `pages/index.pluto.jl` - Introduction and welcome
- `pages/getting-started.pluto.jl` - Setup instructions
- `pages/visualization.pluto.jl` - Data visualization examples

## 🔧 Configuration

Edit `config.toml` to customize:

```toml
[site]
title = "MyTemplate"
subtitle = "A Julia Documentation Template"
author = "Your Name"
github_url = "https://github.com/yourusername/MyTemplate"

[server]
port = 8000
host = "0.0.0.0"
```

## 🚀 Deployment

### GitHub Pages

The template includes GitHub Actions workflows for automatic documentation deployment:

```yaml
# .github/workflows/docs.yml
# Automatically builds and deploys docs on push to main
```

### Other Platforms

- **Heroku**: Use the included Procfile (create if needed)
- **DigitalOcean**: Droplet with Julia environment
- **AWS**: EC2 instance or AWS Lambda
- **Vercel**: For static builds
- **Netlify**: For static builds

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Open a Pull Request

## 📝 Best Practices Implemented

✅ **Clear File Organization** - Logical separation of concerns  
✅ **Documentation** - Comprehensive guides and API docs  
✅ **Examples** - Interactive notebooks demonstrating features  
✅ **Testing** - Test suite with continuous integration  
✅ **Configuration** - Centralized config management  
✅ **Error Handling** - Graceful error messages  
✅ **Security** - Input validation and safe defaults  
✅ **Performance** - Optimized routes and asset delivery  
✅ **Accessibility** - Semantic HTML and ARIA labels  
✅ **Mobile-First** - Responsive design patterns  

## 📦 Dependencies

- **Genie.jl** (≥5.0) - Web framework
- **PlutoPages** (≥0.1) - Notebook-based pages
- **Documenter.jl** (≥1.0) - API documentation
- **HTTP.jl** (≥1.0) - HTTP utilities
- **JSON.jl** (≥0.21) - JSON parsing

## 🐛 Troubleshooting

### Port Already in Use
```julia
MyTemplate.serve(port=8001)
```

### Module Not Found
```bash
julia --project
] dev .
```

### Clear Compilation Cache
```bash
rm -rf ~/.julia/compiled
```

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Genie Framework](https://genieframework.com/) - Web server
- [Pluto.jl](https://plutojl.org/) - Interactive notebooks
- [Documenter.jl](https://documenter.juliadocs.org/) - Documentation
- [Julia Community](https://julialang.org/) - Inspiration and support

## 📞 Support

- 📖 Check the [Documentation](docs/src/index.md)
- 🐛 [Report Issues](https://github.com/yourusername/MyTemplate/issues)
- 💬 [Discussions](https://github.com/yourusername/MyTemplate/discussions)

## 🎯 Roadmap

- [ ] Search functionality
- [ ] Dark mode toggle
- [ ] Comments system
- [ ] User authentication
- [ ] Analytics integration
- [ ] Blog section
- [ ] API versioning
- [ ] WebSocket support

---

**Happy documenting! 🎉**

Made with ❤️ for the Julia community
