---
name: software-development
description: Build high-quality software following best practices, implement features from specifications, write clean and maintainable code in TypeScript/JavaScript/Python with test-driven development for well-defined features
version: 1.0.0
---

# Software Development Skill

This skill guides high-quality software development for digital products, with focus on React/TypeScript frontend, Next.js full-stack applications, and Python tooling. Emphasizes clean code, best practices, and test-driven development.

## When to Use This Skill

Use this skill when you need to:
- Implement new features or functionality
- Build applications from specifications
- Refactor or improve existing code
- Fix bugs systematically
- Write clean, maintainable code
- Follow best practices and design patterns
- Implement test-driven development (for well-defined features)

## Core Development Principles

### Code Quality Standards

**Clean Code:**
- Self-documenting code (clear names, logical structure)
- Single Responsibility Principle (functions/components do one thing)
- DRY (Don't Repeat Yourself) - but avoid premature abstraction
- KISS (Keep It Simple, Stupid) - simplicity over cleverness
- Proper error handling and edge cases

**TypeScript Best Practices:**
- Explicit types, avoid `any`
- Use interfaces for object shapes
- Union types for variants
- Type guards for runtime checks
- Generics for reusable components

**React Best Practices:**
- Functional components with hooks
- Proper hook dependencies
- Memoization when appropriate (useMemo, useCallback)
- Component composition over prop drilling
- Server components by default (Next.js App Router)

### Development Workflow

**Before Writing Code:**
1. ✅ Understand the requirements fully
2. ✅ Review relevant architecture decisions (from Planning skill)
3. ✅ Consider edge cases and error scenarios
4. ✅ Plan component/function structure
5. ✅ For well-defined features: write tests first (TDD)

**While Writing Code:**
1. ✅ Write clear, readable code
2. ✅ Add comments only where code isn't self-explanatory
3. ✅ Handle errors gracefully
4. ✅ Consider performance implications
5. ✅ Test as you go

**After Writing Code:**
1. ✅ Review your own code
2. ✅ Ensure tests pass (if applicable)
3. ✅ Check for console errors/warnings
4. ✅ Verify functionality works as expected
5. ✅ Clean up debugging code
6. ✅ Update documentation

## Test-Driven Development (TDD)

### When to Use TDD

**Always use TDD for:**
- Well-defined business logic
- Utility functions
- Data transformations
- API endpoints with clear contracts
- Critical user flows

**TDD Optional for:**
- Exploratory UI work
- Rapid prototyping
- Unclear requirements
- Simple presentational components

### TDD Process (Red-Green-Refactor)

**1. Red - Write Failing Test:**
```typescript
// Example: Testing a utility function
describe('formatCurrency', () => {
  it('should format USD correctly', () => {
    expect(formatCurrency(1234.56, 'USD')).toBe('$1,234.56');
  });
});
// Test fails - function doesn't exist yet
```

**2. Green - Write Minimum Code to Pass:**
```typescript
export function formatCurrency(amount: number, currency: string): string {
  return new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: currency,
  }).format(amount);
}
// Test passes
```

**3. Refactor - Improve Code Quality:**
```typescript
export function formatCurrency(
  amount: number,
  currency: string = 'USD',
  locale: string = 'en-US'
): string {
  return new Intl.NumberFormat(locale, {
    style: 'currency',
    currency: currency,
  }).format(amount);
}
// Test still passes, code is better
```

**4. Repeat:** Add more test cases and refine implementation

### Testing Best Practices

**Test Structure (AAA Pattern):**
```typescript
it('should do something', () => {
  // Arrange - Set up test data
  const input = { name: 'John', age: 30 };
  
  // Act - Execute the function
  const result = processUser(input);
  
  // Assert - Verify the result
  expect(result.isAdult).toBe(true);
});
```

**Good Test Characteristics:**
- Fast execution
- Independent (no test depends on another)
- Repeatable (same result every time)
- Clear failure messages
- Test one thing at a time

## Technology-Specific Guidelines

### React & TypeScript Development

#### Component Structure

**Server Component (Default in Next.js App Router):**
```typescript
// app/users/page.tsx
interface User {
  id: string;
  name: string;
  email: string;
}

export default async function UsersPage() {
  // Can fetch data directly in component
  const users = await fetchUsers();
  
  return (
    <div>
      <h1>Users</h1>
      <UserList users={users} />
    </div>
  );
}
```

**Client Component (When Interactivity Needed):**
```typescript
// components/UserList.tsx
'use client';

import { useState } from 'react';

interface UserListProps {
  users: User[];
}

export function UserList({ users }: UserListProps) {
  const [filter, setFilter] = useState('');
  
  const filteredUsers = users.filter(user =>
    user.name.toLowerCase().includes(filter.toLowerCase())
  );
  
  return (
    <div>
      <input
        type="text"
        value={filter}
        onChange={(e) => setFilter(e.target.value)}
        placeholder="Filter users..."
      />
      <ul>
        {filteredUsers.map(user => (
          <li key={user.id}>{user.name}</li>
        ))}
      </ul>
    </div>
  );
}
```

#### File Organization

**Standard Next.js App Structure:**
```
/app
  /api                 # API routes
    /users
      route.ts        # API handlers
  /(routes)           # Page routes
    /dashboard
      page.tsx        # Dashboard page
      layout.tsx      # Dashboard layout (optional)
    /users
      page.tsx        # Users list page
      /[id]
        page.tsx      # User detail page
  layout.tsx          # Root layout
  globals.css         # Global styles

/components
  /ui                 # Reusable UI components
    Button.tsx
    Input.tsx
  /features           # Feature-specific components
    /users
      UserCard.tsx
      UserForm.tsx

/lib
  /db                 # Database utilities
    prisma.ts         # Prisma client
  /api                # API client functions
    users.ts
  /utils              # Utility functions
    format.ts
  /hooks              # Custom React hooks
    useUser.ts
  /types              # TypeScript types
    user.ts

/prisma
  schema.prisma       # Database schema

/public
  /images             # Static images
```

#### State Management

**Local State (useState):**
```typescript
'use client';

export function Counter() {
  const [count, setCount] = useState(0);
  
  return (
    <button onClick={() => setCount(count + 1)}>
      Count: {count}
    </button>
  );
}
```

**Global State (Context):**
```typescript
// context/ThemeContext.tsx
'use client';

import { createContext, useContext, useState } from 'react';

type Theme = 'light' | 'dark';

const ThemeContext = createContext<{
  theme: Theme;
  toggleTheme: () => void;
} | undefined>(undefined);

export function ThemeProvider({ children }: { children: React.ReactNode }) {
  const [theme, setTheme] = useState<Theme>('light');
  
  const toggleTheme = () => {
    setTheme(theme === 'light' ? 'dark' : 'light');
  };
  
  return (
    <ThemeContext.Provider value={{ theme, toggleTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}

export function useTheme() {
  const context = useContext(ThemeContext);
  if (!context) throw new Error('useTheme must be used within ThemeProvider');
  return context;
}
```

**Complex State (Zustand - Recommended):**
```typescript
// store/useUserStore.ts
import { create } from 'zustand';

interface UserState {
  user: User | null;
  setUser: (user: User) => void;
  clearUser: () => void;
}

export const useUserStore = create<UserState>((set) => ({
  user: null,
  setUser: (user) => set({ user }),
  clearUser: () => set({ user: null }),
}));

// Usage in component
function Profile() {
  const { user, setUser } = useUserStore();
  // ...
}
```

#### Data Fetching

**Server Components (Recommended):**
```typescript
// app/posts/page.tsx
async function getPosts() {
  const res = await fetch('https://api.example.com/posts', {
    next: { revalidate: 3600 } // Cache for 1 hour
  });
  return res.json();
}

export default async function PostsPage() {
  const posts = await getPosts();
  return <PostList posts={posts} />;
}
```

**Client Components (React Query):**
```typescript
'use client';

import { useQuery } from '@tanstack/react-query';

export function Posts() {
  const { data: posts, isLoading, error } = useQuery({
    queryKey: ['posts'],
    queryFn: () => fetch('/api/posts').then(res => res.json())
  });
  
  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>Error loading posts</div>;
  
  return <PostList posts={posts} />;
}
```

#### Form Handling

**With React Hook Form + Zod:**
```typescript
'use client';

import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';

const userSchema = z.object({
  name: z.string().min(2, 'Name must be at least 2 characters'),
  email: z.string().email('Invalid email address'),
  age: z.number().min(18, 'Must be at least 18'),
});

type UserFormData = z.infer<typeof userSchema>;

export function UserForm() {
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting }
  } = useForm<UserFormData>({
    resolver: zodResolver(userSchema),
  });
  
  const onSubmit = async (data: UserFormData) => {
    await fetch('/api/users', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data),
    });
  };
  
  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('name')} />
      {errors.name && <p>{errors.name.message}</p>}
      
      <input {...register('email')} />
      {errors.email && <p>{errors.email.message}</p>}
      
      <input {...register('age', { valueAsNumber: true })} type="number" />
      {errors.age && <p>{errors.age.message}</p>}
      
      <button type="submit" disabled={isSubmitting}>
        {isSubmitting ? 'Submitting...' : 'Submit'}
      </button>
    </form>
  );
}
```

### Next.js API Development

#### API Routes (App Router)

**GET Request:**
```typescript
// app/api/users/route.ts
import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/db/prisma';

export async function GET(request: NextRequest) {
  try {
    const users = await prisma.user.findMany();
    return NextResponse.json(users);
  } catch (error) {
    console.error('Error fetching users:', error);
    return NextResponse.json(
      { error: 'Failed to fetch users' },
      { status: 500 }
    );
  }
}
```

**POST Request with Validation:**
```typescript
// app/api/users/route.ts
import { z } from 'zod';

const createUserSchema = z.object({
  name: z.string().min(2),
  email: z.string().email(),
});

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    
    // Validate input
    const validatedData = createUserSchema.parse(body);
    
    // Create user
    const user = await prisma.user.create({
      data: validatedData,
    });
    
    return NextResponse.json(user, { status: 201 });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Invalid input', details: error.errors },
        { status: 400 }
      );
    }
    
    console.error('Error creating user:', error);
    return NextResponse.json(
      { error: 'Failed to create user' },
      { status: 500 }
    );
  }
}
```

**Dynamic Routes:**
```typescript
// app/api/users/[id]/route.ts
export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  const user = await prisma.user.findUnique({
    where: { id: params.id },
  });
  
  if (!user) {
    return NextResponse.json(
      { error: 'User not found' },
      { status: 404 }
    );
  }
  
  return NextResponse.json(user);
}
```

#### Server Actions (Recommended for Mutations)

```typescript
// app/actions/users.ts
'use server';

import { revalidatePath } from 'next/cache';
import { z } from 'zod';

const createUserSchema = z.object({
  name: z.string().min(2),
  email: z.string().email(),
});

export async function createUser(formData: FormData) {
  const validatedData = createUserSchema.parse({
    name: formData.get('name'),
    email: formData.get('email'),
  });
  
  const user = await prisma.user.create({
    data: validatedData,
  });
  
  revalidatePath('/users');
  return { success: true, user };
}

// Usage in component
'use client';

export function CreateUserForm() {
  return (
    <form action={createUser}>
      <input name="name" required />
      <input name="email" type="email" required />
      <button type="submit">Create User</button>
    </form>
  );
}
```

### Database with Prisma

**Schema Definition:**
```prisma
// prisma/schema.prisma
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
}

model User {
  id        String   @id @default(cuid())
  email     String   @unique
  name      String
  posts     Post[]
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}

model Post {
  id        String   @id @default(cuid())
  title     String
  content   String
  published Boolean  @default(false)
  author    User     @relation(fields: [authorId], references: [id])
  authorId  String
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  
  @@index([authorId])
}
```

**Database Operations:**
```typescript
import { prisma } from '@/lib/db/prisma';

// Create
const user = await prisma.user.create({
  data: {
    email: 'user@example.com',
    name: 'John Doe',
  },
});

// Read
const users = await prisma.user.findMany({
  where: {
    email: {
      contains: '@example.com',
    },
  },
  include: {
    posts: true,
  },
});

// Update
const updatedUser = await prisma.user.update({
  where: { id: userId },
  data: { name: 'Jane Doe' },
});

// Delete
await prisma.user.delete({
  where: { id: userId },
});

// Transaction
await prisma.$transaction([
  prisma.user.create({ data: { email: 'user1@example.com', name: 'User 1' } }),
  prisma.user.create({ data: { email: 'user2@example.com', name: 'User 2' } }),
]);
```

### Python Development (Backend Tooling)

**FastAPI Example:**
```python
# main.py
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, EmailStr
from typing import List

app = FastAPI()

class User(BaseModel):
    id: str
    name: str
    email: EmailStr

class CreateUser(BaseModel):
    name: str
    email: EmailStr

@app.get("/api/users", response_model=List[User])
async def get_users():
    """Get all users"""
    users = await db.fetch_users()
    return users

@app.post("/api/users", response_model=User, status_code=201)
async def create_user(user: CreateUser):
    """Create a new user"""
    try:
        new_user = await db.create_user(user)
        return new_user
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/api/users/{user_id}", response_model=User)
async def get_user(user_id: str):
    """Get a specific user"""
    user = await db.fetch_user(user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user
```

**Python Best Practices:**
- Use type hints throughout
- Pydantic for data validation
- Async/await for I/O operations
- Proper exception handling
- Clear function docstrings
- Virtual environment for dependencies

## Error Handling Patterns

### Frontend Error Handling

**Error Boundaries (React):**
```typescript
// components/ErrorBoundary.tsx
'use client';

import { Component, ReactNode } from 'react';

interface Props {
  children: ReactNode;
  fallback?: ReactNode;
}

interface State {
  hasError: boolean;
  error?: Error;
}

export class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: any) {
    console.error('Error caught by boundary:', error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return this.props.fallback || (
        <div>
          <h2>Something went wrong</h2>
          <p>{this.state.error?.message}</p>
        </div>
      );
    }

    return this.props.children;
  }
}
```

**Try-Catch for Async Operations:**
```typescript
async function fetchUserData(userId: string) {
  try {
    const response = await fetch(`/api/users/${userId}`);
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    const data = await response.json();
    return { success: true, data };
  } catch (error) {
    console.error('Failed to fetch user:', error);
    return { 
      success: false, 
      error: error instanceof Error ? error.message : 'Unknown error' 
    };
  }
}
```

### Backend Error Handling

**Centralized Error Handler (Next.js):**
```typescript
// lib/api/errorHandler.ts
export class APIError extends Error {
  constructor(
    public statusCode: number,
    message: string,
    public code?: string
  ) {
    super(message);
    this.name = 'APIError';
  }
}

export function handleAPIError(error: unknown) {
  if (error instanceof APIError) {
    return NextResponse.json(
      { error: error.message, code: error.code },
      { status: error.statusCode }
    );
  }
  
  if (error instanceof z.ZodError) {
    return NextResponse.json(
      { error: 'Validation failed', details: error.errors },
      { status: 400 }
    );
  }
  
  console.error('Unexpected error:', error);
  return NextResponse.json(
    { error: 'Internal server error' },
    { status: 500 }
  );
}
```

## Code Review Checklist

Before considering code complete:

### Functionality
- ✅ Feature works as specified
- ✅ Edge cases handled
- ✅ Error cases handled gracefully
- ✅ No console errors or warnings

### Code Quality
- ✅ Code is readable and self-documenting
- ✅ Functions/components have single responsibility
- ✅ No code duplication (unless justified)
- ✅ TypeScript types are explicit and accurate
- ✅ Comments explain "why" not "what"

### Performance
- ✅ No unnecessary re-renders (React)
- ✅ Large lists are virtualized if needed
- ✅ Images are optimized
- ✅ Database queries are efficient
- ✅ Appropriate caching implemented

### Security
- ✅ Input validation on all user inputs
- ✅ No sensitive data in client code
- ✅ Authentication/authorization implemented
- ✅ SQL injection prevented (use ORM)
- ✅ XSS prevented (React handles by default)

### Testing
- ✅ Critical paths have tests
- ✅ All tests pass
- ✅ Test coverage is adequate
- ✅ Tests are meaningful (not just for coverage)

### Documentation
- ✅ Complex logic is documented
- ✅ API endpoints are documented
- ✅ README updated if needed
- ✅ Type definitions are clear

## Integration with Development Suite

### From Research Skill
- User requirements and needs
- Feature priorities
- Technical constraints

### From Planning Skill
- Architecture decisions and patterns
- Technology stack selections
- Code structure guidelines
- API contracts

### To QE Skill
- Completed features for testing
- Unit tests for review
- Test scenarios to implement
- Known limitations or edge cases

### With Project Management Skills
- Task completion updates
- Blockers and dependencies
- Effort estimates
- Code ready for review

### With Design Skills
- Implementation of design specs
- Component library development
- Design token usage
- Accessibility implementation

## Clarifying Questions Process

When requirements are unclear, ask:

**About Functionality:**
- What should happen when [edge case]?
- Should this work for [specific scenario]?
- What's the expected behavior if [error occurs]?

**About Scope:**
- Should I implement [related feature]?
- Is [optimization] in scope for this task?
- Do we need to support [use case]?

**About Design/UX:**
- What should the loading state look like?
- How should errors be displayed?
- What's the expected behavior on mobile?

**About Technical Approach:**
- Should this be a server or client component?
- Do we need real-time updates?
- What's the expected data volume?

## Example Development Scenarios

### Scenario 1: Implement User Authentication

**Requirements:**
- Users can sign up with email/password
- Users can log in
- Protected routes require authentication

**Approach:**
1. Install NextAuth.js
2. Configure providers (credentials)
3. Create auth API routes
4. Implement middleware for protected routes
5. Create sign up/sign in forms
6. Add session management
7. Write tests for auth flow

**TDD Process:**
- Write test for sign up API
- Implement sign up endpoint
- Write test for login API
- Implement login endpoint
- Test protected route access
- Implement middleware
- Refactor and optimize

### Scenario 2: Build Dashboard with Data Visualization

**Requirements:**
- Display user analytics
- Charts for data visualization
- Real-time updates

**Approach:**
1. Set up data fetching (Server Component)
2. Implement chart components (Recharts)
3. Add real-time updates (React Query with polling)
4. Optimize performance (memoization)
5. Add loading and error states
6. Implement responsive design
7. Write component tests

### Scenario 3: Refactor Legacy Code

**Requirements:**
- Existing code is hard to maintain
- Needs better TypeScript types
- Improve performance

**Approach:**
1. Add tests to existing code (characterization tests)
2. Identify code smells
3. Refactor incrementally
4. Add proper TypeScript types
5. Optimize performance bottlenecks
6. Ensure tests still pass
7. Document changes

## Best Practices Summary

### Do's
- ✅ Write tests for well-defined features (TDD)
- ✅ Use TypeScript strictly (no `any`)
- ✅ Handle errors gracefully
- ✅ Keep components small and focused
- ✅ Use Server Components by default (Next.js)
- ✅ Validate all inputs
- ✅ Document complex logic
- ✅ Follow consistent code style

### Don'ts
- ❌ Skip error handling
- ❌ Ignore TypeScript errors
- ❌ Over-engineer solutions
- ❌ Duplicate code without reason
- ❌ Commit debugging code
- ❌ Ignore accessibility
- ❌ Leave TODO comments without tickets
- ❌ Push breaking changes without communication

## Development Documentation

### Creating Documentation Files

**Always create markdown files for significant development work:**

**File Naming Convention:**
- `feature-[name]-[YYYY-MM-DD].md` - Feature implementation docs
- `refactor-[component]-[YYYY-MM-DD].md` - Refactoring documentation
- `bug-fix-[issue-number]-[YYYY-MM-DD].md` - Bug fix documentation
- `implementation-notes-[feature]-[YYYY-MM-DD].md` - Implementation details
- `code-review-[feature]-[YYYY-MM-DD].md` - Code review findings

**Recommended Location:**
- `docs/development/` - Development documentation
- `docs/features/` - Feature-specific documentation
- `docs/api/` - API implementation docs
- `.github/docs/` - GitHub-visible documentation

**Feature Implementation Template:**
```markdown
# [Feature Name] - Implementation

**Date:** YYYY-MM-DD
**Developer:** [Name/AI]
**Status:** In Progress | Completed | Blocked
**Related:** [Links to tickets, PRs, designs]

## Overview
[Brief description of the feature and its purpose]

## Requirements
- [Requirement 1]
- [Requirement 2]
- [Requirement 3]

## Technical Approach

### Architecture
[How the feature fits into the existing architecture]

### Components
1. **[Component Name]** (`path/to/component.tsx`)
   - Purpose: [What it does]
   - Props: [Key props]
   - State: [Key state]

2. **[API Route]** (`path/to/route.ts`)
   - Endpoint: `POST /api/...`
   - Purpose: [What it does]
   - Validation: [Schema used]

### Database Changes
\`\`\`prisma
model NewModel {
  id        String   @id @default(cuid())
  // ...
}
\`\`\`

### API Contracts
\`\`\`typescript
// Request
interface CreateRequest {
  name: string;
  // ...
}

// Response
interface CreateResponse {
  id: string;
  // ...
}
\`\`\`

## Implementation Details

### Key Files Changed
- \`app/[feature]/page.tsx\` - Main feature page
- \`components/[Feature]/[Component].tsx\` - Feature components
- \`lib/api/[feature].ts\` - API client functions
- \`app/api/[feature]/route.ts\` - API endpoints

### Code Examples
\`\`\`typescript
// Key implementation snippet
export function FeatureComponent() {
  // ...
}
\`\`\`

### Edge Cases Handled
- [Edge case 1 and how it's handled]
- [Edge case 2 and how it's handled]

### Error Handling
- [Error scenario and handling approach]
- [Error scenario and handling approach]

## Testing

### Test Coverage
- ✅ Unit tests for business logic
- ✅ Integration tests for API endpoints
- ✅ Component tests for UI
- ✅ E2E test for critical path

### Test Files
- \`components/[Feature]/[Component].test.tsx\`
- \`app/api/[feature]/route.test.ts\`
- \`e2e/[feature].spec.ts\`

## Known Limitations
- [Limitation 1]
- [Limitation 2]

## Future Improvements
- [ ] [Potential improvement]
- [ ] [Potential improvement]

## Lessons Learned
- [Something learned during implementation]
- [Something learned during implementation]

## References
- [Design documentation]
- [Architecture decisions]
- [Related tickets]
```

**Refactoring Documentation Template:**
```markdown
# Refactor: [Component/Module Name]

**Date:** YYYY-MM-DD
**Developer:** [Name/AI]
**Reason:** [Why refactoring was needed]

## Before

### Issues
- [Problem 1]
- [Problem 2]
- [Problem 3]

### Code Complexity
- Lines of code: [number]
- Cyclomatic complexity: [metric if available]
- Coupling: [description]

## After

### Improvements
- [Improvement 1]
- [Improvement 2]
- [Improvement 3]

### New Structure
\`\`\`
/feature
  /components
    Component1.tsx
    Component2.tsx
  /hooks
    useFeature.ts
  /utils
    helpers.ts
\`\`\`

### Code Complexity
- Lines of code: [number] (↓ X%)
- Cyclomatic complexity: [improved metric]
- Coupling: [reduced coupling description]

## Migration Guide
[If other developers need to update their code]

1. Step 1
2. Step 2

## Testing
- ✅ All existing tests pass
- ✅ Added new tests for extracted functions
- ✅ Code coverage maintained at [X]%

## Performance Impact
[Any performance improvements or regressions]
```

**Bug Fix Documentation Template:**
```markdown
# Bug Fix: [Issue Number] - [Title]

**Date:** YYYY-MM-DD
**Developer:** [Name/AI]
**Severity:** Critical | High | Medium | Low
**Affected Version:** [Version]

## Bug Description
[What was the bug and how did it manifest?]

## Root Cause
[What caused the bug?]

## Fix Applied

### Code Changes
\`\`\`typescript
// Before
function problematicFunction() {
  // ...
}

// After
function fixedFunction() {
  // ...
}
\`\`\`

### Files Changed
- \`path/to/file1.ts\` - [Description of change]
- \`path/to/file2.tsx\` - [Description of change]

## Testing

### Manual Testing
- [x] Verified bug is fixed
- [x] Tested edge cases
- [x] Verified no regression

### Automated Tests
- Added test: \`test/file.test.ts\`
- Test verifies: [What the test checks]

## Prevention
[How to prevent similar bugs in the future]
- [Prevention measure 1]
- [Prevention measure 2]

## Related Issues
- [Link to original issue]
- [Link to related bugs]
```

**When to Create Files:**
- Create feature docs when implementing significant features
- Create refactoring docs when restructuring code
- Create bug fix docs for critical or complex bugs
- Create implementation notes for architectural components
- Update existing docs when making major changes

## Quality Criteria

Development is complete when:
- ✅ All requirements are implemented
- ✅ Code follows best practices
- ✅ Tests are written and passing (if TDD applicable)
- ✅ No TypeScript errors
- ✅ Error handling is comprehensive
- ✅ Code is reviewed and refactored
- ✅ **Documentation files created for significant work**
- ✅ Ready for QE testing

## Notes

- Always prioritize code readability over cleverness
- Performance optimization should be based on actual bottlenecks
- Don't abstract too early - wait for patterns to emerge
- Tests are documentation - make them clear
- When in doubt, keep it simple
- **Document significant decisions and implementations in markdown files**
