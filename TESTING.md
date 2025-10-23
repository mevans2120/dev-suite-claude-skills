# Skill Suite Testing & Verification Guide

This document provides comprehensive testing procedures to verify your Digital Product Development Skill Suite is properly formatted and functional.

## Quick Validation Checklist

Run these checks before using or distributing the skills:

- [ ] Directory names match skill names in frontmatter
- [ ] Each skill directory contains a `SKILL.md` file
- [ ] YAML frontmatter is valid and contains required fields
- [ ] Skill names use lowercase-hyphen format (max 64 chars)
- [ ] Descriptions are under 1024 characters
- [ ] Skills load successfully in Claude

## Automated Validation Script

Run this script to validate all skills:

```bash
./scripts/validate-skills.sh
```

See [scripts/validate-skills.sh](scripts/validate-skills.sh) for implementation details.

## Manual Verification Steps

### 1. File Structure Verification

**Check directory structure:**
```bash
ls -la | grep -E "^d" | grep -v "^\."
```

**Expected output:**
- `product-research/`
- `technical-architecture/`
- `software-development/`
- `quality-engineering/`

**Check SKILL.md files exist:**
```bash
for dir in product-research technical-architecture software-development quality-engineering; do
  if [ -f "$dir/SKILL.md" ]; then
    echo "✅ $dir/SKILL.md exists"
  else
    echo "❌ $dir/SKILL.md missing"
  fi
done
```

### 2. Frontmatter Validation

**Extract and verify frontmatter:**
```bash
for dir in product-research technical-architecture software-development quality-engineering; do
  echo "=== $dir ==="
  head -5 "$dir/SKILL.md"
  echo ""
done
```

**Required frontmatter fields:**
```yaml
---
name: skill-name
description: Brief description of what this Skill does and when to use it
---
```

**Validation criteria:**
- ✅ `name` field present and matches directory name
- ✅ `name` uses lowercase letters, numbers, and hyphens only
- ✅ `name` is max 64 characters
- ✅ `description` field present
- ✅ `description` is max 1024 characters
- ✅ YAML is properly formatted

### 3. Content Validation

**Check content structure:**
```bash
grep -n "^# " product-research/SKILL.md | head -5
```

**Each SKILL.md should include:**
- Clear skill title (H1 heading)
- "When to Use This Skill" section
- Core principles or methodology
- Examples and use cases
- Integration with other skills
- Best practices
- Quality criteria

## Installation Testing

### Option 1: Test as Plugin (Recommended)

**1. Package the skill suite:**
```bash
# From project root
zip -r dev-suite-skills.zip . -x "*.git*" -x ".claude-memory/*"
```

**2. Install as plugin in Claude Code:**
```bash
# Method 1: Local installation
claude plugin add /path/to/dev-suite-claude-skills

# Method 2: From zip
claude plugin add /path/to/dev-suite-skills.zip
```

**3. Verify installation:**
```bash
# List installed plugins
claude plugin list

# Should show: dev-suite-claude-skills
```

**4. Check skill availability:**
```bash
# Start Claude Code and type:
/help

# Skills should appear in the available skills list
```

### Option 2: Test as Project Skills

**1. Copy to Claude skills directory:**
```bash
# Create .claude/skills directory in your test project
mkdir -p ~/.test-project/.claude/skills

# Copy skill directories
cp -r product-research ~/.test-project/.claude/skills/
cp -r technical-architecture ~/.test-project/.claude/skills/
cp -r software-development ~/.test-project/.claude/skills/
cp -r quality-engineering ~/.test-project/.claude/skills/
```

**2. Navigate to test project:**
```bash
cd ~/.test-project
claude
```

**3. Verify skills are loaded:**
Skills should automatically load when their descriptions match your requests.

## Functional Testing

### Test Each Skill with Sample Prompts

#### 1. Product Research Skill

**Test prompt:**
```
I want to build a task management app for remote teams. Can you research
the market and analyze competitors?
```

**Expected behavior:**
- Claude should load the `product-research` skill
- Provide competitive analysis
- Identify market opportunities
- Suggest technology options

**Verification:**
- [ ] Skill loads automatically
- [ ] Response includes market analysis
- [ ] Response includes competitor research
- [ ] Response provides actionable recommendations

#### 2. Technical Architecture Skill

**Test prompt:**
```
Design the architecture for a real-time collaborative task board.
Use modern, AI-friendly technologies.
```

**Expected behavior:**
- Claude should load the `technical-architecture` skill
- Propose specific tech stack (Next.js, Supabase, etc.)
- Create architecture diagrams or descriptions
- Document architectural decisions

**Verification:**
- [ ] Skill loads automatically
- [ ] Response includes specific technology recommendations
- [ ] Response includes architecture design
- [ ] Response explains trade-offs and rationale

#### 3. Software Development Skill

**Test prompt:**
```
Implement user authentication with email/password using NextAuth.js.
Include tests following TDD.
```

**Expected behavior:**
- Claude should load the `software-development` skill
- Write actual implementation code
- Follow TDD approach with tests
- Include proper error handling

**Verification:**
- [ ] Skill loads automatically
- [ ] Code follows best practices from skill
- [ ] Tests are written (if TDD applicable)
- [ ] TypeScript types are proper
- [ ] Error handling is comprehensive

#### 4. Quality Engineering Skill

**Test prompt:**
```
Analyze test coverage for the user authentication module and recommend
improvements.
```

**Expected behavior:**
- Claude should load the `quality-engineering` skill
- Analyze current coverage
- Identify gaps
- Prioritize testing improvements
- Provide test examples

**Verification:**
- [ ] Skill loads automatically
- [ ] Coverage analysis is comprehensive
- [ ] Gaps are identified and prioritized
- [ ] Concrete test recommendations provided

### Multi-Skill Workflow Testing

**Test prompt:**
```
Help me build a simple blog platform from scratch. I need research,
architecture, implementation, and testing.
```

**Expected behavior:**
- Multiple skills should be used in sequence
- Research → Planning → Development → QE
- Each phase builds on previous phase
- Comprehensive deliverables

**Verification:**
- [ ] All relevant skills are loaded
- [ ] Workflow follows logical progression
- [ ] Each skill contributes appropriately
- [ ] Final deliverable is complete

## Troubleshooting

### Skills Not Loading

**Issue:** Claude doesn't seem to use the skills

**Checks:**
1. Verify installation:
   ```bash
   claude plugin list
   # or check ~/.claude/skills/ directory
   ```

2. Check frontmatter syntax:
   ```bash
   head -10 product-research/SKILL.md
   ```

3. Verify descriptions are clear and include trigger keywords:
   - "research", "market analysis", "competitors" for product-research
   - "architecture", "design system", "tech stack" for technical-architecture
   - "implement", "code", "build" for software-development
   - "test", "coverage", "quality" for quality-engineering

4. Try explicitly mentioning the skill:
   ```
   Using the product-research skill, help me analyze...
   ```

### Invalid YAML Errors

**Issue:** Frontmatter parsing errors

**Fix:**
```bash
# Validate YAML syntax
python3 -c "import yaml; yaml.safe_load(open('product-research/SKILL.md').read().split('---')[1])"
```

**Common issues:**
- Missing closing `---`
- Improper indentation
- Special characters in description not quoted

### Skills Conflict with Built-in Behavior

**Issue:** Skills don't seem to activate or override default behavior

**Note:** Skills augment Claude's behavior, they don't replace it. Claude will:
1. Consider the skill's instructions
2. Combine with base knowledge
3. Apply judgment on when to use skill vs. default behavior

**Best practice:** Be specific in prompts to trigger skill usage.

## Skill Quality Metrics

Track these metrics to ensure skill quality:

### Coverage Metrics
- [ ] All four skills present and formatted correctly
- [ ] Each skill has comprehensive content (>1000 lines)
- [ ] All skills have "When to Use" sections
- [ ] Integration points documented between skills

### Functionality Metrics
- [ ] Skills trigger on appropriate prompts
- [ ] Skills provide value-added responses
- [ ] Skills don't interfere with each other
- [ ] Multi-skill workflows function smoothly

### Documentation Metrics
- [ ] Installation instructions are clear
- [ ] Testing procedures are documented
- [ ] Examples are comprehensive
- [ ] Troubleshooting guide exists

## Continuous Improvement

### Skill Performance Log

Track skill usage and effectiveness:

```markdown
## Date: YYYY-MM-DD
### Skill: [skill-name]
**Prompt:** [user request]
**Loaded:** Yes/No
**Effective:** Yes/No
**Issues:** [any problems]
**Improvements:** [suggestions]
```

### Version Control

When updating skills:

1. Update version in frontmatter
2. Document changes in CHANGELOG.md
3. Test all affected prompts
4. Update examples if needed

## Additional Resources

- [Claude Skills Documentation](https://docs.claude.com/en/docs/claude-code/skills.md)
- [Main README](README.md)
- [Quick Start Guide](QUICK-START.md)
- [Validation Script](scripts/validate-skills.sh)

---

**Last Updated:** 2025-01-22
**Skill Suite Version:** 1.0.0
