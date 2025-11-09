# Contributing to VMware vSphere 7 Learning Hub

Thank you for your interest in contributing to this project! This guide will help you get started.

## 🤝 How to Contribute

### Types of Contributions

We welcome several types of contributions:

- **Documentation improvements** - Fix typos, clarify instructions, add examples
- **New tutorials** - Create step-by-step guides for vSphere topics
- **Scripts and tools** - Add automation scripts, utilities, or examples
- **Lab exercises** - Develop hands-on learning experiences
- **Bug fixes** - Correct errors in existing content or code
- **Feature requests** - Suggest new content or improvements

### Getting Started

1. **Fork the repository**
   ```bash
   # Click the "Fork" button on GitHub, then clone your fork
   git clone https://github.com/YOUR-USERNAME/vmware-vsphere-7-learn.git
   cd vmware-vsphere-7-learn
   ```

2. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/issue-description
   ```

3. **Make your changes**
   - Follow the existing code style and documentation format
   - Test your scripts and examples thoroughly
   - Update documentation as needed

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add: Brief description of your changes"
   ```

5. **Push and create a Pull Request**
   ```bash
   git push origin feature/your-feature-name
   ```

## 📝 Content Guidelines

### Documentation Standards

- Use clear, concise language
- Include code examples where appropriate
- Add screenshots for GUI-based procedures
- Follow the existing markdown structure
- Test all procedures before submitting

### Code Standards

#### PowerCLI Scripts
```powershell
# Use approved verbs and proper error handling
# Include parameter validation
# Add comprehensive help documentation
# Follow PowerShell best practices
```

#### Python Scripts
```python
# Follow PEP 8 style guidelines
# Include docstrings for functions and classes
# Use type hints where appropriate
# Handle exceptions properly
# Add logging for debugging
```

#### Bash Scripts
```bash
#!/bin/bash
# Use proper shebang
# Include error handling with set -e
# Add usage information
# Follow shell scripting best practices
```

### Security Guidelines

- **Never include credentials** in any files
- Use placeholder values like `<vcenter-server>`, `<username>`, `<password>`
- Sanitize any logs or outputs before including them
- Follow VMware security best practices

## 🧪 Testing

### Before Submitting

1. **Test all scripts** in a lab environment
2. **Verify documentation** steps work as described
3. **Check for typos** and formatting issues
4. **Validate links** and references
5. **Run any existing tests**

### Lab Environment

- Use VMware Workstation/Fusion for testing
- Test with vSphere 7.0+ environments
- Verify compatibility with different PowerCLI versions
- Test Python scripts with supported Python versions

## 📋 Pull Request Process

### PR Checklist

- [ ] Branch is up to date with main
- [ ] All tests pass
- [ ] Documentation is updated
- [ ] Code follows style guidelines
- [ ] No sensitive information included
- [ ] Changes are described clearly

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Other (please describe)

## Testing
- [ ] Tested in lab environment
- [ ] All scripts execute successfully
- [ ] Documentation steps verified
- [ ] No errors in logs

## Screenshots (if applicable)
Add screenshots to help explain your changes

## Additional Notes
Any additional information or context
```

## 🐛 Reporting Issues

### Bug Reports

When reporting bugs, please include:

- **Environment details** (vSphere version, PowerCLI version, OS)
- **Steps to reproduce** the issue
- **Expected behavior** vs actual behavior
- **Error messages** or logs
- **Screenshots** if applicable

### Feature Requests

For new features, please provide:

- **Clear description** of the proposed feature
- **Use case** or problem it solves
- **Proposed implementation** (if you have ideas)
- **Examples** of similar features elsewhere

## 📚 Style Guide

### Markdown Formatting

- Use consistent heading levels
- Include table of contents for long documents
- Use code blocks with appropriate language tags
- Add alt text for images
- Use relative links for internal references

### File Organization

```
docs/
├── tutorials/           # Step-by-step learning content
├── guides/             # Reference and best practices
├── api-reference/      # Technical documentation
└── troubleshooting/    # Problem-solving guides

scripts/
├── powercli/          # PowerShell/PowerCLI scripts
├── python/            # Python automation scripts
└── bash/              # Shell scripts and utilities

examples/
├── basic/             # Simple, introductory examples
└── advanced/          # Complex, real-world scenarios
```

## 🏷️ Commit Message Guidelines

Use conventional commit format:

```
type(scope): description

[optional body]

[optional footer]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples:**
```
feat(scripts): add VM deployment automation script
fix(docs): correct PowerCLI installation instructions
docs(tutorials): add networking configuration guide
```

## 🎯 Recognition

Contributors will be recognized in:

- README.md acknowledgments section
- Release notes for significant contributions
- GitHub contributor statistics
- Special mentions for outstanding contributions

## 📞 Getting Help

If you need help with contributing:

- Check existing [Issues](../../issues) and [Discussions](../../discussions)
- Review the [Wiki](../../wiki) for detailed guides
- Ask questions in [Discussions](../../discussions)
- Contact maintainers through GitHub

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for helping make this project better! 🙏# Updated Sun Nov  9 12:49:15 CET 2025
# Updated Sun Nov  9 12:52:45 CET 2025
