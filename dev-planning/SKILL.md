---
name: technical-architecture
description: Design and analyze technical architectures, propose technology stacks, evaluate architectural patterns, and provide recommendations for scalable, secure, and maintainable systems optimized for AI-driven development
version: 1.0.0
---

# Technical Architecture Skill

This skill provides comprehensive technical architecture design, analysis, and recommendations for digital products. It focuses on modern, AI-friendly architectures that are easy to develop, deploy, and scale.

## When to Use This Skill

Use this skill when you need to:
- Design system architecture for a new product
- Analyze and improve existing architecture
- Evaluate architectural patterns and trade-offs
- Select appropriate technology stacks
- Address scalability and performance concerns
- Implement security best practices
- Plan system integrations
- Make build vs. buy decisions

## Core Architecture Principles

### AI-First Development Philosophy

When AI is building the product, optimize for:

**Modern, Well-Supported Technologies:**
- Technologies with extensive documentation and examples
- Frameworks with clear conventions and patterns
- Strong TypeScript/JavaScript ecosystem (for type safety and tooling)
- Well-maintained open-source projects

**Serverless & Managed Services:**
- Minimize infrastructure management
- Reduce operational complexity
- Enable rapid development and iteration
- Lower barrier to deployment

**Component-Based Architecture:**
- Clear separation of concerns
- Reusable, composable components
- Well-defined interfaces
- Testable in isolation

**Developer Experience:**
- Fast feedback loops
- Clear error messages
- Strong typing and autocomplete
- Comprehensive tooling

## Recommended Technology Stack

### Frontend Architecture

**Primary Stack:**
- **Framework:** React 18+ with TypeScript
- **Meta-Framework:** Next.js 14+ (App Router)
- **Styling:** Tailwind CSS
- **State Management:** React Context, Zustand, or Jotai (choose based on complexity)
- **UI Components:** shadcn/ui, Radix UI
- **Forms:** React Hook Form + Zod validation
- **Data Fetching:** TanStack Query (React Query)

**Why This Stack:**
- Strong TypeScript support throughout
- Excellent AI code generation capabilities
- Comprehensive ecosystem and documentation
- Modern patterns (Server Components, Server Actions)
- Built-in optimizations (image, font, route optimization)

### Backend Architecture

**Primary Stack:**
- **Framework:** Next.js API Routes / Server Actions (for full-stack apps)
- **Alternative:** FastAPI (Python) for ML/data-heavy backends
- **Authentication:** NextAuth.js or Supabase Auth
- **Database:** 
  - PostgreSQL (via Supabase or Neon for serverless)
  - Prisma as ORM
- **File Storage:** Vercel Blob, S3, or Supabase Storage
- **Caching:** Vercel KV (Redis) or Upstash

**Why This Approach:**
- Collocated frontend and backend code
- Type safety end-to-end
- Simplified deployment (single artifact)
- Serverless-ready by default

### Tooling & Development

**Essential Tools:**
- **Package Manager:** pnpm (fast, efficient)
- **Linting:** ESLint with TypeScript support
- **Formatting:** Prettier
- **Testing:** See QE skill for comprehensive testing strategy
- **Version Control:** Git with conventional commits
- **CI/CD:** GitHub Actions or Vercel's built-in CI/CD

## Architectural Patterns

### 1. Microservices Architecture

**When to Use:**
- Large, complex applications
- Multiple teams working independently
- Need for independent scaling
- Different technology requirements per service

**AI-Friendly Implementation:**
- Each service is a separate Next.js app or Python FastAPI service
- Shared types via npm packages (monorepo)
- API Gateway pattern (Next.js API routes can proxy)
- Event-driven communication (via message queue)

**Structure:**
```
/apps
  /web (Next.js frontend)
  /api-users (Next.js or Python API)
  /api-payments (Next.js or Python API)
  /api-notifications (Next.js or Python API)
/packages
  /shared-types (TypeScript definitions)
  /ui-components (shared React components)
```

**Pros:**
- Independent deployment and scaling
- Technology flexibility per service
- Clear boundaries and ownership
- Fault isolation

**Cons:**
- Increased operational complexity
- Network latency between services
- Data consistency challenges
- More complex development setup

### 2. Serverless Architecture

**When to Use:**
- Variable or unpredictable traffic
- Event-driven workloads
- Cost optimization important
- Rapid development and deployment
- Modern, cloud-native applications

**AI-Friendly Implementation:**
- Next.js on Vercel (automatic serverless functions)
- Supabase for database (Postgres with realtime)
- Vercel Edge Functions for global distribution
- Cloudflare Workers for compute at edge

**Structure:**
```
/app (Next.js App Router)
  /api (serverless API routes)
  /(pages) (server components + client components)
/lib
  /db (Prisma client)
  /auth (authentication logic)
  /services (business logic)
```

**Pros:**
- Automatic scaling
- Pay per use pricing
- Zero infrastructure management
- Fast deployment cycles
- Global distribution built-in

**Cons:**
- Cold start latency (mitigated by edge)
- Vendor lock-in potential
- Debugging can be harder
- Cost unpredictability at very high scale

### 3. Monolith (Well-Structured)

**When to Use:**
- Small to medium applications
- Single team or early stage
- Simple deployment preferred
- Cost-conscious projects

**AI-Friendly Implementation:**
- Single Next.js application
- Clear module boundaries within codebase
- Potential to extract services later

**Structure:**
```
/app
  /(routes) (Next.js pages and API)
/lib
  /features
    /auth
    /users
    /products
    (each feature is self-contained)
  /shared (utilities, types, components)
```

**Pros:**
- Simple deployment
- Easy to understand
- Fewer network calls
- Easier debugging and testing
- Lower operational overhead

**Cons:**
- Scaling is all-or-nothing
- Can become complex over time
- Longer build times as it grows
- Tighter coupling

### 4. Event-Driven Architecture

**When to Use:**
- Asynchronous operations needed
- Complex workflows
- Integration with multiple systems
- Real-time updates required

**AI-Friendly Implementation:**
- Next.js Server Actions for synchronous operations
- Message queue (AWS SQS, Google Cloud Tasks, Inngest)
- WebSockets or Server-Sent Events for real-time (via Ably or Pusher)
- Database triggers (Supabase supports this)

**Pros:**
- Loose coupling
- Scalability and resilience
- Easy to add new consumers
- Natural fit for async workflows

**Cons:**
- Harder to debug
- Message ordering challenges
- Potential message loss (needs handling)
- More complex testing

## Architecture Analysis Framework

When analyzing existing or proposed architectures, evaluate:

### 1. Scalability

**Questions:**
- Can components scale independently?
- Are there bottlenecks? (database, API, computation)
- How does it handle traffic spikes?
- What are the scaling costs?

**Recommendations:**
- Use database connection pooling
- Implement caching strategically
- Consider read replicas for databases
- Use CDN for static assets
- Implement rate limiting

### 2. Performance

**Questions:**
- What are the response time requirements?
- Are there geographic distribution needs?
- How much data is being transferred?
- Are there opportunities for optimization?

**Recommendations:**
- Server-side rendering where appropriate
- Edge caching and CDN usage
- Image and asset optimization
- Code splitting and lazy loading
- Database query optimization

### 3. Security

**Questions:**
- How is authentication handled?
- Is data encrypted in transit and at rest?
- Are there authorization controls?
- How are secrets managed?
- Is input validation comprehensive?

**Recommendations:**
- Use NextAuth.js or Supabase Auth
- Implement RBAC (Role-Based Access Control)
- Environment variables for secrets (never commit)
- Use Zod for input validation
- HTTPS only (automatic on Vercel)
- CORS configuration
- Rate limiting on APIs
- SQL injection prevention (use ORMs)
- XSS protection (React escapes by default)

### 4. Maintainability

**Questions:**
- Is the code structure clear and logical?
- Are there established patterns?
- Is there adequate documentation?
- How easy is it to add new features?

**Recommendations:**
- Consistent file structure
- TypeScript for type safety
- Shared UI component library
- Comprehensive README files
- API documentation (OpenAPI/Swagger)
- Architecture decision records (ADRs)

### 5. Cost Optimization

**Questions:**
- What are the infrastructure costs?
- Are resources right-sized?
- Can serverless reduce costs?
- Are there unused resources?

**Recommendations:**
- Start with serverless (Vercel, Supabase)
- Monitor usage and costs
- Implement caching to reduce database queries
- Use edge functions to reduce bandwidth
- Consider free tiers for low-traffic services

## Technology Selection Guide

### Decision Matrix Template

When evaluating technologies:

| Criteria | Weight | Option A | Option B | Option C |
|----------|--------|----------|----------|----------|
| AI Tool Support | High | | | |
| Documentation | High | | | |
| Community Size | Medium | | | |
| Performance | Medium | | | |
| Cost | Medium | | | |
| Learning Curve | Low | | | |
| Maturity | Medium | | | |

**Scoring:** Rate each option 1-5, multiply by weight, sum for total score

### Build vs. Buy Decisions

**Build When:**
- Core differentiating feature
- Specific requirements not met by existing solutions
- Total cost of ownership lower
- Control and customization critical

**Buy/Use Existing When:**
- Non-core functionality (auth, payments, email)
- Established solutions exist (Stripe, SendGrid, Auth0)
- Time to market critical
- Maintenance burden outweighs cost
- Compliance or security expertise required

**Recommended Third-Party Services:**
- **Auth:** NextAuth.js (free), Supabase Auth, Clerk
- **Payments:** Stripe
- **Email:** Resend, SendGrid
- **Analytics:** Vercel Analytics, PostHog
- **Monitoring:** Vercel, Sentry
- **CMS:** Sanity.io, Contentful
- **Search:** Algolia, Typesense

## Integration Patterns

### API Integration

**RESTful APIs:**
- Use Next.js API routes or Server Actions
- Implement versioning (/api/v1/)
- Use proper HTTP methods and status codes
- Include pagination for list endpoints
- Implement rate limiting

**GraphQL APIs:**
- Consider for complex data requirements
- Use Apollo Server with Next.js API routes
- TypeScript code generation (GraphQL Codegen)

**Webhooks:**
- Implement webhook handlers as API routes
- Verify webhook signatures
- Use idempotency for safety
- Queue processing for reliability

### Database Integration

**ORM Pattern (Recommended):**
- Prisma for TypeScript projects
- Type-safe database access
- Migration management
- Introspection and schema generation

**Direct SQL (When Needed):**
- Use for complex queries
- Parameterized queries only (prevent SQL injection)
- Connection pooling

## Documentation Requirements

All architecture deliverables should include:

### 1. Architecture Overview Document

**Contents:**
- System context and business goals
- High-level architecture diagram
- Technology stack rationale
- Key architectural decisions
- Security approach
- Scalability strategy

### 2. Architecture Diagrams

**Types:**
- System context diagram (C4 model Level 1)
- Container diagram showing major components (C4 Level 2)
- Component diagram for complex services (C4 Level 3)
- Deployment diagram
- Data flow diagram
- Security architecture diagram

**Tools:**
- Mermaid (can be embedded in markdown)
- Excalidraw for quick sketches
- Diagrams.net (draw.io)

### 3. API Documentation

**Standards:**
- OpenAPI/Swagger specification
- Clear endpoint descriptions
- Request/response examples
- Error codes and handling
- Authentication requirements

### 4. Architecture Decision Records (ADRs)

**Format:**
```markdown
# ADR-001: Use Next.js for Full-Stack Application

## Status
Accepted

## Context
We need to choose a framework for our web application...

## Decision
We will use Next.js 14 with App Router...

## Consequences
Positive:
- Unified codebase for frontend and backend
- Built-in optimizations
- Strong TypeScript support

Negative:
- Learning curve for team
- Vendor-specific patterns
```

## Integration with Development Suite

### From Research Skill
- User requirements and needs
- Technology evaluation findings
- Competitive analysis insights
- Feasibility constraints

### To Development Skill
- Detailed technical specifications
- Architecture diagrams and documentation
- Technology stack decisions
- Code structure guidelines
- API contracts and interfaces

### To QE Skill
- Architecture diagrams for test planning
- Critical paths and components
- Performance requirements
- Security requirements
- Integration points to test

### With Project Management Skills
- Technical feasibility input
- Effort estimates for architectural work
- Risk assessment
- Milestone definition

### With Design Skills
- Technical constraints for design
- Component architecture alignment
- Performance considerations
- API shape for design system

## Example Scenarios

### Scenario 1: Design Architecture for New SaaS App

**Input:**
- User needs multi-tenant task management app
- Real-time collaboration required
- Mobile and web clients
- ~10,000 expected users in first year

**Process:**
1. Evaluate requirements against patterns
2. Recommend serverless monolith initially (Next.js)
3. Plan for real-time via Supabase Realtime
4. Design multi-tenancy at database level
5. Document architecture and trade-offs

**Output:**
- Architecture overview document
- System diagrams (C4 model)
- Technology stack specification
- Security architecture
- Scalability roadmap

### Scenario 2: Analyze Existing Architecture

**Input:**
- User has slow-performing Node.js + React app
- Separate repos for frontend/backend
- MongoDB database
- Deployed on traditional VPS

**Process:**
1. Review current architecture
2. Identify bottlenecks (likely N+1 queries, lack of caching)
3. Propose improvements:
   - Migrate to Next.js (unified codebase)
   - Add Redis caching
   - Implement database indexes
   - Move to serverless deployment (Vercel)
4. Create migration plan with phases

**Output:**
- Current state analysis
- Proposed future state
- Migration roadmap
- Risk assessment
- Estimated improvements

### Scenario 3: Microservices Decomposition

**Input:**
- Large Next.js monolith becoming hard to manage
- Multiple teams working on same codebase
- Different scaling needs per feature

**Process:**
1. Identify service boundaries (bounded contexts)
2. Propose extraction strategy:
   - User service
   - Notification service
   - Payment service
   - Core app remains monolith
3. Define API contracts between services
4. Plan phased extraction

**Output:**
- Service decomposition plan
- API specifications
- Deployment strategy
- Data migration plan
- Team ownership model

## Best Practices

### Architecture Design
- ✅ Start simple, add complexity only when needed
- ✅ Optimize for change (systems evolve)
- ✅ Document decisions and trade-offs
- ✅ Consider operational aspects early
- ✅ Plan for failure (error handling, retry logic)
- ✅ Security by design, not afterthought

### For AI Development
- ✅ Prefer well-documented, mainstream technologies
- ✅ Use TypeScript for type safety
- ✅ Leverage managed services (less to build)
- ✅ Clear, logical file structures
- ✅ Separation of concerns
- ✅ Testable architecture

### Communication
- ✅ Diagrams over lengthy descriptions
- ✅ Explain trade-offs clearly
- ✅ Provide multiple options when appropriate
- ✅ Include both pros and cons
- ✅ Consider audience technical level

## Quality Criteria

Architecture is complete when:
- ✅ Major components identified and documented
- ✅ Technology stack selected with rationale
- ✅ Scalability approach defined
- ✅ Security strategy documented
- ✅ API contracts defined
- ✅ Deployment strategy clear
- ✅ Team understands the architecture
- ✅ ADRs created for key decisions

## Notes

- Architecture should enable, not constrain development
- Perfect is enemy of good - start simple
- Re-evaluate architecture as product evolves
- Keep documentation up to date
- Prefer boring technology over bleeding edge
- Consider team skills and learning capacity
