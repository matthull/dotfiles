# Personal Claude Code Workflow

## Preferred Development Process

***Technology-Specific Workflows***
For Rails apps: Always use TDD unless otherwise specified. Write request specs to cover controller actions and jbuilder views, and unit tests for other units of code.
For Vue apps: Use Storybook to test `.vue` components. Use unit tests for `.ts` or `.js` files.
For others (command line utilities, data integration scripts, etc.): Prefer typescript over bash or python. Always unit test, and define end to end integration tests as well.

**Step-by-Step Implementation (within phases):**
1. **Execute One Step at a Time** - Implement only one step from the plan at a time
2. **Commit After Each Step** - After user reviews changes in their editor, create a git commit for that step
3. **Repeat** - Continue with the next step only after the previous step is committed

**Key Principles:**
- User reviews all changes in their code editor before committing
- Each step should be atomic and independently reviewable
- Always wait for user confirmation before proceeding to the next step
- Use descriptive commit messages that explain the "why" not just the "what"

**Task Scope:**
- Prefer incremental improvements over large changes
- Break complex features into smaller, testable components
- Maintain backward compatibility when possible
- Focus on code quality and maintainability
- **Backend First:** When features involve both backend and frontend changes, work on backend first (unless explicitly specified otherwise)

**Communication:**
- Be explicit about what each step will accomplish
- Explain any trade-offs or decisions made during implementation
- Ask clarifying questions when requirements are ambiguous
- Provide context for why specific approaches were chosen
- **Always show color-coded diffs** when displaying git changes to user
- **Balanced Analysis:** Always provide pros/cons when user proposes new ideas - avoid being a "yes man"
- **Critical Thinking:** Challenge assumptions and identify potential issues with proposed changes

**Commit Process:**
- **Always pause before commits** - Show `git diff --color=always` and ask for verification
- **Never commit without approval** - Wait for user confirmation before proceeding
- **Apply to all commits** - Not just TDD session squashes, but every single commit

**Configuration Management:**
- Don't update the global CLAUDE.md in ~/.claude/CLAUDE.md or the project CLAUDE.md, instead just update the project CLAUDE.local.md

## Testing Workflow

**TDD Session Lifecycle:**

**Session Start:** When user requests TDD approach, I ask "Should we start a TDD session for this?"
**Session End:** When user indicates TDD cycle completion, I ask "Should we end the TDD session and squash commits?"

**TDD Process:**

1. **Write Spec First** - User describes a behavior, I write a Rails spec for it
2. **Review & Approve** - User reviews spec, requests changes if needed
3. **Commit Spec** - Once approved, commit the spec to git
4. **Red-Green-Refactor** - Run focused test repeatedly while implementing. Once they pass, enter refactoring phase until I indicate code factoring is adequate.
5. **Commit Implementation** - Once a Red-Green-Refactor cycle completes, prompt me to commit the code.
6. **Repeat** - Continue with next behavior/test as needed

**Key TDD Principles:**
- Start with failing test that describes the desired behavior
- Run test frequently during implementation to maintain feedback loop
- Keep test focused and specific to one behavior
- Follow Arrange-Act-Assert pattern as specified in project CLAUDE.md
- **Request Spec Efficiency:** Add new assertions to existing request specs rather than creating new ones, since request specs are slower
- **Color-Coded Diffs:** Always use `--color=always` flag when showing git diffs to user

## Development Workflow

Use this defined process for each development task initiated via `/start-task`. We'll document
each phase as we go in a task-specific document in the .llm/tasks directory using current branch name.

**Task Tracking System:**
- `.llm/current-task` file tracks the currently active task (contains branch name)
- `/start-task` creates this file and the task document
- `/end-task` removes this file and completes the task document
- Only one task can be active at a time (prevents task conflicts)
- **Note:** `.llm/` directory is project-specific, not global
- **Template:** See `~/.claude/current-task-template` for file format and usage documentation

**Project-Specific Adaptations:**
Projects may customize this workflow by:
- Storing task documents in `.llm/tasks/` (project-specific directory)
- Storing specifications in `.llm/specifications/` (project-specific directory)
- Using `.llm/parking-lot.md` for project-specific development ideas and issues
- Integrating with project-specific coordination patterns (e.g., multi-agent systems)

**Flexible Task Outcomes**: Tasks may naturally conclude at any phase based on scope and discoveries:
- **Design/Planning Focus**: Tasks may end after phases 1-3 with specifications, architecture, or design decisions
- **Partial Implementation**: Tasks may implement some requirements while documenting remaining work for future tasks
- **Full Implementation**: Tasks may complete entire feature implementation and testing

All tasks follow the same workflow but stop at the natural completion point.

**Parking Lot Usage**: Use `.llm/parking-lot.md` to capture development ideas, issues, and goals that come up during work but aren't immediately actionable. Add entries chronologically with date stamps to table tangents for future exploration. When adding entries, include any relevant analysis (pros/cons, design questions, key considerations) directly in the parking lot entry, then immediately return to the current discussion without elaborating further.


**Feature Development Workflow:**
### 1. Task Goal Definition Phase
- User creates a branch for the task (branch name determined by user)
- User states initial goal
- Claude asks clarifying questions about requirements, pain points, success criteria
- Refine understanding of what needs to be built/changed

### 2. Strategy Refinement Phase
- Claude proposes implementation approach based on research
- **CRITICAL: Provide balanced pros/cons analysis** - never be a "yes man" to user ideas
- Ask questions to clarify technical details and user preferences
- Refine strategy through collaborative discussion and keep it documented in the task-specific document
- Ensure alignment with existing system architecture

### 3. Implementation Planning Phase
- Create detailed implementation plan with specific changes in small steps
- Present plan for explicit user approval
- Include testing strategy and coordination requirements
- Include a plan for creating automated end-to-end integration tests when technologically feasible
- Include a plan for manual verification
- Define success criteria and rollback approach

### 4. Implementation Phase
- **TDD Session(s)** - Execute planned work using TDD cycles, with the exception of frontend Vue components and other non-applicable items like documentation or CSS
- **Frontend Implementation** - Use TDD workflow for `.ts` files or Rails application changes. For `.vue` component changes will rely on Storybook and manual testing.
- Implement each step of the implementation plan one at a time.
- **PAUSE after each step**: Ask for user verification before proceeding
- **Update implementation tracking**: After verification, update status in relevant specification documents
- Ask for approval after each step
- User handles all git commits and pushes unless Claude is explicitly asked to do so

### 5. Final Review/Manual Testing
- Suggest manual testing process
- Wait for user to test and approve
- We may loop back to implementation or implementation planning phase based on issues found
- User handles branch checkout and merging once task is complete

## Specification Workflow

Use `.llm/specifications/` to create and manage detailed specifications for future implementation tasks.

**Specification Lifecycle:**
1. **Create Specification** - Write detailed spec with "In Progress" status
2. **Track Implementation** - Update implementation status for individual requirements
3. **Reference in Tasks** - Implementation tasks reference and update relevant specifications  
4. **Partial Implementation** - Specifications can have mixed implementation status
5. **Mark Complete** - Update status to "Complete" when all requirements implemented
6. **Archive** - Move fully implemented specs to `specifications/completed/` directory

**Specification Format:**
- Use `.llm/specifications/TEMPLATE.md` as starting point
- Include Purpose, Requirements, Technical Details, Implementation Notes
- **Implementation Tracking Table** - Track status of each requirement individually
- **Acceptance Criteria** - With implementation status for each criterion
- Task references and change log for specification updates

**When to Create Specifications:**
- Complex features requiring detailed planning before implementation
- Cross-agent functionality needing coordination specifications
- System architecture changes affecting multiple components
- API or interface definitions for future development

**Integration with Task Workflow:**
- **Design-focused tasks** - Can create specifications without any implementation
- **Implementation-focused tasks** - Reference and update specification implementation status  
- **Mixed scenarios** - Single task can create spec and implement some/all requirements
- **Partial implementation** - Specifications remain active until fully implemented
- **Cross-task continuity** - Multiple tasks can implement different parts of same spec

## File Naming Conventions

**Development Tracking:**
- Task documents: `{branch-name}-task.md` (branch-name-based, in .llm/tasks/)
- Specifications: `specification-name.md` (kebab-case, in .llm/specifications/)

## Custom Commands Available

**Global commands (available in all projects):**
- `start-task` - Initialize development tasks using current branch name and `.llm/current-task` tracking
- `end-task` - Complete tasks with status tracking and cleanup

**Project-specific commands:** Check each project's `.claude/commands/` directory for additional commands.

## Git Workflow

- User handles all git commits and pushes unless Claude is explicitly asked to do so
- User creates branches for tasks and manages merging
- Claude can suggest commit messages and testing approaches
- Create handoff documents for major system changes
