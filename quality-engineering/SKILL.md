---
name: quality-engineering
description: Comprehensive testing strategy, implementation, and analysis. Covers unit, integration, and end-to-end testing with prioritized coverage improvements based on risk, coverage gaps, and critical user paths
version: 1.0.0
---

# Quality Engineering Skill

This skill provides comprehensive quality engineering capabilities including test strategy, implementation, analysis, and continuous improvement. Focuses on functional testing with prioritization based on risk, coverage gaps, and critical user paths.

## When to Use This Skill

Use this skill when you need to:
- Develop testing strategy for a project
- Analyze test coverage and identify gaps
- Write unit, integration, or E2E tests
- Prioritize testing efforts
- Debug failing tests
- Improve test quality and maintainability
- Establish testing best practices
- Run test suites and analyze results

## Core Testing Principles

### Testing Philosophy

**Quality is Everyone's Responsibility:**
- Developers write unit and integration tests
- QE focuses on comprehensive test strategy and E2E testing
- Testing happens throughout development, not just at the end

**Test Pyramid:**
```
        /\
       /E2E\          <- Few (slow, expensive, brittle)
      /------\
     /INTEG  \        <- Some (moderate speed, moderate cost)
    /--------\
   /   UNIT   \       <- Many (fast, cheap, reliable)
  /------------\
```

**Testing Goals:**
- Catch bugs early (before production)
- Prevent regressions
- Document expected behavior
- Enable confident refactoring
- Provide fast feedback to developers

### Test Quality Attributes

**Good Tests Are:**
- **Fast:** Run quickly to enable rapid feedback
- **Isolated:** Don't depend on other tests
- **Repeatable:** Same result every time
- **Self-validating:** Clear pass/fail without manual inspection
- **Timely:** Written close to when code is written

## Testing Levels

### 1. Unit Tests

**What:** Test individual functions, components, or modules in isolation

**When to Write:**
- For all business logic
- Utility functions
- Data transformations
- Component logic (not UI rendering)

**Tools:**
- **JavaScript/TypeScript:** Jest, Vitest
- **React:** React Testing Library
- **Python:** pytest, unittest

**Example (React Component Logic):**
```typescript
// hooks/useCounter.ts
import { useState } from 'react';

export function useCounter(initialValue: number = 0) {
  const [count, setCount] = useState(initialValue);
  
  const increment = () => setCount(c => c + 1);
  const decrement = () => setCount(c => c - 1);
  const reset = () => setCount(initialValue);
  
  return { count, increment, decrement, reset };
}

// hooks/useCounter.test.ts
import { renderHook, act } from '@testing-library/react';
import { useCounter } from './useCounter';

describe('useCounter', () => {
  it('should initialize with default value', () => {
    const { result } = renderHook(() => useCounter());
    expect(result.current.count).toBe(0);
  });
  
  it('should initialize with custom value', () => {
    const { result } = renderHook(() => useCounter(10));
    expect(result.current.count).toBe(10);
  });
  
  it('should increment count', () => {
    const { result } = renderHook(() => useCounter());
    
    act(() => {
      result.current.increment();
    });
    
    expect(result.current.count).toBe(1);
  });
  
  it('should decrement count', () => {
    const { result } = renderHook(() => useCounter(5));
    
    act(() => {
      result.current.decrement();
    });
    
    expect(result.current.count).toBe(4);
  });
  
  it('should reset to initial value', () => {
    const { result } = renderHook(() => useCounter(10));
    
    act(() => {
      result.current.increment();
      result.current.increment();
      result.current.reset();
    });
    
    expect(result.current.count).toBe(10);
  });
});
```

**Example (Utility Function):**
```typescript
// lib/utils/format.ts
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

// lib/utils/format.test.ts
import { formatCurrency } from './format';

describe('formatCurrency', () => {
  it('should format USD correctly', () => {
    expect(formatCurrency(1234.56)).toBe('$1,234.56');
  });
  
  it('should format EUR correctly', () => {
    expect(formatCurrency(1234.56, 'EUR', 'de-DE')).toBe('1.234,56 €');
  });
  
  it('should handle zero', () => {
    expect(formatCurrency(0)).toBe('$0.00');
  });
  
  it('should handle negative amounts', () => {
    expect(formatCurrency(-100)).toBe('-$100.00');
  });
  
  it('should round to 2 decimal places', () => {
    expect(formatCurrency(1.234)).toBe('$1.23');
  });
});
```

### 2. Integration Tests

**What:** Test multiple units working together (components + hooks, API + database)

**When to Write:**
- For API endpoints
- Database operations
- Complex component interactions
- Third-party service integrations

**Tools:**
- **API Testing:** Supertest, or Next.js route testing
- **Database:** Test database or in-memory database
- **React:** React Testing Library with real data

**Example (API Integration Test):**
```typescript
// app/api/users/route.test.ts
import { POST, GET } from './route';
import { prisma } from '@/lib/db/prisma';

// Mock Prisma
jest.mock('@/lib/db/prisma', () => ({
  prisma: {
    user: {
      create: jest.fn(),
      findMany: jest.fn(),
    },
  },
}));

describe('Users API', () => {
  afterEach(() => {
    jest.clearAllMocks();
  });
  
  describe('POST /api/users', () => {
    it('should create a user with valid data', async () => {
      const mockUser = {
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
      };
      
      (prisma.user.create as jest.Mock).mockResolvedValue(mockUser);
      
      const request = new Request('http://localhost/api/users', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          name: 'John Doe',
          email: 'john@example.com',
        }),
      });
      
      const response = await POST(request);
      const data = await response.json();
      
      expect(response.status).toBe(201);
      expect(data).toEqual(mockUser);
      expect(prisma.user.create).toHaveBeenCalledWith({
        data: {
          name: 'John Doe',
          email: 'john@example.com',
        },
      });
    });
    
    it('should return 400 for invalid email', async () => {
      const request = new Request('http://localhost/api/users', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          name: 'John Doe',
          email: 'invalid-email',
        }),
      });
      
      const response = await POST(request);
      const data = await response.json();
      
      expect(response.status).toBe(400);
      expect(data.error).toBe('Invalid input');
    });
  });
  
  describe('GET /api/users', () => {
    it('should return all users', async () => {
      const mockUsers = [
        { id: '1', name: 'John', email: 'john@example.com' },
        { id: '2', name: 'Jane', email: 'jane@example.com' },
      ];
      
      (prisma.user.findMany as jest.Mock).mockResolvedValue(mockUsers);
      
      const request = new Request('http://localhost/api/users');
      const response = await GET(request);
      const data = await response.json();
      
      expect(response.status).toBe(200);
      expect(data).toEqual(mockUsers);
    });
  });
});
```

### 3. End-to-End (E2E) Tests

**What:** Test complete user flows through the application

**When to Write:**
- For critical user journeys
- Authentication flows
- Key business processes
- Multi-step workflows

**Tools:**
- **Playwright** (Recommended) - Fast, reliable, great developer experience
- **Cypress** - Good alternative, nice UI

**Example (Playwright E2E Test):**
```typescript
// e2e/user-registration.spec.ts
import { test, expect } from '@playwright/test';

test.describe('User Registration', () => {
  test('should register a new user successfully', async ({ page }) => {
    // Navigate to registration page
    await page.goto('/register');
    
    // Fill in the form
    await page.fill('[name="name"]', 'John Doe');
    await page.fill('[name="email"]', 'john@example.com');
    await page.fill('[name="password"]', 'SecurePassword123!');
    
    // Submit the form
    await page.click('button[type="submit"]');
    
    // Wait for navigation to dashboard
    await page.waitForURL('/dashboard');
    
    // Verify success message or welcome text
    await expect(page.locator('h1')).toContainText('Welcome, John');
    
    // Verify user is logged in (check for logout button)
    await expect(page.locator('button:has-text("Logout")')).toBeVisible();
  });
  
  test('should show validation errors for invalid email', async ({ page }) => {
    await page.goto('/register');
    
    await page.fill('[name="name"]', 'John Doe');
    await page.fill('[name="email"]', 'invalid-email');
    await page.fill('[name="password"]', 'SecurePassword123!');
    
    await page.click('button[type="submit"]');
    
    // Should not navigate away
    await expect(page).toHaveURL('/register');
    
    // Should show error message
    await expect(page.locator('text=Invalid email address')).toBeVisible();
  });
  
  test('should prevent registration with existing email', async ({ page }) => {
    await page.goto('/register');
    
    // Try to register with an existing email
    await page.fill('[name="name"]', 'Jane Doe');
    await page.fill('[name="email"]', 'existing@example.com');
    await page.fill('[name="password"]', 'SecurePassword123!');
    
    await page.click('button[type="submit"]');
    
    // Should show error message
    await expect(page.locator('text=Email already in use')).toBeVisible();
  });
});
```

**Playwright Configuration:**
```typescript
// playwright.config.ts
import { defineConfig } from '@playwright/test';

export default defineConfig({
  testDir: './e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },
  projects: [
    {
      name: 'chromium',
      use: { browserName: 'chromium' },
    },
    {
      name: 'firefox',
      use: { browserName: 'firefox' },
    },
    {
      name: 'webkit',
      use: { browserName: 'webkit' },
    },
  ],
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  },
});
```

## Test Coverage Analysis

### Understanding Coverage Metrics

**Types of Coverage:**
- **Line Coverage:** % of code lines executed
- **Branch Coverage:** % of conditional branches executed
- **Function Coverage:** % of functions called
- **Statement Coverage:** % of statements executed

**Coverage Goals:**
- **Overall:** Aim for 80%+ coverage
- **Critical Paths:** Aim for 100% coverage
- **Utilities:** Aim for 100% coverage
- **UI Components:** 70%+ coverage (focus on logic, not rendering)

### Analyzing Coverage Gaps

**Run Coverage Report:**
```bash
# Jest/Vitest
npm run test -- --coverage

# Output will show:
# File          | % Stmts | % Branch | % Funcs | % Lines
# --------------|---------|----------|---------|--------
# lib/utils     |   95.5  |   90.0   |  100.0  |  95.5
# components    |   72.3  |   65.4   |   80.0  |  72.3
```

**Identifying Gaps:**
1. Look for low coverage percentages
2. Review uncovered lines in coverage report
3. Identify critical paths without tests
4. Note complex logic without tests

## Test Prioritization Framework

When determining what to test next, prioritize based on:

### 1. Risk-Based Prioritization

**High Risk (Test First):**
- Financial transactions
- User authentication/authorization
- Data modification operations
- Critical business logic
- Areas with history of bugs

**Medium Risk:**
- Data validation
- User workflows
- Third-party integrations
- Configuration logic

**Low Risk:**
- Static content rendering
- Simple presentational components
- Styling logic

### 2. Coverage Gap Analysis

**Priority Matrix:**
```
Impact vs. Coverage

High Impact │ ██ Test Now   │ ░░ Monitor
            │ (gaps here)   │ (covered)
            │────────────────────────
Low Impact  │ ▓▓ Plan       │ ░░ Skip
            │ (gaps here)   │ (covered)
            └────────────────────────
              Low Coverage   High Coverage
```

**Action Plan:**
1. **Test Now:** High impact + low coverage
2. **Monitor:** High impact + high coverage (maintain)
3. **Plan:** Low impact + low coverage (queue for later)
4. **Skip:** Low impact + high coverage (already good)

### 3. Critical User Paths

**Identify Critical Paths:**
- User registration/login
- Core feature usage
- Checkout/payment flow
- Data submission
- Account settings changes

**For Each Path:**
- Write at least one E2E test
- Ensure unit tests for each step
- Test happy path and error scenarios

### 4. Change Frequency

**High Change Areas:**
- Actively developed features
- Bug-prone areas
- Complex algorithms
- Integration points

**Strategy:**
- Comprehensive testing in high-change areas
- Lighter testing in stable areas
- Add tests before refactoring

## Test Strategy Development

### Creating a Test Plan

**1. Assess Current State:**
- What tests exist?
- What's the current coverage?
- Where are the gaps?
- What's the test infrastructure?

**2. Define Testing Levels:**
- Unit test scope and tools
- Integration test approach
- E2E test critical paths
- Performance testing needs (if any)

**3. Prioritize Test Development:**
- Critical paths first
- High-risk areas second
- Coverage gaps third
- Nice-to-have tests last

**4. Establish Guidelines:**
- When to write unit vs. integration vs. E2E
- Test file organization
- Naming conventions
- Mocking strategies
- CI/CD integration

### Test Documentation Template

```markdown
# Test Strategy for [Project Name]

## Overview
Brief description of testing approach and goals

## Testing Levels

### Unit Tests
- **Tool:** Jest
- **Scope:** Business logic, utilities, hooks
- **Coverage Goal:** 90%

### Integration Tests
- **Tool:** Jest + Testing Library
- **Scope:** API routes, database operations
- **Coverage Goal:** 80%

### E2E Tests
- **Tool:** Playwright
- **Scope:** Critical user journeys
- **Coverage Goal:** All critical paths + major features

## Critical User Paths
1. User Registration
2. User Login
3. Create Task
4. Complete Task
5. Team Collaboration

## Test Priorities

### P0 (Must Have)
- [ ] User authentication flow
- [ ] Task CRUD operations
- [ ] Payment processing

### P1 (Should Have)
- [ ] Search functionality
- [ ] Notifications
- [ ] Settings management

### P2 (Nice to Have)
- [ ] UI edge cases
- [ ] Performance tests
- [ ] Accessibility tests

## Coverage Goals
- Overall: 85%
- Critical paths: 100%
- Utils: 100%
- Components: 75%

## CI/CD Integration
- Tests run on every PR
- E2E tests run nightly
- Coverage reports generated
- Block merge if tests fail
```

## Testing Best Practices

### Test Organization

**File Structure:**
```
/app
  /api
    /users
      route.ts
      route.test.ts       # Co-located with code
      
/components
  /UserCard
    UserCard.tsx
    UserCard.test.tsx     # Co-located with code
    
/lib
  /utils
    format.ts
    format.test.ts        # Co-located with code
    
/e2e
  /auth
    login.spec.ts
    registration.spec.ts
  /tasks
    crud.spec.ts
```

### Test Naming Conventions

**Describe Blocks:**
```typescript
describe('ComponentName or functionName', () => {
  describe('methodName or scenario', () => {
    it('should do something when condition', () => {
      // test
    });
  });
});
```

**Example:**
```typescript
describe('UserService', () => {
  describe('createUser', () => {
    it('should create user with valid data', async () => {
      // test
    });
    
    it('should throw error when email is invalid', async () => {
      // test
    });
    
    it('should throw error when email already exists', async () => {
      // test
    });
  });
});
```

### Mocking Strategies

**When to Mock:**
- External API calls
- Database operations (in unit tests)
- File system operations
- Time-dependent operations
- Complex dependencies

**When NOT to Mock:**
- In integration tests (use real implementations)
- Simple utilities
- Pure functions
- Within the same module

**Example (Mocking External API):**
```typescript
// lib/api/github.ts
export async function fetchGitHubUser(username: string) {
  const response = await fetch(`https://api.github.com/users/${username}`);
  return response.json();
}

// lib/api/github.test.ts
import { fetchGitHubUser } from './github';

// Mock fetch globally
global.fetch = jest.fn();

describe('fetchGitHubUser', () => {
  afterEach(() => {
    jest.clearAllMocks();
  });
  
  it('should fetch user data', async () => {
    const mockUser = { login: 'testuser', name: 'Test User' };
    
    (global.fetch as jest.Mock).mockResolvedValue({
      json: async () => mockUser,
    });
    
    const user = await fetchGitHubUser('testuser');
    
    expect(user).toEqual(mockUser);
    expect(global.fetch).toHaveBeenCalledWith(
      'https://api.github.com/users/testuser'
    );
  });
});
```

### Test Data Management

**Use Factories:**
```typescript
// tests/factories/user.ts
export function createUser(overrides?: Partial<User>): User {
  return {
    id: 'test-id',
    name: 'Test User',
    email: 'test@example.com',
    createdAt: new Date('2024-01-01'),
    ...overrides,
  };
}

// Usage in tests
const user = createUser({ name: 'Custom Name' });
```

**Use Fixtures:**
```typescript
// tests/fixtures/users.json
[
  {
    "id": "1",
    "name": "John Doe",
    "email": "john@example.com"
  },
  {
    "id": "2",
    "name": "Jane Smith",
    "email": "jane@example.com"
  }
]

// In tests
import users from '@/tests/fixtures/users.json';
```

## Running Tests

### Development Workflow

**Watch Mode:**
```bash
# Run tests in watch mode (re-run on file changes)
npm run test -- --watch

# Run specific test file
npm run test -- user.test.ts --watch
```

**Single Run:**
```bash
# Run all tests once
npm run test

# Run with coverage
npm run test -- --coverage

# Run specific test
npm run test -- -t "should create user"
```

**E2E Tests:**
```bash
# Run all E2E tests
npx playwright test

# Run in headed mode (see browser)
npx playwright test --headed

# Run specific test file
npx playwright test e2e/auth/login.spec.ts

# Debug mode
npx playwright test --debug
```

### CI/CD Integration

**GitHub Actions Example:**
```yaml
# .github/workflows/test.yml
name: Tests

on:
  pull_request:
  push:
    branches: [main]

jobs:
  unit-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 18
      - run: npm ci
      - run: npm run test -- --coverage
      - uses: codecov/codecov-action@v3
        if: always()
        
  e2e-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 18
      - run: npm ci
      - run: npx playwright install --with-deps
      - run: npx playwright test
      - uses: actions/upload-artifact@v3
        if: always()
        with:
          name: playwright-report
          path: playwright-report/
```

## Debugging Failing Tests

### Investigation Process

**1. Understand the Failure:**
- Read the error message carefully
- Check which assertion failed
- Look at the test name and context

**2. Reproduce Locally:**
- Run the specific failing test
- Use `--debug` flag for E2E tests
- Add console.logs or debugger statements

**3. Isolate the Issue:**
- Is it a flaky test? (Run multiple times)
- Does it fail consistently?
- Does it fail only in CI or locally too?

**4. Common Causes:**
- **Async timing issues:** Missing `await` or improper promise handling
- **State pollution:** Tests affecting each other (need better cleanup)
- **Environment differences:** CI vs local (database, env vars)
- **Race conditions:** Especially in E2E tests
- **Stale data:** Test using outdated fixtures or mocks

### Debugging Tools

**Jest Debug:**
```bash
# Run with Node debugger
node --inspect-brk node_modules/.bin/jest --runInBand
```

**Playwright Debug:**
```bash
# Debug mode (pauses execution, allows inspection)
npx playwright test --debug

# Headed mode (see browser)
npx playwright test --headed

# Generate trace
npx playwright test --trace on
npx playwright show-trace trace.zip
```

**Add Temporary Logs:**
```typescript
it('should do something', () => {
  const result = functionUnderTest(input);
  console.log('DEBUG:', { input, result }); // Temporary debug log
  expect(result).toBe(expected);
});
```

## Integration with Development Suite

### From Research Skill
- Critical user paths to test
- Risk areas requiring focus
- Compliance requirements
- Performance expectations

### From Planning Skill
- Architecture for test planning
- Integration points to test
- Security requirements
- API contracts to validate

### From Development Skill
- Unit tests for review
- Code for integration testing
- Features for E2E testing
- Bug fixes to verify

### To Other Skills
- Test coverage reports
- Quality metrics
- Bug findings
- Regression risks
- Testing blockers

### With Project Management Skills
- Test plan and timelines
- Testing status updates
- Quality gates for releases
- Bug reports and tracking

## Quality Metrics & Reporting

### Key Metrics to Track

**Coverage Metrics:**
- Overall code coverage %
- Critical path coverage %
- Uncovered lines in high-risk areas

**Test Health:**
- Number of tests
- Test execution time
- Flaky test count
- Test pass rate

**Bug Metrics:**
- Bugs found in testing vs. production
- Bug severity distribution
- Time to fix
- Regression rate

### Coverage Report Example

```markdown
# Test Coverage Report - Sprint 5

## Summary
- Overall Coverage: 82% (↑ 5% from last sprint)
- Critical Paths: 95% (↑ 3%)
- Unit Tests: 89%
- Integration Tests: 78%
- E2E Tests: 5 new tests added

## Coverage by Module
| Module          | Coverage | Change |
|-----------------|----------|--------|
| Authentication  | 100%     | +5%    |
| User Management | 92%      | +8%    |
| Task CRUD       | 88%      | +3%    |
| Notifications   | 65%      | -2%    |

## Priority Gaps
1. **Notification Service** - 65% coverage, HIGH risk
   - Missing: Error handling tests
   - Missing: Retry logic tests
   - Action: Add 8 tests this sprint

2. **Search Feature** - 70% coverage, MEDIUM risk
   - Missing: Edge case tests
   - Action: Add 5 tests

## Next Sprint Focus
- Bring notification coverage to 85%
- Add E2E tests for new collaboration feature
- Reduce flaky test count from 3 to 0
```

## Quality Engineering Documentation

### Creating Documentation Files

**Always create markdown files for QE deliverables:**

**File Naming Convention:**
- `test-strategy-[project]-[YYYY-MM-DD].md` - Test strategy documents
- `test-plan-[feature]-[YYYY-MM-DD].md` - Feature test plans
- `coverage-report-[YYYY-MM-DD].md` - Coverage analysis reports
- `test-improvements-[YYYY-MM-DD].md` - Test improvement recommendations
- `qa-findings-[feature]-[YYYY-MM-DD].md` - QA findings and issues
- `test-review-[sprint]-[YYYY-MM-DD].md` - Test suite review

**Recommended Location:**
- `docs/testing/` - Main testing documentation
- `docs/testing/strategies/` - Test strategies
- `docs/testing/reports/` - Coverage and quality reports
- `docs/testing/plans/` - Test plans

**Test Strategy Template:**
```markdown
# Test Strategy - [Project Name]

**Date:** YYYY-MM-DD
**Version:** 1.0
**QE Lead:** [Name/AI]
**Status:** Draft | Approved | Active

## Executive Summary
[2-3 paragraphs describing testing approach, goals, and current state]

## Testing Objectives
- [Objective 1: e.g., Ensure critical paths are tested]
- [Objective 2: e.g., Achieve 85% code coverage]
- [Objective 3: e.g., Reduce production bugs by 50%]

## Scope

### In Scope
- [Feature area 1]
- [Feature area 2]

### Out of Scope
- [Excluded area 1]
- [Excluded area 2]

## Testing Levels

### Unit Testing
- **Tool:** Jest / Vitest
- **Coverage Goal:** 90%
- **Responsibility:** Developers
- **Scope:** Business logic, utilities, hooks, pure functions

### Integration Testing
- **Tool:** Jest + Testing Library
- **Coverage Goal:** 80%
- **Responsibility:** Developers + QE
- **Scope:** API routes, database operations, component integration

### End-to-End Testing
- **Tool:** Playwright
- **Coverage Goal:** All critical paths + major features
- **Responsibility:** QE
- **Scope:** Complete user journeys

## Critical User Paths

### P0 Paths (Must Test)
1. **User Authentication**
   - Registration
   - Login
   - Password reset
   - Logout

2. **[Core Feature]**
   - [Key workflow 1]
   - [Key workflow 2]

### P1 Paths (Should Test)
1. **[Important Feature]**
   - [Workflow]

## Risk Assessment

| Risk Area | Impact | Likelihood | Coverage | Priority |
|-----------|--------|------------|----------|----------|
| Payment Processing | High | Medium | 95% | P0 |
| User Data | High | Low | 85% | P0 |
| [Feature] | Medium | Medium | 70% | P1 |

## Test Priorities

### Sprint 1
- [ ] Set up test infrastructure
- [ ] Create test for authentication flow
- [ ] Unit tests for core utilities

### Sprint 2
- [ ] E2E tests for critical paths
- [ ] Integration tests for API endpoints
- [ ] Coverage analysis and gap identification

### Sprint 3
- [ ] Address coverage gaps
- [ ] Performance testing
- [ ] Accessibility testing

## Coverage Goals

| Area | Current | Target | Timeline |
|------|---------|--------|----------|
| Overall | 65% | 85% | End of Q2 |
| Critical Paths | 80% | 100% | End of Sprint 2 |
| Utilities | 85% | 100% | End of Sprint 1 |
| Components | 60% | 75% | End of Q2 |

## Test Data Strategy
- **Test Database:** [Approach - in-memory, dedicated test DB]
- **Fixtures:** [Location and management]
- **Factories:** [Test data generation approach]
- **Mocking:** [What gets mocked, what doesn't]

## CI/CD Integration

### Continuous Integration
- Unit + integration tests run on every PR
- Tests must pass before merge
- Coverage reports generated automatically

### Continuous Deployment
- E2E tests run on staging deployment
- Smoke tests run on production deployment
- Rollback triggered on test failures

## Quality Metrics

### Track Weekly
- Test count (unit, integration, E2E)
- Code coverage %
- Test execution time
- Flaky test count
- Test pass rate

### Track Monthly
- Bugs found in testing vs. production
- Bug severity distribution
- Time to fix bugs
- Regression rate

## Tools & Infrastructure

### Testing Framework
- **Unit/Integration:** Jest 29+
- **E2E:** Playwright 1.40+
- **Assertions:** Jest matchers + Testing Library
- **Mocking:** Jest mocks

### CI/CD
- **Platform:** GitHub Actions
- **Test Runner:** GitHub-hosted runners
- **Reporting:** Codecov, GitHub PR comments

### Monitoring
- **Error Tracking:** Sentry
- **Analytics:** PostHog
- **Performance:** Vercel Analytics

## Team Responsibilities

### Developers
- Write unit tests for all new code
- Write integration tests for APIs
- Fix failing tests
- Maintain test quality

### QE
- Define test strategy
- Write E2E tests
- Analyze coverage gaps
- Prioritize testing efforts
- Review test quality

## Risks & Mitigation

| Risk | Impact | Mitigation |
|------|--------|------------|
| Flaky E2E tests | Development slowdown | Strict flaky test policy |
| Low test coverage | Production bugs | Enforce coverage thresholds |
| Slow test execution | Slow feedback | Parallelize tests, optimize |

## Success Criteria
- [ ] 85% overall code coverage
- [ ] 100% critical path coverage
- [ ] All P0 paths have E2E tests
- [ ] Zero flaky tests
- [ ] Tests run in <5 minutes
- [ ] <5 production bugs per release

## References
- [Architecture documentation]
- [Feature specifications]
- [CI/CD setup]
```

**Coverage Analysis Report Template:**
```markdown
# Test Coverage Analysis - [Date]

**Analysis Date:** YYYY-MM-DD
**Project:** [Project Name]
**Analyzed By:** [Name/AI]

## Executive Summary

**Overall Coverage:** X% (↑/↓ Y% from last report)
**Status:** 🟢 On Track | 🟡 Needs Attention | 🔴 Critical

Key Findings:
- [Finding 1]
- [Finding 2]
- [Finding 3]

## Coverage Metrics

### Overall Coverage
| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| Statements | X% | 85% | 🟢 |
| Branches | X% | 80% | 🟡 |
| Functions | X% | 90% | 🔴 |
| Lines | X% | 85% | 🟢 |

### Coverage by Module
| Module | Statements | Branches | Functions | Lines | Priority |
|--------|-----------|----------|-----------|-------|----------|
| Auth | 100% | 95% | 100% | 100% | P0 |
| Users | 85% | 80% | 90% | 85% | P0 |
| Tasks | 70% | 65% | 75% | 70% | P1 |
| Notifications | 45% | 40% | 50% | 45% | P1 |

## Critical Coverage Gaps

### 🔴 Priority 1 (Critical)
**Notification Service** - 45% coverage
- **Risk:** High - handles critical user communications
- **Missing:** Error handling, retry logic, edge cases
- **Uncovered Files:**
  - \`lib/notifications/email.ts\` (30% coverage)
  - \`lib/notifications/push.ts\` (25% coverage)
- **Recommendation:** Add 12 unit tests + 2 integration tests
- **Effort:** 2-3 days
- **Assigned:** [Name]

### 🟡 Priority 2 (Important)
**Search Feature** - 70% coverage
- **Risk:** Medium - core feature but lower impact
- **Missing:** Complex query tests, filter combinations
- **Uncovered Files:**
  - \`lib/search/filters.ts\` (65% coverage)
- **Recommendation:** Add 6 unit tests
- **Effort:** 1 day

## Test Suite Health

### Test Statistics
- **Total Tests:** X
  - Unit: X (Y%)
  - Integration: X (Y%)
  - E2E: X (Y%)
- **Execution Time:** X minutes
- **Flaky Tests:** X (target: 0)
- **Skipped Tests:** X

### Flaky Tests
1. **\`e2e/checkout.spec.ts\`** - Fails intermittently on slow networks
   - Status: Under investigation
   - Action: Add retry logic + timeout increase

2. **\`components/Modal.test.tsx\`** - Race condition with animations
   - Status: Fix in progress
   - Action: Use waitFor with proper timing

## Recommended Actions

### This Sprint
1. **Fix Critical Gaps**
   - [ ] Add tests for notification service (Priority 1)
   - [ ] Fix 2 flaky E2E tests
   - [ ] Review auth module (maintain 100%)

2. **Technical Debt**
   - [ ] Refactor slow test suite in \`api/users\`
   - [ ] Update test fixtures to latest schema
   - [ ] Add missing JSDoc for test utilities

### Next Sprint
1. **Improve Coverage**
   - [ ] Add tests for search feature (Priority 2)
   - [ ] Increase branch coverage in task module
   - [ ] Add E2E test for new collaboration feature

2. **Quality Improvements**
   - [ ] Implement test data factories
   - [ ] Add coverage trend tracking
   - [ ] Document testing patterns

## Coverage Trends

### Last 4 Weeks
| Week | Overall | Critical Paths | Change |
|------|---------|----------------|--------|
| Week 1 | 78% | 92% | - |
| Week 2 | 80% | 95% | +2% |
| Week 3 | 81% | 95% | +1% |
| Week 4 | 82% | 95% | +1% |

**Trend:** 🟢 Steady improvement

## Risk Assessment

| Risk | Likelihood | Impact | Action Required |
|------|-----------|--------|-----------------|
| Notification failures | High | High | Add tests immediately |
| Search bugs | Medium | Medium | Add tests next sprint |
| Auth vulnerabilities | Low | Critical | Maintain 100% coverage |

## Files Requiring Attention

### No Test Coverage (0%)
- None ✅

### Low Coverage (<50%)
1. \`lib/notifications/push.ts\` (25%)
2. \`lib/analytics/tracking.ts\` (40%)
3. \`lib/utils/legacy.ts\` (35%)

### High Complexity, Low Coverage
1. \`lib/search/query-builder.ts\` (60% coverage, complexity: 15)
2. \`lib/payments/processor.ts\` (75% coverage, complexity: 12)

## Next Review
**Date:** [Next review date]
**Focus Areas:** Notification service, flaky tests, search feature

## Appendix

### Coverage Command
\`\`\`bash
npm run test -- --coverage --coverageReporters=text,lcov,html
\`\`\`

### Detailed Reports
- HTML Report: \`coverage/lcov-report/index.html\`
- LCOV File: \`coverage/lcov.info\`
```

**Test Improvement Recommendations Template:**
```markdown
# Test Improvement Recommendations

**Date:** YYYY-MM-DD
**Project:** [Project Name]
**Reviewed By:** [Name/AI]

## Overview
[Summary of test suite review and key findings]

## Current State

### Strengths
- [What's working well]
- [What's working well]

### Weaknesses
- [What needs improvement]
- [What needs improvement]

## Prioritized Recommendations

### 🔴 High Priority (Do Now)

#### 1. Fix Flaky Tests
**Issue:** 3 E2E tests fail intermittently
**Impact:** Blocks deployments, reduces confidence
**Solution:**
- Add proper wait conditions
- Increase timeouts where needed
- Add retry logic for network requests
**Effort:** 1-2 days
**Owner:** [Name]

#### 2. Add Tests for Critical Path
**Issue:** Checkout flow has only 60% coverage
**Impact:** High risk of production bugs
**Solution:**
- Add 5 unit tests for payment validation
- Add 2 E2E tests for complete checkout
**Effort:** 2-3 days
**Owner:** [Name]

### 🟡 Medium Priority (Next Sprint)

#### 3. Improve Test Performance
**Issue:** Test suite takes 8 minutes to run
**Impact:** Slow feedback loop
**Solution:**
- Parallelize test execution
- Mock slow external APIs
- Split large test files
**Effort:** 3-4 days
**Owner:** [Name]

### 🟢 Low Priority (Backlog)

#### 4. Add Visual Regression Tests
**Issue:** UI changes not caught by current tests
**Impact:** Occasional UI regressions
**Solution:**
- Integrate Percy or Chromatic
- Add visual tests for key pages
**Effort:** 1 week
**Owner:** [Name]

## Best Practices to Adopt

1. **Test Data Factories**
   - Use factories instead of inline test data
   - Makes tests more maintainable

2. **Shared Test Utilities**
   - Extract common setup into helpers
   - Reduces duplication

3. **Better Test Naming**
   - Use descriptive test names
   - Follow pattern: "should [expected behavior] when [condition]"

## Success Metrics

### Target for Next Month
- [ ] All flaky tests fixed
- [ ] Critical path coverage at 100%
- [ ] Test execution time under 5 minutes
- [ ] Zero skipped tests

## References
- [Coverage report]
- [CI/CD logs]
- [Test strategy doc]
```

**When to Create Files:**
- Create test strategy at project start or when approach changes
- Create coverage reports after significant testing work or monthly
- Create test improvement recommendations after reviews
- Create test plans for major features
- Update documentation when test approach evolves

## Quality Criteria

Testing is complete when:
- ✅ Test strategy is documented
- ✅ Critical paths have E2E tests
- ✅ High-risk areas have comprehensive unit tests
- ✅ Coverage meets defined goals
- ✅ All tests pass consistently
- ✅ No known flaky tests
- ✅ Tests are maintainable and clear
- ✅ CI/CD integration is working
- ✅ **Test documentation files created and up to date**

## Notes

- Testing is iterative - start with critical paths, expand coverage over time
- Flaky tests are worse than no tests - fix or remove them
- Tests are documentation - make them readable
- Don't chase 100% coverage - focus on valuable tests
- Good tests enable confident refactoring
- Balance between test coverage and development velocity
- **Document test strategies, coverage analysis, and recommendations in markdown files**
