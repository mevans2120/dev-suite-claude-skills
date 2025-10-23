# Example: Complete Product Development Workflow

## Scenario: Building a Task Management SaaS Application

### Phase 1: Research (product-research skill)

**Prompt:**
"I want to build a task management app for remote teams. Research the market and analyze competitors."

**Skill Output:**
- Competitive analysis (Asana, Trello, Monday.com, ClickUp)
- Market gaps identified (real-time collaboration, async team features)
- Target market sizing
- Technology recommendations (Next.js, Supabase, Vercel)

**Deliverables:**
- Competitive matrix
- Market opportunity brief
- User persona definitions
- Technology evaluation

---

### Phase 2: Architecture (technical-architecture skill)

**Prompt:**
"Design the architecture for a real-time task management app for remote teams. Use modern, AI-friendly technologies."

**Skill Output:**
- System architecture proposal
  - Next.js 14+ (App Router) monolith
  - Supabase for PostgreSQL + Realtime
  - Vercel for deployment
- Architecture diagrams (C4 model)
- Database schema design
- API structure
- Security approach (NextAuth.js)
- Scalability plan

**Deliverables:**
- Architecture overview document
- System diagrams
- Technology stack specification
- ADRs (Architecture Decision Records)

---

### Phase 3: Implementation (software-development skill)

**Prompt:**
"Implement user authentication with email/password using NextAuth.js. Include the database schema and write tests following TDD."

**Skill Output:**
```typescript
// Tests written first (TDD)
describe('Authentication', () => {
  it('should create user with valid credentials', async () => {
    // Test implementation
  });

  it('should reject invalid email', async () => {
    // Test implementation
  });
});

// Implementation follows
// app/api/auth/[...nextauth]/route.ts
// Prisma schema updates
// Sign up/login forms with validation
// Protected route middleware
```

**Deliverables:**
- Working authentication system
- Unit and integration tests
- Database migrations
- API documentation

---

### Phase 4: Quality Engineering (quality-engineering skill)

**Prompt:**
"Analyze test coverage for the authentication module and recommend improvements."

**Skill Output:**
- Current coverage analysis (e.g., 75%)
- Gap identification:
  - Missing error scenario tests
  - No E2E tests for auth flow
  - Edge cases not covered (rate limiting, token expiry)
- Prioritized test plan:
  - P0: Error handling tests (security risk)
  - P1: E2E auth flow tests
  - P2: Edge case coverage
- Example test implementations

**Deliverables:**
- Coverage report
- Test gap analysis
- Prioritized test recommendations
- Sample test code

---

## Multi-Skill Integration Example

**Combined Prompt:**
"Help me build a task management app from scratch. I need market research, architecture design, core feature implementation, and comprehensive testing."

**Expected Flow:**
1. **Research skill loads** → Market analysis
2. **Architecture skill loads** → System design based on research
3. **Development skill loads** → Implements features per architecture
4. **QE skill loads** → Ensures quality throughout

**Final Deliverable:**
- Production-ready codebase
- Complete documentation
- Comprehensive test suite
- Deployment instructions

---

## Key Success Patterns

### Sequential Flow
```
Research → Architecture → Development → QE
```
Each phase informs the next

### Iterative Flow
```
Research ←→ Architecture (refine based on constraints)
    ↓
Development ←→ QE (test as you develop)
    ↓
Architecture (refinement for scale)
```

### Parallel Flow
```
Research (market + user) + Architecture (feasibility)
    ↓
Development + QE (TDD)
```

## Common User Prompts

### Starting New Project
- "Research and design a [type] application for [audience]"
- "Help me build [app] from scratch"
- "What's the best architecture for [requirements]?"

### Feature Development
- "Implement [feature] with [tech stack]"
- "Add [functionality] following best practices"
- "Build [component] with tests"

### Quality & Testing
- "Analyze test coverage and improve it"
- "Write tests for [module/feature]"
- "What tests should I prioritize?"

### Architecture Review
- "Review this architecture: [details]"
- "Is this the right approach for [use case]?"
- "Should I use microservices or monolith?"
