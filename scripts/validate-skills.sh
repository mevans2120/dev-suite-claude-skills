#!/bin/bash

# Skill Suite Validation Script
# Validates all skills in the Digital Product Development Skill Suite

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
TOTAL_CHECKS=0
PASSED_CHECKS=0
FAILED_CHECKS=0
WARNINGS=0

# Skill directories
SKILLS=(
  "product-research"
  "technical-architecture"
  "software-development"
  "quality-engineering"
)

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Skill Suite Validation${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Helper functions
check_pass() {
  ((TOTAL_CHECKS++))
  ((PASSED_CHECKS++))
  echo -e "${GREEN}✅ $1${NC}"
}

check_fail() {
  ((TOTAL_CHECKS++))
  ((FAILED_CHECKS++))
  echo -e "${RED}❌ $1${NC}"
}

check_warn() {
  ((WARNINGS++))
  echo -e "${YELLOW}⚠️  $1${NC}"
}

info() {
  echo -e "${BLUE}ℹ️  $1${NC}"
}

# 1. Check directory structure
echo -e "${BLUE}1. Checking directory structure...${NC}"
for skill in "${SKILLS[@]}"; do
  if [ -d "$skill" ]; then
    check_pass "Directory exists: $skill/"
  else
    check_fail "Directory missing: $skill/"
  fi
done
echo ""

# 2. Check SKILL.md files exist
echo -e "${BLUE}2. Checking SKILL.md files...${NC}"
for skill in "${SKILLS[@]}"; do
  if [ -f "$skill/SKILL.md" ]; then
    check_pass "SKILL.md exists: $skill/SKILL.md"
  else
    check_fail "SKILL.md missing: $skill/SKILL.md"
  fi
done
echo ""

# 3. Check frontmatter format
echo -e "${BLUE}3. Validating frontmatter...${NC}"
for skill in "${SKILLS[@]}"; do
  if [ ! -f "$skill/SKILL.md" ]; then
    continue
  fi

  # Extract frontmatter (between first two --- markers)
  frontmatter=$(awk '/^---$/{i++; next}i==1{print}i==2{exit}' "$skill/SKILL.md")

  # Check for required fields
  if echo "$frontmatter" | grep -q "^name:"; then
    name=$(echo "$frontmatter" | grep "^name:" | sed 's/name: *//')

    # Verify name matches directory
    if [ "$name" == "$skill" ]; then
      check_pass "$skill: name matches directory"
    else
      check_fail "$skill: name '$name' doesn't match directory '$skill'"
    fi

    # Check name format (lowercase, hyphens, numbers only)
    if echo "$name" | grep -qE '^[a-z0-9-]+$'; then
      check_pass "$skill: name format is valid"
    else
      check_fail "$skill: name format invalid (use lowercase, hyphens, numbers only)"
    fi

    # Check name length
    name_length=${#name}
    if [ $name_length -le 64 ]; then
      check_pass "$skill: name length OK ($name_length chars)"
    else
      check_fail "$skill: name too long ($name_length chars, max 64)"
    fi
  else
    check_fail "$skill: 'name' field missing in frontmatter"
  fi

  # Check description field
  if echo "$frontmatter" | grep -q "^description:"; then
    description=$(echo "$frontmatter" | grep "^description:" | sed 's/description: *//')
    desc_length=${#description}

    if [ $desc_length -le 1024 ]; then
      check_pass "$skill: description length OK ($desc_length chars)"
    else
      check_fail "$skill: description too long ($desc_length chars, max 1024)"
    fi

    if [ $desc_length -lt 50 ]; then
      check_warn "$skill: description is quite short ($desc_length chars)"
    fi
  else
    check_fail "$skill: 'description' field missing in frontmatter"
  fi

  # Check for version field (optional but present)
  if echo "$frontmatter" | grep -q "^version:"; then
    version=$(echo "$frontmatter" | grep "^version:" | sed 's/version: *//')
    info "$skill: version $version"
  fi
done
echo ""

# 4. Check content structure
echo -e "${BLUE}4. Validating content structure...${NC}"
for skill in "${SKILLS[@]}"; do
  if [ ! -f "$skill/SKILL.md" ]; then
    continue
  fi

  # Check for H1 heading (skill title)
  if grep -q "^# " "$skill/SKILL.md"; then
    check_pass "$skill: has H1 heading"
  else
    check_warn "$skill: no H1 heading found"
  fi

  # Check for "When to Use" section
  if grep -qi "when to use" "$skill/SKILL.md"; then
    check_pass "$skill: has 'When to Use' section"
  else
    check_warn "$skill: 'When to Use' section not found"
  fi

  # Check for examples
  if grep -qi "example" "$skill/SKILL.md"; then
    check_pass "$skill: contains examples"
  else
    check_warn "$skill: no examples found"
  fi

  # Check minimum content length
  line_count=$(wc -l < "$skill/SKILL.md")
  if [ $line_count -ge 100 ]; then
    check_pass "$skill: sufficient content ($line_count lines)"
  else
    check_warn "$skill: content seems short ($line_count lines)"
  fi
done
echo ""

# 5. Check for common documentation files
echo -e "${BLUE}5. Checking documentation files...${NC}"
if [ -f "README.md" ]; then
  check_pass "README.md exists"
else
  check_fail "README.md missing"
fi

if [ -f "QUICK-START.md" ]; then
  check_pass "QUICK-START.md exists"
else
  check_warn "QUICK-START.md recommended"
fi

if [ -f "TESTING.md" ]; then
  check_pass "TESTING.md exists"
else
  check_warn "TESTING.md recommended"
fi

if [ -f "LICENSE" ]; then
  check_pass "LICENSE file exists"
else
  check_warn "LICENSE file recommended"
fi
echo ""

# 6. Check for .gitignore
echo -e "${BLUE}6. Checking repository configuration...${NC}"
if [ -f ".gitignore" ]; then
  check_pass ".gitignore exists"
else
  check_warn ".gitignore recommended"
fi

if [ -d ".git" ]; then
  info "Git repository initialized"
else
  check_warn "Not a git repository"
fi
echo ""

# 7. Check README references
echo -e "${BLUE}7. Validating README references...${NC}"
if [ -f "README.md" ]; then
  # Check if README references use new directory names
  for skill in "${SKILLS[@]}"; do
    if grep -q "$skill/" README.md; then
      check_pass "README references: $skill/"
    else
      check_warn "README doesn't reference: $skill/"
    fi
  done

  # Check for old directory names (should not exist)
  old_dirs=("dev-research" "dev-planning" "dev-coding" "dev-qe")
  for old_dir in "${old_dirs[@]}"; do
    if grep -q "$old_dir/" README.md; then
      check_fail "README contains old reference: $old_dir/"
    fi
  done
fi
echo ""

# Summary
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Validation Summary${NC}"
echo -e "${BLUE}========================================${NC}"
echo -e "Total checks:   ${TOTAL_CHECKS}"
echo -e "${GREEN}Passed:         ${PASSED_CHECKS}${NC}"
if [ $FAILED_CHECKS -gt 0 ]; then
  echo -e "${RED}Failed:         ${FAILED_CHECKS}${NC}"
else
  echo -e "Failed:         ${FAILED_CHECKS}"
fi
if [ $WARNINGS -gt 0 ]; then
  echo -e "${YELLOW}Warnings:       ${WARNINGS}${NC}"
else
  echo -e "Warnings:       ${WARNINGS}"
fi
echo ""

# Exit code
if [ $FAILED_CHECKS -eq 0 ]; then
  echo -e "${GREEN}✅ All critical validations passed!${NC}"
  if [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Some warnings were found (non-critical)${NC}"
  fi
  exit 0
else
  echo -e "${RED}❌ Some validations failed. Please fix the issues above.${NC}"
  exit 1
fi
