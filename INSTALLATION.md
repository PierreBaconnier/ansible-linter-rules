# Ansible Lint Configuration Installation Guide

## Quick Installation

### Prerequisites
- Python 3.8 or higher
- pip package manager
- ansible-core 2.12 or higher

### Installation Steps

1. **Install ansible-lint:**
   ```bash
   pip install ansible-lint
   ```

2. **Copy configuration files:**
   ```bash
   # Copy the main configuration
   cp .ansible-lint /path/to/your/ansible/project/
   
   # Optional: Copy examples and documentation
   cp -r ansible-lint-examples/ /path/to/your/ansible/project/
   cp ansible-lint-config.md /path/to/your/ansible/project/
   ```

3. **Test the configuration:**
   ```bash
   # Run the test script
   ./test-ansible-lint.sh
   
   # Or test manually
   ansible-lint
   ```

## What's Included

### Core Files
- **`.ansible-lint`** - Main configuration with 50+ rule exclusions
- **`ansible-lint-config.md`** - Detailed documentation of all rules
- **`README-ansible-lint.md`** - Quick start guide
- **`test-ansible-lint.sh`** - Testing script

### Example Structure
- **`ansible-lint-examples/`** - Complete sample ansible project
  - `playbooks/` - Example playbooks demonstrating flexible patterns
  - `roles/` - Sample roles with real-world scenarios
  - `group_vars/` - Group variable examples
  - `host_vars/` - Host-specific variable examples
  - `inventory/` - Sample inventory file
  - `requirements.yml` - Galaxy dependencies

## Configuration Features

### Rule Categories Covered
1. **Syntax & Formatting** - Line length, indentation, spacing
2. **Commands & Modules** - Shell usage, module alternatives
3. **Variables & Templating** - Naming conventions, Jinja2 patterns
4. **Tasks & Plays** - Naming requirements, structure flexibility
5. **Loops & Conditionals** - Variable patterns, conditional logic
6. **Handlers** - Notification patterns, dependencies
7. **Roles & Collections** - Metadata requirements, structure
8. **Security** - Permission handling, risk management
9. **Performance** - Package management, efficiency
10. **Legacy Support** - Deprecated features, migration support
11. **Development** - Testing patterns, debug flexibility

### Excluded Paths
- Cache and temporary directories
- CI/CD configurations
- Virtual environments
- Build artifacts
- Third-party code
- Documentation examples
- Testing fixtures

## Usage Examples

### Basic Usage
```bash
# Lint entire project
ansible-lint

# Lint specific file
ansible-lint playbook.yml

# Lint with verbose output
ansible-lint -v

# Generate SARIF output for CI/CD
ansible-lint --format=sarif --output=results.sarif
```

### CI/CD Integration

#### GitHub Actions
```yaml
name: Ansible Lint
on: [push, pull_request]
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install ansible-lint
        run: pip install ansible-lint
      - name: Run ansible-lint
        run: ansible-lint
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

#### Jenkins Pipeline
```groovy
pipeline {
    agent any
    stages {
        stage('Lint') {
            steps {
                sh 'pip install ansible-lint'
                sh 'ansible-lint'
            }
        }
    }
}
```

## Customization

### Project-Specific Adjustments
1. **Review excluded rules:**
   ```bash
   # Check which rules are excluded
   grep -A 50 "skip_list:" .ansible-lint
   ```

2. **Adjust for your needs:**
   - Remove exclusions that don't apply
   - Add project-specific exclusions
   - Modify excluded paths

3. **Test changes:**
   ```bash
   ./test-ansible-lint.sh
   ```

### Environment-Specific Configurations

#### Development Environment
```yaml
# .ansible-lint-dev
skip_list:
  - 'yaml[line-length]'
  - 'name[template]'
  - 'var-naming'
  - 'command-instead-of-module'
```

#### Production Environment
```yaml
# .ansible-lint-prod
skip_list:
  - 'yaml[line-length]'
strict: true
```

## Maintenance

### Regular Tasks
- **Monthly:** Review new ansible-lint releases
- **Quarterly:** Update rule exclusions based on project changes
- **Annually:** Complete configuration review

### Updating
```bash
# Update ansible-lint
pip install --upgrade ansible-lint

# Check for new rules
ansible-lint --list-rules

# Test with new version
./test-ansible-lint.sh
```

## Troubleshooting

### Common Issues
1. **Too many warnings:** Review exclusions or increase verbosity
2. **Rules not excluded:** Check YAML formatting in .ansible-lint
3. **Performance issues:** Review excluded paths
4. **CI/CD failures:** Check SARIF output format

### Getting Help
- Review `ansible-lint-config.md` for detailed explanations
- Check ansible-lint documentation
- Test with `./test-ansible-lint.sh`

## Best Practices

1. **Start with this configuration** as a baseline
2. **Gradually remove exclusions** as your codebase matures
3. **Document any custom exclusions** with rationale
4. **Test regularly** with different ansible-lint versions
5. **Review periodically** to ensure rules are still relevant

## Support

For issues or questions:
1. Check the documentation files
2. Review the example structure
3. Test with the provided script
4. Consult ansible-lint official documentation