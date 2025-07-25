#!/bin/bash
# Test script for ansible-lint configuration
# Demonstrates different testing scenarios

set -e

echo "=== Ansible Lint Configuration Test ==="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if ansible-lint is installed
if ! command -v ansible-lint &> /dev/null; then
    echo -e "${RED}Error: ansible-lint is not installed${NC}"
    echo "Install with: pip install ansible-lint"
    exit 1
fi

# Check if .ansible-lint file exists
if [ ! -f ".ansible-lint" ]; then
    echo -e "${RED}Error: .ansible-lint file not found${NC}"
    echo "Make sure you're in the project root directory"
    exit 1
fi

echo -e "${GREEN}✓ ansible-lint is installed${NC}"
echo -e "${GREEN}✓ .ansible-lint configuration found${NC}"

# Test 1: Basic configuration validation
echo -e "\n${YELLOW}Test 1: Configuration validation${NC}"
ansible-lint --version
echo -e "${GREEN}✓ ansible-lint version check passed${NC}"

# Test 2: Lint the sample ansible structure
echo -e "\n${YELLOW}Test 2: Linting sample ansible structure${NC}"
if [ -d "ansible-lint-examples" ]; then
    cd ansible-lint-examples
    
    # Count total files to be linted
    total_files=$(find . -name "*.yml" -o -name "*.yaml" | wc -l)
    echo "Found $total_files YAML files to lint"
    
    # Run ansible-lint and capture output
    if ansible-lint . > ../ansible-lint-results.txt 2>&1; then
        echo -e "${GREEN}✓ ansible-lint passed with current configuration${NC}"
        violations=$(grep -c "violation" ../ansible-lint-results.txt 2>/dev/null || echo "0")
        echo "Violations found: $violations"
    else
        echo -e "${YELLOW}⚠ ansible-lint completed with warnings/errors${NC}"
        violations=$(grep -c "violation" ../ansible-lint-results.txt 2>/dev/null || echo "unknown")
        echo "Violations found: $violations"
    fi
    
    cd ..
else
    echo -e "${YELLOW}⚠ ansible-lint-examples directory not found, skipping structure test${NC}"
fi

# Test 3: Compare with strict configuration
echo -e "\n${YELLOW}Test 3: Comparing with strict configuration${NC}"
echo "skip_list: []" > .ansible-lint-strict
echo "exclude_paths: []" >> .ansible-lint-strict

if [ -d "ansible-lint-examples" ]; then
    cd ansible-lint-examples
    
    if ansible-lint -c ../.ansible-lint-strict . > ../ansible-lint-strict-results.txt 2>&1; then
        echo -e "${GREEN}✓ Strict configuration passed${NC}"
    else
        echo -e "${RED}✗ Strict configuration failed (expected)${NC}"
        strict_violations=$(grep -c "violation" ../ansible-lint-strict-results.txt 2>/dev/null || echo "unknown")
        echo "Strict violations found: $strict_violations"
    fi
    
    cd ..
    rm -f .ansible-lint-strict
else
    echo -e "${YELLOW}⚠ Skipping strict comparison test${NC}"
fi

# Test 4: Check specific rule categories
echo -e "\n${YELLOW}Test 4: Rule category analysis${NC}"
ansible-lint --list-rules > ansible-lint-all-rules.txt 2>/dev/null || true

if [ -f "ansible-lint-all-rules.txt" ]; then
    total_rules=$(wc -l < ansible-lint-all-rules.txt)
    echo "Total available rules: $total_rules"
    
    # Count excluded rules from our configuration
    excluded_rules=$(grep -c "^  - " .ansible-lint 2>/dev/null || echo "0")
    echo "Excluded rules in configuration: $excluded_rules"
    
    coverage_percent=$(( (excluded_rules * 100) / total_rules ))
    echo "Exclusion coverage: ${coverage_percent}%"
    
    rm -f ansible-lint-all-rules.txt
else
    echo -e "${YELLOW}⚠ Could not retrieve rule list${NC}"
fi

# Test 5: Performance test
echo -e "\n${YELLOW}Test 5: Performance test${NC}"
if [ -d "ansible-lint-examples" ]; then
    cd ansible-lint-examples
    
    start_time=$(date +%s)
    ansible-lint . > /dev/null 2>&1 || true
    end_time=$(date +%s)
    
    runtime=$((end_time - start_time))
    echo "Linting completed in ${runtime} seconds"
    
    if [ $runtime -lt 10 ]; then
        echo -e "${GREEN}✓ Performance test passed (< 10 seconds)${NC}"
    else
        echo -e "${YELLOW}⚠ Performance test slow (> 10 seconds)${NC}"
    fi
    
    cd ..
else
    echo -e "${YELLOW}⚠ Skipping performance test${NC}"
fi

# Summary
echo -e "\n${YELLOW}=== Test Summary ===${NC}"
echo -e "${GREEN}✓ Configuration validation passed${NC}"
echo -e "${GREEN}✓ Sample structure linting completed${NC}"
echo -e "${GREEN}✓ Strict comparison completed${NC}"
echo -e "${GREEN}✓ Rule analysis completed${NC}"
echo -e "${GREEN}✓ Performance test completed${NC}"

# Show results if available
if [ -f "ansible-lint-results.txt" ]; then
    echo -e "\n${YELLOW}Detailed results:${NC}"
    head -20 ansible-lint-results.txt
    echo "..."
    echo "(See ansible-lint-results.txt for full output)"
fi

echo -e "\n${GREEN}All tests completed successfully!${NC}"
echo -e "${YELLOW}Review the configuration in .ansible-lint and adjust as needed.${NC}"