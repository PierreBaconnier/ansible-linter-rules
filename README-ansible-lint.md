# Ansible Lint Configuration Guide

## Quick Start

This project includes a state-of-the-art ansible-lint configuration optimized for production environments using ansible-core.

### Installation & Setup

1. **Install ansible-lint:**
   ```bash
   pip install ansible-lint
   ```

2. **Use the configuration:**
   ```bash
   # The .ansible-lint file is already configured
   ansible-lint
   ```

3. **Customize if needed:**
   - Edit `.ansible-lint` to add/remove rules
   - Modify `exclude_paths` for your project structure
   - Adjust verbosity and output preferences

### Configuration Files

- **`.ansible-lint`** - Main configuration with comprehensive rule exclusions
- **`ansible-lint-config.md`** - Detailed documentation of all exclusions
- **`README-ansible-lint.md`** - This quick start guide
- **`ansible-lint-examples/`** - Sample ansible structure for testing

### Common Commands

```bash
# Basic linting
ansible-lint

# Lint specific file
ansible-lint playbook.yml

# Lint with output to file
ansible-lint --format=sarif --output=results.sarif

# Lint with custom config
ansible-lint -c .ansible-lint

# Show all available rules
ansible-lint --list

# Check configuration
ansible-lint --help
```

### Integration Examples

#### GitHub Actions
```yaml
name: Ansible Lint
on: [push, pull_request]
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run ansible-lint
        uses: ansible/ansible-lint-action@main
```

#### GitLab CI
```yaml
ansible-lint:
  stage: test
  script:
    - pip install ansible-lint
    - ansible-lint
  artifacts:
    reports:
      junit: results.xml
```

#### Pre-commit Hook
```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/ansible/ansible-lint
    rev: v24.2.0
    hooks:
      - id: ansible-lint
```

### Key Features

- **Comprehensive Rule Coverage:** 50+ rules categorized and documented
- **Production-Ready:** Optimized for real-world scenarios
- **Flexible:** Easy to customize for specific needs
- **Well-Documented:** Clear rationale for each exclusion
- **CI/CD Ready:** Supports SARIF output and automation

### Support

- Check `ansible-lint-config.md` for detailed rule explanations
- Review `ansible-lint-examples/` for usage patterns
- Consult ansible-lint documentation for advanced options