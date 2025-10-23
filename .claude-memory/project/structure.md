# Project Structure

## Directory Organization

```
dev-suite-claude-skills/
├── .claude-memory/          # Memory bank for context persistence
│   ├── project/            # Project-level documentation
│   ├── patterns/           # Reusable patterns
│   ├── examples/           # Example implementations
│   └── session/            # Session data
├── .claude-plugin/          # Plugin configuration
│   └── plugin.json         # Memory and session settings
├── product-research/        # Product research skill
│   └── SKILL.md            # Skill definition (271 lines)
├── technical-architecture/  # Technical architecture skill
│   └── SKILL.md            # Skill definition (622 lines)
├── software-development/    # Software development skill
│   └── SKILL.md            # Skill definition (997 lines)
├── quality-engineering/     # Quality engineering skill
│   └── SKILL.md            # Skill definition (997 lines)
├── scripts/                 # Automation scripts
│   └── validate-skills.sh  # Validation script (executable)
├── README.md                # Main documentation (12,469 bytes)
├── QUICK-START.md           # Quick reference guide (7,496 bytes)
├── INSTALL.md               # Installation instructions
├── TESTING.md               # Testing procedures
├── LICENSE                  # License file
└── .gitignore              # Git ignore rules

Total: 4 skills, 3 documentation files, 1 validation script
```

## Skill File Format

Each skill follows this structure:

```yaml
---
name: skill-name-in-lowercase-hyphens
description: Brief description under 1024 characters
version: 1.0.0
---

# Skill Name

## When to Use This Skill
[Clear guidance on when to invoke]

## Core Principles/Activities
[Main content sections]

## Examples
[Concrete examples]

## Best Practices
[Guidelines]

## Integration with Other Skills
[How skills work together]

## Quality Criteria
[Completion checklist]
```

## Key Files

### Documentation
- **README.md**: Comprehensive overview, examples, usage patterns
- **QUICK-START.md**: Quick reference for getting started
- **INSTALL.md**: Detailed installation for all platforms
- **TESTING.md**: Testing procedures and troubleshooting

### Configuration
- **.claude-plugin/plugin.json**: Plugin-wide settings
  - Memory directory configuration
  - Session expiry (24 hours)
  - Auto-archive settings

### Automation
- **scripts/validate-skills.sh**: Validates all 49 quality criteria
  - Directory structure
  - Frontmatter format
  - Content requirements
  - Documentation completeness

## Installation Locations

### Development
`/path/to/dev-suite-claude-skills/`
- Source repository
- Git-tracked
- Where updates are made

### Global Installation (Symlinked)
`~/.claude/skills/`
- product-research → /path/to/dev-suite-claude-skills/product-research
- technical-architecture → /path/to/dev-suite-claude-skills/technical-architecture
- software-development → /path/to/dev-suite-claude-skills/software-development
- quality-engineering → /path/to/dev-suite-claude-skills/quality-engineering

**Benefit**: Changes in repo automatically reflected globally

## Git Repository
- **Remote**: github.com/mevans2120/dev-suite-claude-skills
- **Branch**: main
- **Recent Commits**:
  - 7039fb1: Restructure to official format + testing
  - 2ca8539: Add memory bank plugin configuration
  - 6fae34f: Initial skill suite commit

## File Counts
- Markdown files: 8 (4 SKILL.md + 4 docs)
- Script files: 1 (validate-skills.sh)
- Config files: 2 (.gitignore, plugin.json)
- Total tracked files: ~11 (excluding .git, .claude-memory)

## Naming Conventions
- **Directories**: lowercase-hyphen-separated (product-research)
- **Skill names**: Match directory names exactly
- **Files**: UPPERCASE.md for docs, SKILL.md for skills
- **Scripts**: lowercase-hyphen.sh with executable permission
