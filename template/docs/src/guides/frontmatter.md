# Frontmatter Documentation

Learn how to use YAML frontmatter in your documentation files to add metadata, control page behavior, and enhance organization.

## What is Frontmatter?

Frontmatter is YAML metadata placed at the beginning of a markdown file, enclosed by triple dashes (`---`). It allows you to define page-level configuration such as titles, descriptions, custom metadata, and more.

## Basic Frontmatter Syntax

Frontmatter appears at the very beginning of a markdown file:

```yaml
---
title: Page Title
description: A brief description of the page
keywords: julia, documentation, frontmatter
author: Your Name
date: 2024-01-15
---

# Main content starts here
```

All content after the closing `---` is processed as regular markdown.

## Supported Frontmatter Fields

### Essential Fields

#### `title`
The page title displayed in the browser tab and document head.

```yaml
---
title: Getting Started with TemplatePackage
---
```

#### `description`
A brief description used in search results and metadata.

```yaml
---
description: Learn how to install and use TemplatePackage.jl
---
```

#### `keywords`
Comma-separated keywords for search optimization and metadata.

```yaml
---
keywords: julia, package, tutorial, installation
---
```

### Metadata Fields

#### `author`
The page author or maintainer.

```yaml
---
author: Jane Doe
---
```

#### `date`
Publication or last-modified date.

```yaml
---
date: 2024-01-15
---
```

#### `version`
Document version or the package version it applies to.

```yaml
---
version: 0.1.0
---
```

### Organization Fields

#### `category`
Logical category for grouping related pages.

```yaml
---
category: guides
---
```

#### `order`
Sort order within a category (lower numbers appear first).

```yaml
---
order: 1
---
```

### Display & Behavior Fields

#### `hide`
Hide the page from navigation (still accessible via direct URL).

```yaml
---
hide: false
---
```

#### `draft`
Mark page as work-in-progress.

```yaml
---
draft: false
---
```

#### `toc-depth`
Control table of contents depth for the page.

```yaml
---
toc-depth: 2
---
```

#### `show-toc`
Show or hide the table of contents.

```yaml
---
show-toc: true
---
```

## Complete Example

Here's a comprehensive frontmatter example:

```yaml
---
title: Advanced Usage Patterns
description: Learn advanced patterns and best practices for TemplatePackage
keywords: julia, advanced, patterns, optimization, performance
author: Development Team
date: 2024-01-15
version: 0.1.0+
category: guides
order: 3
hide: false
draft: false
toc-depth: 3
show-toc: true
---

# Advanced Usage Patterns

## Overview

This guide covers advanced usage patterns...

### Performance Optimization

Learn how to optimize your code...
```

## Frontmatter in TemplatePackage

### Basic Page with Frontmatter

Create a new documentation page with frontmatter:

```yaml
---
title: Your Custom Guide
description: This is a custom guide for users
keywords: custom, tutorial, guide
author: Your Name
---

# Your Custom Guide

Content goes here...
```

### Organizing Related Pages

Use consistent frontmatter to organize content:

```yaml
---
title: Part 1: Installation
category: getting-started
order: 1
---
```

```yaml
---
title: Part 2: Configuration
category: getting-started
order: 2
---
```

```yaml
---
title: Part 3: First Steps
category: getting-started
order: 3
---
```

## Frontmatter and Search

### Search Optimization

The `description` and `keywords` fields are automatically indexed by the documentation search engine:

```yaml
---
title: API Reference
description: Complete API documentation for all functions
keywords: api, reference, functions, documentation
---
```

### Improving Search Results

Use descriptive titles and keywords for better search indexing:

```yaml
---
title: Troubleshooting Common Issues
description: Solutions for common problems and errors
keywords: troubleshooting, errors, problems, debugging, solutions
---
```

## Adding Frontmatter to Existing Pages

To add frontmatter to an existing markdown file:

1. Open the `.md` file
2. Add frontmatter at the very beginning (before any content)
3. Ensure triple dashes both above and below the YAML

### Before (without frontmatter):

```markdown
# Getting Started

Installation instructions...
```

### After (with frontmatter):

```markdown
---
title: Getting Started with TemplatePackage
description: Installation and setup instructions
keywords: installation, getting-started, setup
---

# Getting Started

Installation instructions...
```

## HTML Output

Frontmatter metadata is automatically added to the page's `<head>` section:

```html
<head>
    <title>Getting Started with TemplatePackage</title>
    <meta name="description" content="Installation and setup instructions">
    <meta name="keywords" content="installation, getting-started, setup">
    <meta name="author" content="Your Name">
</head>
```

This improves SEO and metadata visibility.

## Frontmatter in Table of Contents

When properly configured, frontmatter fields can control how pages appear in navigation:

```yaml
---
title: Hidden Implementation Details
hide: true
---
```

This page will still be accessible via direct URL but won't appear in navigation menus.

## Draft Pages

Mark pages as work-in-progress:

```yaml
---
title: Experimental Features
draft: true
---
```

Readers can see a "DRAFT" badge or notice on the page.

## Version-Specific Content

Use frontmatter to track version information:

```yaml
---
title: v0.1.0 Release Notes
version: 0.1.0
date: 2024-01-15
---
```

This helps users understand which version documentation applies to.

## Best Practices

### ✅ Do

- Use consistent frontmatter across related pages
- Provide descriptive titles and descriptions
- Include relevant keywords for search
- Update dates when content changes
- Use order field to organize related content

### ❌ Don't

- Leave frontmatter incomplete
- Use misleading keywords
- Forget closing triple dashes
- Include markdown or HTML in frontmatter fields
- Use special characters in YAML without quotes

## Frontmatter Examples in TemplatePackage

### Example 1: Guide Page

```yaml
---
title: Installing TemplatePackage
description: Step-by-step installation instructions
keywords: installation, package, julia, setup
author: Development Team
date: 2024-01-15
category: guides
order: 1
---
```

### Example 2: API Documentation

```yaml
---
title: Function Reference
description: Complete API reference for all exported functions
keywords: api, reference, functions, documentation
category: reference
toc-depth: 3
show-toc: true
---
```

### Example 3: Tutorial Page

```yaml
---
title: Tutorial: Your First Program
description: A hands-on tutorial for beginners
keywords: tutorial, beginner, introduction, first-steps
author: Learning Team
category: tutorials
order: 1
---
```

## Frontmatter Validation

When building documentation with Documenter.jl:

```bash
julia docs/make.jl
```

Invalid YAML in frontmatter will produce an error during build. Common issues:

### Invalid YAML (Error)
```yaml
---
title: My Page
description: This has an unclosed quote
keywords: julia, packages
---
```

### Valid YAML (Correct)
```yaml
---
title: "My Page"
description: "This has a closed quote"
keywords: "julia, packages"
---
```

## Advanced Usage

### Using Arrays in Frontmatter

```yaml
---
title: Multi-Author Guide
authors:
  - Jane Doe
  - John Smith
tags:
  - julia
  - performance
  - optimization
---
```

### Nested Metadata

```yaml
---
title: Advanced Guide
metadata:
  difficulty: advanced
  duration: 30
  prerequisites:
    - basic-knowledge
    - julia-installed
---
```

## Verification

To verify frontmatter is working:

1. **Check HTML Output**: View page source in browser and confirm meta tags are present
2. **Search Index**: Try searching for keywords from frontmatter
3. **Build Logs**: Check for any frontmatter parsing errors during build

```bash
julia docs/make.jl | grep -i frontmatter
```

## Integration with Documenter.jl plugins

Frontmatter works seamlessly with:

- **Search Engine**: Indexes title, description, and keywords
- **Navigation**: Uses title and order fields
- **Metadata**: Adds HTML meta tags
- **Analytics**: Can include tracking fields

## Troubleshooting

### Frontmatter Not Being Processed

**Issue**: Meta tags don't appear in page source

**Solution**: 
- Ensure frontmatter is at the very beginning of the file
- Check YAML syntax validity
- Verify triple dashes are symmetric

### Build Errors with Frontmatter

**Issue**: `make docs` fails with YAML parsing error

**Solution**:
- Check for unquoted special characters
- Validate YAML with online validator
- Ensure all colons in fields are followed by spaces

### Search Not Finding Frontmatter Keywords

**Issue**: Search doesn't return results for keywords in frontmatter

**Solution**:
- Rebuild documentation: `rm -rf docs/build && make docs`
- Ensure search index is enabled in `docs/make.jl`
- Check that keywords are relevant to page content

## Quick Reference

```yaml
---
# Essential
title: Page Title
description: Brief page description

# Organization
category: guides
order: 1

# Metadata
author: Your Name
date: 2024-01-15
version: 0.1.0

# Discovery
keywords: julia, tutorial, setup

# Display
hide: false
draft: false
show-toc: true
toc-depth: 2
---
```

## See Also

- [Getting Started Guide](getting-started.md)
- [API Reference](../api.md)
- [Search Features](search.md)

---

**Frontmatter enables powerful documentation organization and discovery.** Use it to make your documentation more accessible and searchable!
