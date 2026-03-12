# Security Policy

## Reporting Security Vulnerabilities

If you discover a security vulnerability in MyTemplate, please **do not** open a public GitHub issue. Instead:

1. Email the maintainers at: [security@yourdomain.com]
2. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if available)

3. Allow time for a fix before disclosure (typically 90 days)

## Supported Versions

| Version | Supported           |
|---------|-------------------|
| 0.1.x   | ✅ Yes (development) |
| < 0.1   | ❌ No              |

## Security Best Practices

When using MyTemplate:

### For Administrators
- Keep Julia and dependencies up to date
- Use HTTPS in production
- Implement proper authentication
- Use environment variables for secrets
- Regular security audits
- Monitor logs for suspicious activity

### For Contributors
- Never commit secrets or credentials
- Validate all user input
- Follow secure coding practices
- Report vulnerabilities responsibly
- Keep dependencies updated

## Known Issues

None currently known. Please report any security issues responsibly.

## Security Headers

The template supports setting security headers:

```julia
# In config.toml
[security]
strict_transport_security = true
content_security_policy = true
x_frame_options = "DENY"
x_content_type_options = "nosniff"
```

## Dependency Updates

Dependencies are regularly updated to address security issues. Check:
- Julia package registry
- GitHub security advisories
- Dependabot notifications

## Questions?

For security-related questions, please contact the maintainers privately.

---

Version: 1.0  
Last Updated: 2024
