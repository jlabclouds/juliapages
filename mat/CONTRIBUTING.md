# Contributing Guide

## How to Add Content

### Adding a New Chapter

1. Create a new file in the appropriate track directory:
   ```
   tracks/[track-name]/NN_chapter_name.jl
   ```

2. Follow the Pluto notebook structure:
   ```julia
   ### Chapter Title
   
   Brief description...
   
   #### What You'll Learn
   - Key concept 1
   - Key concept 2
   
   #### Code Examples
   
   \`\`\`julia
   # Your Julia code here
   \`\`\`
   ```

3. Update the chapter list in `navbar.jl` MATH_TRACKS dictionary

4. Test locally before submitting

### Code Style Guidelines

- **Julia**: Follow [Julia Style Guide](https://docs.julialang.org/en/v1/manual/style-guide/)
- **Notebooks**: Clear sections with headers
- **Comments**: Explain WHY, not WHAT
- **Examples**: Runnable and self-contained

### Adding a New Track

1. Create directory: `tracks/new-track/`
2. Add to MATH_TRACKS in `navbar.jl`
3. Create first chapter: `01_topic.jl`
4. Update this README

### Testing

```bash
julia --project -e "using PlutoPages; PlutoPages.serve()"
```

Visit `http://localhost:8000` and verify:
- Navigation works
- Links are correct
- Code runs without errors
- Formatting looks good

## Pull Request Process

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/add-content`
3. Commit changes: `git commit -m "Add chapter on topic"`
4. Push to branch: `git push origin feature/add-content`
5. Open a Pull Request

## Guidelines

- One feature/content addition per PR
- Clear commit messages
- Update documentation if needed
- Test thoroughly
- Be respectful and constructive

## Questions?

Open an issue or start a discussion!
