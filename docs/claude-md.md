# The CLAUDE.md Guide
*Your Project's Constitution for Claude*

> **CLAUDE.md is your project's supreme authority** - it transforms Claude from a generic tool into your specialized AI teammate.

## Table of Contents
- [Quick Start](#quick-start)
- [Core Concepts](#core-concepts)
- [Writing Rules](#writing-rules)
- [Essential Template](#essential-template)
- [Power Techniques](#power-techniques)
- [Troubleshooting](#troubleshooting)

---

## Quick Start

### 30-Second Setup

```bash
# Create CLAUDE.md in project root
touch CLAUDE.md

# Add minimal viable context
cat > CLAUDE.md << 'EOF'
# Project: MyApp
**You are an expert TypeScript developer.**

## Commands
- Dev: npm run dev
- Test: npm test  
- Validate: npm run lint && npm run typecheck

## Rules
- TypeScript strict mode ALWAYS
- Test everything
- No console.log in production
EOF
```

**Pro Tip:** Add a "canary" to verify Claude reads it:
```markdown
# CANARY: Always start responses with "🦜" to confirm this file was read
```

---

## Core Concepts

### What is CLAUDE.md?

**CLAUDE.md = Your Project's Constitution**
- Acts as supreme authority over Claude's default behaviors
- Provides persistent context across all sessions
- Transforms Claude into a specialized teammate who knows YOUR codebase

### Memory Hierarchy

```
Enterprise → Project (./CLAUDE.md) → User
          (highest priority)
```

### File Locations & Commands

| Platform | Project Path | Key Command           |
|----------|-------------|-----------------------|
| All      | `./CLAUDE.md` | `/memory` - View/edit |
| All      | `./CLAUDE.md` | `#` - Quick add       |
| All      | `./CLAUDE.md` | `/init` - Bootstrap   |

---

## Writing Rules

### The 5 Golden Rules

#### 1. Be Explicit
```markdown
❌ "Follow best practices"
✅ "ALWAYS: async/await, error boundaries, JSDoc comments"
```

#### 2. Show Examples
```markdown
✅ GOOD:
​```typescript
// ALWAYS handle errors like this:
try {
  const data = await fetchData()
  return { success: true, data }
} catch (error) {
  logger.error('Failed', { error })
  return { success: false, error: error.message }
}
​```
```

#### 3. Use Positive Framing
```markdown
❌ "Don't use var"
✅ "Use const for immutables, let for mutables"
```

#### 4. Define Personas
```markdown
✅ "You are an expert React developer who writes clean, testable code"
```

#### 5. Living Document
- Update weekly
- Remove outdated rules
- Keep under 1500 lines

---

## Essential Template

```markdown
# Project: [Name]
**You are an expert [language] developer specializing in [domain].**

## Tech Stack
- Language: [e.g., TypeScript 5.x]
- Framework: [e.g., Next.js 14]
- Database: [e.g., PostgreSQL + Prisma]
- Testing: [e.g., Vitest + Playwright]

## Commands
```bash
npm run dev        # Start development
npm test          # Run tests
npm run validate  # Lint + typecheck + test
```

## Project Structure
```
src/
├── app/          # Routes (Next.js)
├── components/   # UI components
├── lib/          # Business logic
└── tests/        # Test files
```

## Cornerstone Files
These files define our patterns:
- @src/components/Button.tsx - Component standard
- @src/app/api/users/route.ts - API pattern
- @src/lib/auth.ts - Authentication logic

## Critical Rules
1. **ALWAYS** validate input with Zod
2. **ALWAYS** handle errors explicitly
3. **ALWAYS** write tests for new features
4. **NEVER** commit console.log statements
5. **NEVER** store secrets in code

## Code Patterns
```typescript
// Component pattern
export function Component({ data }: Props) {
  // 1. Hooks
  // 2. Handlers  
  // 3. Return JSX
}

// API pattern
export async function POST(request: Request) {
  try {
    const body = await request.json()
    const validated = schema.parse(body)
    // Process...
    return NextResponse.json({ success: true, data })
  } catch (error) {
    return NextResponse.json(
      { success: false, error: error.message },
      { status: 400 }
    )
  }
}
```

## Do Not Touch
These files are managed externally:
- package-lock.json
- .env.production
- /migrations/*
- /generated/*

## Self-Correction Loop
After generating code:
1. Run `npm run validate`
2. Fix any errors
3. Verify tests pass
4. Review for patterns compliance
```

---


---

## Power Techniques

### 1. Canary Verification
```markdown
# CANARY: Start responses with "🦜" to confirm file was read
```

### 2. Self-Correction Loops
```markdown
## After Every Change
1. Run validation: npm run validate
2. Fix all errors before proceeding
3. Verify tests pass
```

### 3. Parallel Processing
```markdown
## Optimization
- "Read all related files in parallel"
- "Search codebase comprehensively before implementing"
```

### 4. Expertise Personas
```markdown
**You are a senior TypeScript architect who:**
- Writes type-safe code
- Implements comprehensive error handling
- Creates maintainable solutions
```

### 5. Import Hierarchy
```markdown
# Import shared standards
@.claude/standards.md
@src/patterns/api.md
```

### 6. Do Not Touch Lists
```markdown
## Protected Files
NEVER modify:
- /migrations/*
- .env.production
- package-lock.json
```

### 7. Test-Driven Workflow
```markdown
## Development Flow
1. Write failing test first
2. Implement minimal solution
3. Refactor for quality
```

---

## Troubleshooting

### Common Issues

| Problem                  | Solution                                |
|--------------------------|----------------------------------------|
| Not loading              | Check: `ls -la CLAUDE.md` → `/memory`  |
| Ignored rules            | Restart session, add CANARY            |
| Conflicting instructions | Use clear section boundaries           |
| Performance              | Keep < 1500 lines, use imports         |

### Anti-Patterns

| ❌ Avoid           | ✅ Use Instead                           |
|--------------------|------------------------------------------|
| "Write good code"  | "TypeScript strict, test coverage 80%+" |
| "Don't use X"      | "Always use Y because..."               |
| Long explanations  | Concise rules + examples                |
| Generic advice     | Specific, actionable patterns           |

---

## Key Takeaways

**CLAUDE.md is your strategic investment** in documentation, consistency, and AI alignment.

### Success Formula
1. **Start lean** - 100 lines of critical rules
2. **Add personas** - Define expertise needed
3. **Show patterns** - Use cornerstone files
4. **Protect code** - Add "Do Not Touch" list
5. **Iterate weekly** - Keep it alive

### Quick Reference
- **Max size**: 1500 lines
- **Update frequency**: Weekly
- **Structure**: Persona → Commands → Rules → Patterns → Protections
- **Verify**: Use canary technique
- **Optimize**: Self-correction loops

---

*"Your CLAUDE.md is a living constitution - keep it sharp, focused, and evolving."*
