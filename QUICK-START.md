# Quick Start Guide - Digital Product Development Skill Suite

**Get up and running in 5 minutes!**

## What This Is

4 expert skills that help you build digital products with AI assistance:
- 🔍 Research (market analysis, tech evaluation)
- 🏗️ Architecture (system design, tech decisions)
- 💻 Development (React/TypeScript/Next.js/Python)
- ✅ QE (testing strategy, coverage analysis)

## Installation (3 Easy Steps)

### Step 1: Download
```bash
# Clone the repository
git clone https://github.com/mevans2120/dev-suite-claude-skills.git
cd dev-suite-claude-skills

# Validate it works
chmod +x scripts/validate-skills.sh
./scripts/validate-skills.sh
# Should see: ✅ All 49 checks passed!
```

### Step 2: Install

**For Claude.ai Web/Desktop** (Most users):
```bash
# Create ZIP
zip -r dev-suite-skills.zip . -x "*.git*" -x ".claude-memory/session/*"

# Then in Claude.ai:
# 1. Click Skills icon (🧩)
# 2. Upload dev-suite-skills.zip
# 3. Wait ~1 minute
```

**For Claude Code CLI** (Developers):
```bash
# Install globally (all projects)
mkdir -p ~/.claude/skills
REPO_PATH="$(pwd)"
ln -s "$REPO_PATH/product-research" ~/.claude/skills/product-research
ln -s "$REPO_PATH/technical-architecture" ~/.claude/skills/technical-architecture
ln -s "$REPO_PATH/software-development" ~/.claude/skills/software-development
ln -s "$REPO_PATH/quality-engineering" ~/.claude/skills/quality-engineering

# Verify
ls -la ~/.claude/skills/ | grep dev-suite
```

### Step 3: Test It!

**Start a new conversation and try:**

```
"Research the market for task management apps"
→ Product Research skill activates

"Design architecture for a blog platform"
→ Technical Architecture skill activates

"Implement user authentication with TypeScript"
→ Software Development skill activates

"Analyze test coverage and suggest improvements"
→ Quality Engineering skill activates
```

**✅ If you see detailed, expert responses, it's working!**

## Your First Projects

### Project 1: Market Research (5 minutes)

```
You: "I want to build a habit tracking app. Can you research the market for me?"

Claude will:
✓ Load the Research skill automatically
✓ Analyze competitors (Habitica, Streaks, etc.)
✓ Identify key features and gaps
✓ Recommend technology approaches
✓ Provide a comprehensive report
```

### Project 2: System Design (10 minutes)

```
You: "Design the architecture for a real-time collaborative task board. Use modern, AI-friendly tech."

Claude will:
✓ Load the Planning skill automatically
✓ Propose Next.js + Supabase architecture
✓ Design for real-time using Supabase Realtime
✓ Create system diagrams
✓ Document architecture decisions
✓ Recommend specific libraries and patterns
```

### Project 3: Feature Implementation (15-30 minutes)

```
You: "Implement user authentication with email/password. Use NextAuth.js and include tests."

Claude will:
✓ Load Planning + Development + QE skills
✓ Review auth architecture patterns
✓ Write NextAuth configuration
✓ Create API routes and forms
✓ Implement validation with Zod
✓ Write comprehensive tests (TDD approach)
✓ Provide working, tested code
```

### Project 4: End-to-End Project (1-2 hours)

```
You: "Build a simple blog platform from scratch. I need research, architecture, implementation, and testing."

Claude will:
✓ Research existing blog platforms
✓ Design complete system architecture
✓ Implement all features (posts, editor, categories)
✓ Create comprehensive test suite
✓ Provide deployment-ready code
```

## Skill Descriptions

### 🔍 Research (product-research)
**Automatic triggers:** "research", "analyze market", "competitors", "feasibility"

**What it does:**
- Market and competitive analysis
- User needs assessment  
- Technology evaluation
- Requirements synthesis

**Example prompts:**
- "Research task management apps for remote teams"
- "What technology should I use for real-time collaboration?"
- "Analyze the market for [product idea]"

### 🏗️ Planning (technical-architecture)
**Automatic triggers:** "architecture", "design system", "tech stack", "scalability"

**What it does:**
- System architecture design
- Technology stack recommendations
- Security and scalability planning
- Architecture documentation

**Example prompts:**
- "Design the architecture for [app description]"
- "Review this architecture: [paste architecture]"
- "Should I use microservices or monolith?"
- "What's the best tech stack for [use case]?"

### 💻 Development (software-development)
**Automatic triggers:** "implement", "build", "code", "create component"

**What it does:**
- React/TypeScript/Next.js development
- Python backend tooling
- Test-driven development
- Clean code implementation

**Example prompts:**
- "Implement [feature description]"
- "Build a [component] with [requirements]"
- "Refactor this code: [paste code]"
- "Fix this bug: [describe bug]"

### ✅ QE (quality-engineering)
**Automatic triggers:** "test", "coverage", "quality", "write tests"

**What it does:**
- Test strategy development
- Unit/integration/E2E testing
- Coverage analysis
- Prioritized improvements

**Example prompts:**
- "Analyze test coverage for [module]"
- "Write tests for this code: [paste code]"
- "Create a test strategy for [project]"
- "What tests should I prioritize?"

## Common Workflows

### Workflow 1: New Feature
```
1. "Design architecture for [feature]" (Planning)
2. "Implement [feature] with TDD" (Development + QE)
3. "Review test coverage" (QE)
```

### Workflow 2: Code Review
```
1. "Review this architecture: [paste]" (Planning)
2. "Review this code: [paste]" (Development)
3. "What tests are missing?" (QE)
```

### Workflow 3: Technology Decision
```
1. "Research options for [use case]" (Research)
2. "Compare [tech A] vs [tech B]" (Planning)
3. "Recommend best option" (Planning)
```

## Tips for Best Results

### 1. Be Specific
❌ "Build an app"
✅ "Build a task management app with real-time collaboration for remote teams"

### 2. Mention Constraints
✅ "Design a system that can scale to 100K users"
✅ "Use serverless architecture"
✅ "Budget-conscious solution"

### 3. Request Multiple Skills
✅ "Research, design, and implement user authentication"
✅ "Build this feature with full test coverage"

### 4. Iterate
✅ "That looks good, now optimize for mobile"
✅ "Add error handling"
✅ "Improve the test coverage"

### 5. Ask for Clarification
Claude will ask clarifying questions if requirements are unclear. This ensures better results!

## Technology Stack Reminder

These skills are optimized for:

**Frontend:**
- React + TypeScript
- Next.js 14+ (App Router)
- Tailwind CSS
- shadcn/ui components

**Backend:**
- Next.js API Routes / Server Actions
- Python FastAPI (for ML/data work)
- PostgreSQL (Supabase/Neon)
- Prisma ORM

**Testing:**
- Jest for unit tests
- Playwright for E2E tests
- React Testing Library

**Deployment:**
- Vercel (recommended)
- Serverless-first approach

## Troubleshooting

### Skills Not Loading?
- Make sure you uploaded the entire `dev-suite.zip` file
- Check that code execution is enabled in your Claude settings
- Try explicitly mentioning the skill: "Using the Research skill, help me..."

### Getting Generic Responses?
- Be more specific in your requests
- Mention the type of help you need (research, architecture, implementation, testing)
- Include relevant context about your project

### Skills Suggesting Different Tech?
- These skills default to React/TypeScript/Next.js
- If you need different tech, mention it explicitly: "Use Vue instead of React"
- The skills are flexible and will adapt to your needs

## What's Next?

### Customize the Skills
1. Open the individual SKILL.md files
2. Add your company's coding standards
3. Include your preferred tools/libraries
4. Add your specific guidelines

### Integrate with Other Skills
These skills work great with:
- Project management skills (planning, tracking)
- Design skills (UI/UX, design systems)
- Documentation skills (API docs, user guides)

### Learn More
- Read the full README.md for detailed information
- Check individual SKILL.md files for comprehensive guides
- Review the examples in each skill

## Support

Questions or issues?
1. Check the main README.md
2. Review the specific skill documentation
3. Try rephrasing your request to Claude
4. Ensure you're using Claude Pro, Max, Team, or Enterprise

---

**You're all set! Start building amazing products with AI assistance.** 🚀

Try this to get started:
> "I want to build a [your idea]. Can you research the market and design the architecture?"
