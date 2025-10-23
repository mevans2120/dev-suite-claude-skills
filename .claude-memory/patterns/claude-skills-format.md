# Claude Skills Format Pattern

## Standard Format (Validated)

### Directory Structure
```
skill-name/
└── SKILL.md (required)
```

### YAML Frontmatter (Required)
```yaml
---
name: skill-name
description: Brief description of what this Skill does and when to use it
---
```

### Frontmatter Requirements
- **name**:
  - Lowercase letters, numbers, and hyphens only
  - Max 64 characters
  - Must match directory name
  - Example: `product-research`, `technical-architecture`

- **description**:
  - Max 1024 characters
  - Should include functionality AND trigger keywords
  - Be specific, not vague
  - Example: "Conduct comprehensive product research including market analysis, competitive research, user needs assessment, and technology evaluation for digital products"

- **version** (optional):
  - Semantic versioning (1.0.0)
  - Not required by Claude but useful for tracking

### Content Structure
```markdown
---
name: skill-name
description: Description here
---

# Skill Name (H1)

Brief introduction

## When to Use This Skill
- Bullet list of use cases
- When to invoke
- What triggers should load this skill

## Core [Topic] Activities/Principles
Main content sections with:
- Clear guidance
- Step-by-step instructions
- Best practices
- Code examples (if applicable)

## Examples
Concrete examples showing:
- Input scenarios
- Expected outputs
- Common patterns

## Integration with Other Skills
How this skill works with:
- Other skills in the suite
- External skill suites
- Standard Claude capabilities

## Best Practices
- Do's and Don'ts
- Guidelines
- Common pitfalls

## Quality Criteria
Checklist of completion criteria:
- ✅ Item 1
- ✅ Item 2
```

### Installation Locations

**Personal Skills (All Projects):**
```
~/.claude/skills/skill-name/
```

**Project Skills (Specific Project):**
```
.claude/skills/skill-name/
```

**Plugin Skills:**
```
Bundled with plugin installation
```

### Tool Restrictions (Optional)
Add to frontmatter to restrict which tools the skill can use:
```yaml
---
name: skill-name
description: ...
allowed-tools: Read, Grep, Glob, WebSearch, WebFetch
---
```

## Validation Checklist

### Format Validation
- [ ] Directory name matches skill name
- [ ] SKILL.md file exists
- [ ] YAML frontmatter present and valid
- [ ] Name field present and valid format
- [ ] Name max 64 characters
- [ ] Description field present
- [ ] Description max 1024 characters
- [ ] Closing `---` present

### Content Validation
- [ ] H1 heading present
- [ ] "When to Use" section present
- [ ] Examples included
- [ ] Sufficient content (100+ lines recommended)
- [ ] Clear instructions provided

### Integration Validation
- [ ] Trigger keywords in description
- [ ] Integration points documented (if applicable)
- [ ] Quality criteria defined

## Common Patterns

### Skill Activation Keywords
Include relevant keywords in description:
- **Research skills**: research, analyze, market, competitors, feasibility
- **Architecture skills**: architecture, design, tech stack, scalability, system
- **Development skills**: implement, build, code, develop, TDD, refactor
- **Testing skills**: test, coverage, quality, E2E, unit test

### Multi-Skill Workflows
Skills should document:
- Which skills they depend on
- Which skills they feed into
- How to use them together
- Workflow sequences

### Skill Categories
Organize skills by lifecycle phase:
1. **Research & Planning**: Market research, requirements, architecture
2. **Implementation**: Development, coding, feature building
3. **Quality & Testing**: QE, testing, validation
4. **Operations**: Deployment, monitoring, maintenance

## Anti-Patterns (Avoid)

❌ Vague descriptions: "Helps with development"
✅ Specific descriptions: "Implements features in React/TypeScript following TDD"

❌ Missing trigger keywords
✅ Include relevant keywords users would mention

❌ Directory name doesn't match skill name
✅ Keep them synchronized

❌ YAML syntax errors
✅ Validate YAML before committing

❌ Generic, short content
✅ Comprehensive, specific guidance

## Testing Skills

### Manual Test
```bash
# Create test directory
mkdir -p ~/.test-skills/my-skill

# Create SKILL.md with proper format

# Test by starting Claude in a project
claude

# Try prompt that should trigger skill
```

### Automated Validation
Use validation script pattern:
```bash
#!/bin/bash
# Check frontmatter
# Verify file structure
# Validate naming
# Check content requirements
```

## References
- [Claude Skills Documentation](https://docs.claude.com/en/docs/claude-code/skills.md)
- Validation script: `scripts/validate-skills.sh`
- Testing guide: `TESTING.md`
