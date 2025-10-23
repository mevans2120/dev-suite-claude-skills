---
name: product-research
description: Conduct comprehensive product research including market analysis, competitive research, user needs assessment, and technology evaluation for digital products
version: 1.0.0
---

# Product Research Skill

This skill guides comprehensive research activities for digital product development, including market analysis, competitive research, user needs assessment, and technology evaluation.

## When to Use This Skill

Use this skill when you need to:
- Conduct market research for a new product or feature
- Analyze competitors and their offerings
- Evaluate technology options and trade-offs
- Assess user needs and pain points
- Investigate technical feasibility
- Research industry trends and best practices
- Validate product assumptions

## Core Research Activities

### 1. Market & Competitive Analysis

**Competitive Landscape Research:**
- Identify direct and indirect competitors
- Analyze competitor features, pricing, and positioning
- Map competitive advantages and gaps
- Document market trends and opportunities

**Market Assessment:**
- Define target market size and segments
- Identify market trends and growth patterns
- Assess regulatory and compliance requirements
- Evaluate market entry barriers

**Output Format:**
- Competitive matrix comparing key features
- Market sizing analysis
- Opportunity assessment summary
- Key findings and recommendations

### 2. User Research & Needs Assessment

**User Understanding:**
- Define target user personas
- Identify user pain points and needs
- Map user journeys and workflows
- Analyze user feedback and reviews (if available)

**Research Methods:**
- Secondary research from existing sources
- Competitor user review analysis
- Industry reports and case studies
- User behavior pattern analysis

**Documentation:**
- User persona profiles
- Pain point analysis
- User journey maps
- Needs prioritization matrix

### 3. Technology & Feasibility Research

**Technology Stack Evaluation:**
- Research appropriate technologies for requirements
- Compare framework and tool options
- Assess technical risks and constraints
- Evaluate scalability and performance considerations

**Feasibility Assessment:**
- Technical feasibility analysis
- Resource requirements estimation
- Risk identification and mitigation
- Integration complexity assessment

**AI-First Development Considerations:**
When AI will be building the product, prioritize:
- Modern, well-documented frameworks with strong AI tool support
- Technologies with clear patterns and conventions
- Serverless and managed services to reduce infrastructure complexity
- TypeScript/JavaScript for frontend (React ecosystem)
- Next.js for full-stack applications
- Python for backend tooling and data processing
- Component-based architectures

### 4. Requirements Synthesis

**Research Synthesis:**
- Consolidate findings from all research streams
- Identify key insights and patterns
- Prioritize findings by impact and feasibility
- Create actionable recommendations

**Integration with Other Skills:**
- Findings feed into Planning (Technical Architecture) skill
- User needs inform Development skill priorities
- Quality considerations guide QE skill focus
- Can reference project-management skills if available

## Research Methodology

### Discovery Phase
1. **Define Research Questions:** What do we need to learn?
2. **Identify Information Sources:** Where can we find answers?
3. **Gather Data:** Collect relevant information systematically
4. **Analyze Findings:** Extract insights and patterns
5. **Synthesize Results:** Create cohesive narrative and recommendations

### Documentation Standards

**Research Reports Should Include:**
- Executive summary (key findings and recommendations)
- Methodology and sources
- Detailed findings by category
- Supporting data and evidence
- Actionable next steps
- Confidence levels for findings

**Visual Formats:**
- Comparison matrices
- Diagrams and flowcharts
- Charts for quantitative data
- Journey maps and personas

## Integration with Development Suite

### Collaboration with Other Skills

**To Planning/Architecture Skill:**
- Technology evaluation findings
- Scalability requirements
- Integration needs
- Risk assessment

**To Development Skill:**
- User requirements and priorities
- Feature specifications
- Technical constraints
- Reference implementations

**To Quality Engineering Skill:**
- Critical user paths
- Risk areas requiring testing focus
- Performance requirements
- Compliance needs

**From Project Management Skills (if available):**
- Project scope and objectives
- Timeline constraints
- Resource availability
- Stakeholder requirements

**From Design Skills (if available):**
- Design system requirements
- User experience patterns
- Accessibility standards
- Visual design direction

### Independent Operation

This skill can operate independently when:
- Starting a new project from scratch
- Evaluating new technologies or approaches
- Conducting ad-hoc research tasks
- Responding to specific research questions

## Best Practices

### Research Quality
- **Cite Sources:** Always document information sources
- **Verify Information:** Cross-reference critical findings
- **Assess Recency:** Note when information was published
- **Show Confidence Levels:** Indicate certainty of findings
- **Avoid Assumptions:** Clearly distinguish facts from inferences

### Efficiency
- **Start Broad, Then Narrow:** Begin with overview, dive into specifics
- **Prioritize Impact:** Focus on high-impact research areas first
- **Timebound Research:** Set research time limits to avoid analysis paralysis
- **Iterate:** Initial research can be refined as project evolves

### AI-Friendly Outputs
- Use structured formats (tables, lists, matrices)
- Clear section headers and organization
- Actionable recommendations
- Link to authoritative sources
- Include relevant code examples or technical specifications

## Example Usage Scenarios

### Scenario 1: New Product Idea
```
User: "I want to build a task management app for remote teams. Help me research the market."

Research Process:
1. Identify existing task management tools (Asana, Trello, Monday, etc.)
2. Analyze remote team-specific features
3. Review user pain points from reviews
4. Assess market differentiation opportunities
5. Evaluate technology stack options
6. Synthesize findings into opportunity assessment

Output: Competitive analysis, market opportunity brief, technology recommendations
```

### Scenario 2: Technology Selection
```
User: "Should we use Next.js or separate React + Node.js backend?"

Research Process:
1. Compare architecture patterns
2. Evaluate development complexity
3. Assess performance implications
4. Consider deployment and scaling
5. Review AI development tool support
6. Make recommendation with trade-offs

Output: Technology comparison matrix, recommendation with rationale
```

### Scenario 3: Feature Feasibility
```
User: "Can we add real-time collaboration to our app?"

Research Process:
1. Research real-time collaboration patterns
2. Evaluate WebSocket vs. other approaches
3. Assess complexity and technical requirements
4. Review existing implementations
5. Estimate development effort
6. Identify risks and mitigation strategies

Output: Feasibility assessment, implementation approach, risk analysis
```

## Deliverables

### Standard Research Outputs
- **Executive Summary:** 1-2 page overview of key findings
- **Detailed Report:** Comprehensive findings with supporting evidence
- **Comparison Matrices:** Side-by-side feature/technology comparisons
- **Visual Diagrams:** Flowcharts, journey maps, architecture diagrams
- **Recommendations:** Prioritized, actionable next steps

### Documentation Format
- Clear structure with headings and sections
- Executive summary at the top
- Evidence-based conclusions
- Links to sources and references
- Next steps and open questions

### Creating Documentation Files

**Always create markdown files for research deliverables:**

**File Naming Convention:**
- `research-[topic]-[YYYY-MM-DD].md` for general research
- `competitive-analysis-[product]-[YYYY-MM-DD].md` for competitor analysis
- `tech-evaluation-[technology]-[YYYY-MM-DD].md` for technology assessments
- `market-research-[domain]-[YYYY-MM-DD].md` for market analysis

**Recommended Location:**
- `docs/research/` - For all research documentation
- `docs/decisions/` - For research-backed decisions

**File Structure Template:**
```markdown
# [Research Title]

**Date:** YYYY-MM-DD
**Researcher:** [Name/AI]
**Status:** Draft | Final | Archived

## Executive Summary
[2-3 paragraphs summarizing key findings]

## Objectives
- [Research question 1]
- [Research question 2]

## Methodology
[How research was conducted, sources used]

## Findings

### [Category 1]
[Detailed findings...]

### [Category 2]
[Detailed findings...]

## Competitive Analysis
| Competitor | Strengths | Weaknesses | Key Features |
|------------|-----------|------------|--------------|
| ...        | ...       | ...        | ...          |

## Recommendations
1. **[Priority]** [Recommendation with rationale]
2. **[Priority]** [Recommendation with rationale]

## Risks & Considerations
- [Risk or consideration]
- [Risk or consideration]

## Next Steps
- [ ] [Actionable next step]
- [ ] [Actionable next step]

## References
- [Source 1]
- [Source 2]
```

**When to Create Files:**
- Always create for completed research projects
- Create after significant discovery sessions
- Update existing files when new information emerges
- Create summary files for multi-day research efforts

## Quality Criteria

Research is complete when:
- ✅ Key questions are answered with evidence
- ✅ Multiple sources validate findings
- ✅ Confidence levels are indicated
- ✅ Recommendations are actionable
- ✅ Risks and trade-offs are identified
- ✅ Findings are documented clearly
- ✅ Next steps are defined

## Notes

- This skill focuses on secondary research (desk research, analysis of existing sources)
- For primary research (user interviews, surveys), coordinate with project management
- Research should inform but not dictate decisions - trade-offs exist
- Keep research timeboxed to maintain project momentum
- Update research as new information becomes available
