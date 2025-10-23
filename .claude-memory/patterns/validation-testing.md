# Skill Validation and Testing Patterns

## Validation Script Pattern

### Structure
```bash
#!/bin/bash
set -e  # Exit on error

# Configuration
SKILLS=(skill1 skill2 skill3)
TOTAL_CHECKS=0
PASSED_CHECKS=0
FAILED_CHECKS=0

# Helper functions
check_pass() {
  ((TOTAL_CHECKS++))
  ((PASSED_CHECKS++))
  echo "✅ $1"
}

check_fail() {
  ((TOTAL_CHECKS++))
  ((FAILED_CHECKS++))
  echo "❌ $1"
}

# Validation sections
# 1. Directory structure
# 2. File existence
# 3. Frontmatter validation
# 4. Content validation
# 5. Documentation checks

# Summary and exit
```

### Key Validations

**Directory Structure:**
- Check each skill directory exists
- Verify naming conventions

**File Existence:**
- SKILL.md present in each directory
- README.md, documentation files exist

**Frontmatter Validation:**
```bash
# Extract frontmatter
frontmatter=$(awk '/^---$/{i++; next}i==1{print}i==2{exit}' "$skill/SKILL.md")

# Check required fields
grep -q "^name:" <<< "$frontmatter"
grep -q "^description:" <<< "$frontmatter"

# Validate name format
name=$(grep "^name:" <<< "$frontmatter" | sed 's/name: *//')
[[ $name =~ ^[a-z0-9-]+$ ]]  # Only lowercase, numbers, hyphens

# Check lengths
name_length=${#name}
[ $name_length -le 64 ]

description=$(grep "^description:" <<< "$frontmatter" | sed 's/description: *//')
desc_length=${#description}
[ $desc_length -le 1024 ]
```

**Content Validation:**
```bash
# Check for H1 heading
grep -q "^# " "$skill/SKILL.md"

# Check for required sections
grep -qi "when to use" "$skill/SKILL.md"
grep -qi "example" "$skill/SKILL.md"

# Minimum content check
line_count=$(wc -l < "$skill/SKILL.md")
[ $line_count -ge 100 ]
```

## Testing Patterns

### Functional Testing Approach

**1. Per-Skill Tests:**
```markdown
### Skill: product-research

**Test Prompt:**
"I want to build a task management app. Can you research the market?"

**Expected:**
- Skill loads automatically
- Provides competitive analysis
- Identifies market opportunities
- Suggests technologies

**Verification:**
- [ ] Skill activated
- [ ] Response includes market data
- [ ] Recommendations are specific
```

**2. Multi-Skill Workflow:**
```markdown
**Test Prompt:**
"Build a blog platform from scratch - research, architecture, implementation, testing"

**Expected:**
- Multiple skills load in sequence
- Research → Architecture → Development → QE
- Comprehensive deliverables

**Verification:**
- [ ] All skills invoked
- [ ] Logical progression
- [ ] Complete solution
```

### Test Documentation Template

```markdown
# Skill: [name]

## Test 1: [Scenario]
**Prompt:** [exact prompt]
**Expected Behavior:** [what should happen]
**Verification:**
- [ ] Checklist item 1
- [ ] Checklist item 2

## Test 2: [Scenario]
...

## Common Issues
- Issue 1: [description and fix]
- Issue 2: [description and fix]
```

## Quality Criteria Checklist

### Skill-Level Quality
```markdown
Skill is complete when:
- ✅ Frontmatter valid
- ✅ Name/directory match
- ✅ Description clear and specific
- ✅ Content comprehensive (100+ lines)
- ✅ Examples included
- ✅ "When to Use" section present
- ✅ Integration documented
- ✅ Best practices listed
```

### Suite-Level Quality
```markdown
Suite is ready when:
- ✅ All skills pass validation
- ✅ Documentation complete (README, INSTALL, TESTING)
- ✅ Validation script exists and passes
- ✅ Skills tested functionally
- ✅ Multi-skill workflows tested
- ✅ Installation verified
- ✅ Git repository clean
```

## Continuous Validation

### Pre-Commit
```bash
# Run before each commit
./scripts/validate-skills.sh

# Ensure all checks pass
```

### Pre-Push
```bash
# Validate + test
./scripts/validate-skills.sh
# Run functional tests
```

### Pre-Release
```bash
# Full validation
./scripts/validate-skills.sh

# Create distribution package
zip -r release.zip . -x "*.git*" -x ".claude-memory/*"

# Test installation in clean environment
```

## Troubleshooting Patterns

### Skill Not Loading

**Check 1: Frontmatter**
```bash
head -10 skill-name/SKILL.md
# Verify YAML is valid
```

**Check 2: Description Keywords**
```bash
grep "^description:" skill-name/SKILL.md
# Ensure trigger words present
```

**Check 3: Installation**
```bash
# Personal skills
ls -la ~/.claude/skills/skill-name

# Project skills
ls -la .claude/skills/skill-name
```

**Check 4: Explicit Invocation**
```
Using the [skill-name] skill, help me...
```

### YAML Errors

**Common Issues:**
- Missing closing `---`
- Unquoted special characters in description
- Incorrect indentation

**Validation:**
```bash
python3 -c "import yaml; yaml.safe_load(open('skill/SKILL.md').read().split('---')[1])"
```

### Content Issues

**Empty Sections:**
- Add placeholder content
- Mark as "Coming soon"
- Or remove section entirely

**Too Short:**
- Expand with examples
- Add more detail
- Include code samples

## Performance Metrics

### Validation Speed
- Target: <5 seconds for full suite
- Benchmark: 49 checks in ~2 seconds

### Test Coverage
- All skills: functional test
- Multi-skill: workflow test
- Edge cases: error handling

### Quality Score
```
Quality Score = (Passed Checks / Total Checks) × 100
Target: 100%
Minimum: 95%
```
