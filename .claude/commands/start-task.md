Initialize a new development task with proper documentation following the workflow defined in CLAUDE.md.

## Syntax
```
/start-task
```

## Behavior
This command will:
1. **Check for existing task**: Error if there's already a task in progress (tracked in `.llm/current-task`)
2. **Get current branch**: Use the current git branch name as the task identifier
3. **Create task document**: Generate `.llm/tasks/{branch-name}-task.md` with initial template
4. **Track current task**: Write branch name to `.llm/current-task` file
5. **Begin task workflow**: Start the Task Goal Definition Phase

## Error Conditions
- **Already in task**: If `.llm/current-task` exists, the command will fail with an error message
- **On main branch**: If current branch is `main`, will prompt user to create a task branch first

## Task Workflow
Once started, tasks follow the standard workflow phases:
- Task Goal Definition Phase
- Strategy Refinement Phase  
- Implementation Planning Phase
- Implementation Phase
- Final Review/Manual Testing