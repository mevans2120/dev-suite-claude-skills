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

## Notes

- Testing is iterative - start with critical paths, expand coverage over time
- Flaky tests are worse than no tests - fix or remove them
- Tests are documentation - make them readable
- Don't chase 100% coverage - focus on valuable tests
- Good tests enable confident refactoring
- Balance between test coverage and development velocity
