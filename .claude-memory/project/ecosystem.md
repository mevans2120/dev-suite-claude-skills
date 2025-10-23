# Skill Suite Ecosystem

## Overview

The Development Suite is part of a three-suite ecosystem for complete product development with AI assistance.

## The Three Suites

### 🎨 Design Suite
**Repository:** https://github.com/mevans2120/design-suite-claude-skills

**Skills (4):**
1. **design-research** - User research, usability studies, design analysis
2. **design-concepts** - Ideation, wireframing, prototyping
3. **design-production** - Design systems, component libraries, production-ready designs
4. **design-qa** - Accessibility review, design validation, quality assurance

**Focus:** UI/UX, visual design, accessibility, design systems

---

### 📋 Project Suite
**Repository:** https://github.com/mevans2120/project-suite-claude-skills

**Skills (3):**
1. **project-planner** - Project planning, scope definition, timeline creation
2. **project-manager** - Task tracking, team coordination, progress monitoring
3. **project-analyzer** - Analyzing TODOs, FIXMEs, creating GitHub issues

**Focus:** Project management, planning, coordination, tracking

---

### 💻 Development Suite (This Repository)
**Repository:** https://github.com/mevans2120/dev-suite-claude-skills

**Skills (4):**
1. **product-research** - Market analysis, competitive research, technology evaluation
2. **technical-architecture** - System design, architecture decisions, tech stack recommendations
3. **software-development** - React/TypeScript/Next.js/Python implementation
4. **quality-engineering** - Testing strategy, coverage analysis, test implementation

**Focus:** Development, architecture, coding, testing

---

## Complete Ecosystem Stats

**Total Skills:** 11
- Design: 4 skills
- Project: 3 skills
- Development: 4 skills

**Coverage:**
- Ideation & Planning ✅
- Design & UX ✅
- Technical Architecture ✅
- Development ✅
- Testing & QA ✅
- Project Management ✅
- Launch & Monitoring ✅

## Integration Points

### Design ↔ Development
**Design provides:**
- UI/UX specifications
- Design system tokens
- Component specifications
- Accessibility requirements

**Development implements:**
- Technical architecture for components
- React/TypeScript code
- Responsive implementations
- Component tests

### Project ↔ Development
**Project provides:**
- Feature scope
- Timelines and priorities
- Task breakdowns
- Success criteria

**Development delivers:**
- Technical specifications
- Implementation progress
- Blockers and dependencies
- Code and documentation

### Design ↔ Project
**Design provides:**
- Design timelines
- Design dependencies
- Design deliverables

**Project coordinates:**
- Design reviews
- Stakeholder feedback
- Design handoff timing

## Typical Workflows

### Feature Development (All Three Suites)
```
1. Project Suite: Define feature scope, timeline, tasks
2. Design Suite: Create designs, prototypes, specifications
3. Development Suite: Architect, implement, test
4. Design Suite: QA design implementation
5. Development Suite: QA functionality
6. Project Suite: Coordinate launch, track results
```

### New Product (All Three Suites)
```
1. Development Suite: Market research (product-research)
2. Project Suite: Define project plan (project-planner)
3. Design Suite: User research, concepts (design-research, design-concepts)
4. Development Suite: Technical architecture (technical-architecture)
5. Design Suite: Design system, production designs (design-production)
6. Development Suite: Implementation (software-development)
7. Development Suite: Testing (quality-engineering)
8. Design Suite: Accessibility review (design-qa)
9. Project Suite: Launch coordination (project-manager)
```

### Quick Feature (Development Only)
```
1. Development Suite: Architecture (technical-architecture)
2. Development Suite: Implementation (software-development)
3. Development Suite: Testing (quality-engineering)
```

## Installation

**Install all three suites globally:**

```bash
# Clone repositories
git clone https://github.com/mevans2120/design-suite-claude-skills.git
git clone https://github.com/mevans2120/project-suite-claude-skills.git
git clone https://github.com/mevans2120/dev-suite-claude-skills.git

# Create skills directory
mkdir -p ~/.claude/skills

# Install Design Suite
cd design-suite-claude-skills
for skill in design-*; do
  ln -s "$(pwd)/$skill" ~/.claude/skills/$skill
done
cd ..

# Install Project Suite
cd project-suite-claude-skills
for skill in project-*; do
  ln -s "$(pwd)/$skill" ~/.claude/skills/$skill
done
cd ..

# Install Development Suite
cd dev-suite-claude-skills
ln -s "$(pwd)/product-research" ~/.claude/skills/product-research
ln -s "$(pwd)/technical-architecture" ~/.claude/skills/technical-architecture
ln -s "$(pwd)/software-development" ~/.claude/skills/software-development
ln -s "$(pwd)/quality-engineering" ~/.claude/skills/quality-engineering
cd ..

# Verify
ls -la ~/.claude/skills/
# Should show 11 symlinked skills
```

## Example Prompts Using Multiple Suites

### Design + Development
```
"Design and implement a user dashboard with analytics"
→ design-concepts, design-production, technical-architecture, software-development
```

### Project + Development
```
"Plan and build the authentication system"
→ project-planner, technical-architecture, software-development, quality-engineering
```

### All Three Suites
```
"Build a complete task management feature from planning through launch"
→ project-planner, design-research, design-concepts, design-production,
  technical-architecture, software-development, quality-engineering,
  design-qa, project-manager
```

## Benefits

**When using single suite:**
- Expert knowledge in that domain
- Focused, specialized assistance
- Quick for specific tasks

**When using multiple suites:**
- ✅ Complete workflow coverage
- ✅ Automatic coordination between phases
- ✅ Consistent approach across disciplines
- ✅ No context loss between handoffs
- ✅ Better final outcomes

**When using all three:**
- 🚀 Complete product development lifecycle
- 🚀 Professional-grade outputs
- 🚀 Nothing falls through the cracks
- 🚀 Like having a full product team

## Ecosystem Philosophy

**Modularity:**
- Each suite works independently
- Install only what you need
- Start with one, add others later

**Integration:**
- Suites designed to work together
- Smooth handoffs between phases
- Shared terminology and patterns

**Completeness:**
- Together, cover entire product lifecycle
- From idea to launch to iteration
- Design + Development + Management

## Maintenance

All three suites:
- Follow same structure (SKILL.md format)
- Use same validation approach
- Maintained in separate repositories
- Can be updated independently
- Same installation patterns

**Update workflow:**
```bash
# Update all three
cd design-suite-claude-skills && git pull && cd ..
cd project-suite-claude-skills && git pull && cd ..
cd dev-suite-claude-skills && git pull && cd ..

# Skills auto-update (symlinks)
# Just restart Claude to pick up changes
```
