# Ansible Lint Examples

This directory contains sample Ansible structures to demonstrate how the exclusion ruleset works in practice.

## Directory Structure

```
ansible-lint-examples/
├── README.md                 # This file
├── inventory/               # Sample inventory files
├── playbooks/              # Sample playbooks
├── roles/                  # Sample roles
├── group_vars/             # Group variables
├── host_vars/              # Host variables
├── ansible.cfg             # Ansible configuration
└── requirements.yml        # Dependencies
```

## Usage

1. **Test the configuration:**
   ```bash
   cd ansible-lint-examples
   ansible-lint
   ```

2. **Run specific tests:**
   ```bash
   ansible-lint playbooks/site.yml
   ansible-lint roles/webserver/
   ```

3. **Compare with strict settings:**
   ```bash
   # Create temporary strict config
   echo "skip_list: []" > .ansible-lint-strict
   ansible-lint -c .ansible-lint-strict
   ```

## What These Examples Demonstrate

- **Flexible naming:** Various naming conventions that would trigger strict rules
- **Command usage:** Legitimate use of shell/command modules
- **Variable patterns:** Different variable naming and templating approaches
- **Complex structures:** Nested roles and advanced playbook patterns
- **Real-world scenarios:** Common patterns that require rule flexibility

## Expected Behavior

With the exclusion ruleset:
- ✅ Should pass linting with minimal warnings
- ✅ Demonstrates practical ansible patterns
- ✅ Shows where flexibility is beneficial

Without exclusions:
- ❌ Would generate many warnings/errors
- ❌ Would require significant refactoring
- ❌ Would slow down development

## Testing Different Scenarios

### 1. Development Environment
```bash
# Use full exclusions (default)
ansible-lint
```

### 2. Staging Environment
```bash
# Use moderate exclusions
ansible-lint --skip-list command-instead-of-module,yaml[line-length]
```

### 3. Production Environment
```bash
# Use minimal exclusions
ansible-lint --skip-list yaml[line-length]
```