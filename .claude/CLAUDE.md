# Personal Claude Code Workflow

## Preferred Development Process

**Feature Development Workflow:**

1. **Feature Planning Phase** - When given a feature description:
   - Understand the feature requirements fully
   - Explore relevant parts of both backend and frontend codebase
   - Create comprehensive plan covering backend and frontend implementation
   - Present complete plan and wait for approval before any implementation
2. **TDD Session(s)** - Execute planned backend work using TDD sessions
3. **Frontend Implementation** - Execute frontend work after backend is complete
4. **Integration Testing** - Verify full feature works end-to-end
5. **Manual Testing Request** - Explicitly ask user to manually test the feature before considering it complete

**Step-by-Step Implementation (within phases):**
1. **Execute One Step at a Time** - Implement only one step from the plan at a time
2. **Commit After Each Step** - After user reviews changes in their editor, create a git commit for that step
3. **Repeat** - Continue with the next step only after the previous step is committed

**Key Principles:**
- Focus on small-to-medium tasks within existing codebases
- No major refactoring or new app creation without explicit request
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
- **CLAUDE.md Updates:** When updating this file, always commit and push using yadm:
  - `yadm add ~/.claude/CLAUDE.md`
  - `yadm commit -m "Update Claude Code workflow configuration"`
  - `yadm push`
- **Proactive Config Updates:** Anticipate when user requests should be added to configuration
  - When user asks to change a process, workflow, or preference
  - When user corrects how something should be done
  - When user establishes a new pattern or standard
  - **Always ask:** "Should I add this to your configuration for future sessions?"
- **CLAUDE.md Updates:** Proactively identify opportunities to update CLAUDE.md based on discussions and notify user

**Pull Request Guidelines:**
- **PR Title:** Always prefix with Linear ticket number from branch name (e.g., "UE-2958: Description")
- **PR Template:** Use standard template with `--body-file .github/pull_request_template.md`
- **Draft PRs:** Use `gh pr create --draft --title "TICKET: Title" --body-file .github/pull_request_template.md`

## TDD Workflow (Rails Backend Only)

**TDD Session Lifecycle:**

**Session Start:** When user requests TDD approach, I ask "Should we start a TDD session for this?"
**Session End:** When user indicates task completion, I ask "Should we end the TDD session and squash commits?"

**TDD Process:**

1. **Write Spec First** - User describes a behavior, I write a Rails spec for it
2. **Review & Approve** - User reviews spec, requests changes if needed
3. **Commit Spec** - Once approved, commit the spec to git
4. **Focus Mode** - Add `f` prefix to test (`fit` or `fdescribe`) for RSpec focus
5. **Red-Green-Refactor** - Run focused test repeatedly while implementing
6. **Commit Implementation** - Each working increment gets committed
7. **Repeat** - Continue with next behavior/test as needed

**Session Completion:**
1. **Remove Focus** - Remove all `f` prefixes from `fit`/`fdescribe` blocks
2. **Show Final Diff** - Display color-coded diff of all changes using `git diff --color=always`
3. **Confirm Squash** - Wait for user confirmation before proceeding with squash
4. **Squash Commits** - Combine all commits from the TDD session into one
5. **Final Commit** - Single commit with descriptive message for the entire feature

**Key TDD Principles:**
- Start with failing test that describes the desired behavior
- Use RSpec focus mode (`fit`/`fdescribe`) to run only the current test
- Run test frequently during implementation to maintain feedback loop
- Keep test focused and specific to one behavior
- Follow Arrange-Act-Assert pattern as specified in project CLAUDE.md
- All commits during session will be squashed at the end
- **Request Spec Efficiency:** Add new assertions to existing request specs rather than creating new ones, since request specs are slower
- **Color-Coded Diffs:** Always use `--color=always` flag when showing git diffs to user

**Storybook Integration:**
- **Always check for Storybook stories** when modifying components or backend models
- **Update story data objects** to include new fields when backend models change
- **Search pattern:** Use `find` and `grep` to locate stories that reference modified components
- **Prevent runtime errors** by ensuring story data matches component expectations

**Test Commands:**
- Run focused tests: `docker exec musashi-web-1 bundle exec rspec`
- Run specific test: `docker exec musashi-web-1 bundle exec rspec path/to/spec.rb:LINE_NUMBER`
- TDD mode: `docker exec -e RAILS_ENV=test -ti musashi-web-1 bundle exec guard`
