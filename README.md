# Digital Product Development Skill Suite

A comprehensive skill suite for AI-driven digital product development, covering the full development lifecycle from research to quality engineering.

## Overview

This skill suite provides four specialized skills that work together to enable high-quality digital product development:

1. **Research** - Market analysis, competitive research, and technology evaluation
2. **Planning (Technical Architecture)** - System design, architecture decisions, and technology stack recommendations
3. **Development** - Software implementation with best practices, focusing on React/TypeScript/Next.js and Python
4. **Quality Engineering** - Comprehensive testing strategy and implementation

## Skills

### 1. Product Research (`product-research/`)

Conducts comprehensive research activities including:
- Market and competitive analysis
- User needs assessment
- Technology evaluation and feasibility studies
- Requirements synthesis

**Use when:** Starting a new project, evaluating technologies, or conducting market research

[View Full Documentation](product-research/SKILL.md)

### 2. Technical Architecture (`technical-architecture/`)

Provides architectural guidance optimized for AI-driven development:
- System architecture design and analysis
- Technology stack recommendations (React, Next.js, TypeScript, Python)
- Serverless and microservices patterns
- Security and scalability planning
- Architecture documentation

**Use when:** Designing new systems, analyzing existing architecture, or making technology decisions

[View Full Documentation](technical-architecture/SKILL.md)

### 3. Software Development (`software-development/`)

Implements features and applications following best practices:
- React/TypeScript frontend development
- Next.js full-stack applications
- Python backend tooling
- Test-driven development (for well-defined features)
- Clean code principles

**Use when:** Building features, refactoring code, or implementing specifications

[View Full Documentation](software-development/SKILL.md)

### 4. Quality Engineering (`quality-engineering/`)

Ensures quality through comprehensive testing:
- Test strategy development
- Unit, integration, and E2E testing
- Coverage analysis and gap identification
- Prioritized testing improvements
- Test frameworks: Jest, Playwright, pytest

**Use when:** Writing tests, analyzing coverage, or developing testing strategy

[View Full Documentation](quality-engineering/SKILL.md)

## Technology Stack

These skills are optimized for the following modern, AI-friendly technology stack:

### Frontend
- **Framework:** React 18+ with TypeScript
- **Meta-Framework:** Next.js 14+ (App Router)
- **Styling:** Tailwind CSS
- **UI Components:** shadcn/ui, Radix UI
- **State Management:** Zustand, React Context
- **Forms:** React Hook Form + Zod
- **Data Fetching:** TanStack Query

### Backend
- **Primary:** Next.js API Routes / Server Actions
- **Alternative:** FastAPI (Python) for ML/data-heavy backends
- **Database:** PostgreSQL (via Supabase or Neon)
- **ORM:** Prisma
- **Authentication:** NextAuth.js or Supabase Auth

### Testing
- **Unit Tests:** Jest or Vitest
- **E2E Tests:** Playwright
- **Component Tests:** React Testing Library

### Deployment
- **Platform:** Vercel (recommended for Next.js)
- **Database:** Supabase, Neon, or similar serverless Postgres
- **Storage:** Vercel Blob, S3, or Supabase Storage

## Installation

**Quick Install:**
1. Download/clone this repository
2. Run `./scripts/validate-skills.sh` to verify
3. Follow platform-specific instructions below

**Detailed Instructions:** See [INSTALL.md](INSTALL.md) for complete installation guide.

### Option 1: Claude.ai Web/Desktop (Easiest)

```bash
# Create ZIP file
zip -r dev-suite-skills.zip . -x "*.git*" -x ".claude-memory/*"

# Upload via Claude.ai Skills interface
```

### Option 2: Claude Code CLI

```bash
# As plugin (available across all projects)
claude plugin add /path/to/dev-suite-claude-skills

# As project skills (specific project)
cp -r /path/to/dev-suite-claude-skills/* .claude/skills/

# As personal skills (all your projects)
cp -r /path/to/dev-suite-claude-skills/* ~/.claude/skills/
```

### Option 3: API Usage

Skills uploaded to your Claude.ai account are automatically available in API calls.

**For complete installation instructions and troubleshooting, see [INSTALL.md](INSTALL.md).**

## Usage Examples

### Example 1: Starting a New Project

```
You: "I want to build a task management app for remote teams. Can you help me research the market and design the architecture?"

Claude:
[Loads Research and Planning skills]

Research Phase:
- Analyzes competitors (Asana, Trello, Monday)
- Identifies remote team-specific needs
- Evaluates technology options

Planning Phase:
- Proposes Next.js + Supabase architecture
- Designs serverless microservices approach
- Creates system diagrams
- Documents architecture decisions

Output:
- Competitive analysis report
- Technology recommendation
- Architecture documentation
- Next steps for development
```

### Example 2: Implementing a Feature

```
You: "Implement user authentication with email/password signup and login. Use NextAuth.js."

Claude:
[Loads Planning, Development, and QE skills]

Planning:
- Reviews auth architecture patterns
- Selects NextAuth.js credentials provider
- Plans database schema

Development:
- Creates NextAuth configuration
- Implements API routes
- Builds signup/login forms with validation
- Adds protected route middleware
- Writes tests following TDD

Quality Engineering:
- Creates unit tests for auth logic
- Writes E2E tests for auth flows
- Ensures coverage of edge cases

Output:
- Working authentication system
- Comprehensive test suite
- Documentation
```

### Example 3: Improving Test Coverage

```
You: "Analyze our test coverage and recommend improvements. Focus on the user management module."

Claude:
[Loads QE skill]

Analysis:
- Reviews current coverage (currently 65%)
- Identifies gaps:
  * Missing error handling tests
  * No tests for edge cases
  * E2E tests only cover happy path
  
Prioritization:
- High priority: Error scenarios (security risk)
- Medium priority: Edge cases
- Low priority: Additional happy path variations

Recommendations:
- 8 new unit tests for error handling
- 3 E2E tests for error flows
- 5 tests for edge cases
- Estimated coverage improvement: 65% → 88%

Output:
- Detailed coverage analysis
- Prioritized test plan
- Example test implementations
```

### Example 4: Complete Product Development Workflow

```
You: "Help me build a simple blog platform from scratch. I need market research, architecture, implementation, and testing."

Claude:
[Loads all four skills in sequence]

1. Research (product-research):
   - Analyzes existing blog platforms
   - Identifies key features (WYSIWYG editor, categories, comments)
   - Recommends technology stack
   
2. Planning (technical-architecture):
   - Designs system architecture (Next.js monolith)
   - Proposes database schema
   - Plans for scalability
   - Creates architecture diagrams
   
3. Development (software-development):
   - Implements blog post CRUD
   - Builds rich text editor integration
   - Creates category system
   - Adds comment functionality
   - Writes tests as features are built
   
4. Quality Engineering (quality-engineering):
   - Ensures comprehensive test coverage
   - Creates E2E tests for critical paths
   - Analyzes and fills coverage gaps
   - Generates coverage reports

Output:
- Complete, working blog platform
- Comprehensive documentation
- Full test suite
- Deployment ready code
```

## Skill Interactions

The skills are designed to work both independently and collaboratively:

### Linear Workflow
```
Research → Planning → Development → QE
```

### Iterative Workflow
```
Research ←→ Planning
    ↓
Development ←→ QE
    ↓
Planning (refinement)
```

### Independent Usage
Each skill can be used standalone when needed:
- **Research only:** Market analysis for a presentation
- **Planning only:** Architecture review of existing system
- **Development only:** Implement a specific feature
- **QE only:** Add tests to existing codebase

## Integration with Other Skill Suites

These skills are designed to complement:

### Project Management Suite
- **From PM:** Project scope, timelines, requirements
- **To PM:** Progress updates, blockers, estimates

### Design Suite
- **From Design:** UI/UX specifications, design system
- **To Design:** Technical constraints, component architecture

## Best Practices

### When to Use Each Skill

**Use Research when:**
- Starting a new project
- Evaluating technologies
- Analyzing competition
- Investigating feasibility

**Use Planning when:**
- Designing new systems
- Making architectural decisions
- Analyzing existing architecture
- Planning for scale

**Use Development when:**
- Building features
- Refactoring code
- Fixing bugs
- Implementing specifications

**Use QE when:**
- Writing tests
- Analyzing coverage
- Developing test strategy
- Debugging test failures

### Skill Invocation

Skills are loaded automatically by Claude when relevant to your task. You can also explicitly request a skill:

```
"Using the Research skill, help me analyze..."
"Can the Planning skill review this architecture?"
"Use the Development skill to implement..."
"Have the QE skill analyze test coverage..."
```

## Development Philosophy

These skills are optimized for **AI-driven development** with focus on:

1. **Modern, Well-Documented Technologies**
   - Prefer mainstream frameworks with extensive documentation
   - TypeScript for type safety and better AI understanding
   - Clear patterns and conventions

2. **Serverless-First Architecture**
   - Minimize infrastructure management
   - Enable rapid development and deployment
   - Reduce operational complexity

3. **Component-Based Design**
   - Clear separation of concerns
   - Reusable, composable components
   - Testable in isolation

4. **Quality Built-In**
   - Test-driven development for well-defined features
   - Comprehensive testing strategy
   - Continuous quality improvement

## Customization

You can customize these skills for your organization by:

1. **Modify Technology Preferences**
   - Edit the Planning skill to prefer different frameworks
   - Update Development skill with your coding standards
   - Adjust QE skill for your testing tools

2. **Add Company-Specific Guidelines**
   - Include your brand guidelines in Research
   - Add your architecture patterns to Planning
   - Include your code style guide in Development
   - Add your QA processes to QE

3. **Create New Skills**
   - Use these as templates for additional skills
   - Follow the same structure and format
   - Ensure proper integration points

## File Structure

```
dev-suite-claude-skills/
├── README.md                      # This file
├── QUICK-START.md                # Quick start guide
├── product-research/
│   └── SKILL.md                  # Product research skill
├── technical-architecture/
│   └── SKILL.md                  # Technical architecture skill
├── software-development/
│   └── SKILL.md                  # Software development skill
└── quality-engineering/
    └── SKILL.md                  # Quality engineering skill
```

## Requirements

- Claude Pro, Max, Team, or Enterprise subscription
- Code execution enabled in Claude
- For development: Node.js 18+, npm/pnpm
- For testing: Playwright installed for E2E tests

## Testing & Validation

Before using the skills, validate they're properly formatted:

```bash
./scripts/validate-skills.sh
```

**Expected:** All 49 checks should pass.

**For comprehensive testing procedures, see [TESTING.md](TESTING.md).**

## Support & Contributing

### Issues
If you encounter issues or have suggestions:
1. Review [INSTALL.md](INSTALL.md) for installation help
2. Check [TESTING.md](TESTING.md) for troubleshooting
3. Run `./scripts/validate-skills.sh` to verify setup
4. Check the individual skill documentation
5. Open an issue on GitHub with details

### Contributing
To contribute improvements:
1. Fork the repository
2. Make your changes
3. Run `./scripts/validate-skills.sh` to validate
4. Test with Claude
5. Submit a pull request with clear description

## Version History

### Version 1.0.0 (Current)
- Initial release
- Four core skills: Research, Planning, Development, QE
- Optimized for React/TypeScript/Next.js/Python stack
- Comprehensive documentation and examples

## License

[Specify your license here]

## Acknowledgments

Built on best practices from:
- Anthropic's Claude Skills documentation
- Modern web development community
- Test-driven development methodology
- Software architecture patterns

## Additional Resources

- [Anthropic Skills Documentation](https://docs.claude.com/)
- [Next.js Documentation](https://nextjs.org/docs)
- [React Documentation](https://react.dev/)
- [Playwright Documentation](https://playwright.dev/)
- [Prisma Documentation](https://www.prisma.io/docs)

---

**Ready to build amazing products with AI? Start with the Research skill and work your way through the development lifecycle!**
