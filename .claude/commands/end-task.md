Complete the current development task with status tracking.

## Syntax
```
/end-task
```

## Behavior
This command will:
1. **Check for active task**: Error if no task is in progress (no `.llm/current-task` file)
2. **Get current task**: Read task name from `.llm/current-task` file
3. **Complete task documentation**: Update `.llm/tasks/{task-name}-task.md` with final status and completion date
4. **Review implementation**: Summarize what was accomplished
5. **Clear task tracking**: Remove `.llm/current-task` file
6. **Clear context**: Run `/clear` to provide fresh context for next task

## Error Conditions
- **No active task**: If `.llm/current-task` doesn't exist, the command will fail with an error message
- **Missing task document**: If the task document doesn't exist, will create a minimal completion entry

## Post-Completion
- User handles any git branch merging/cleanup as needed
- Task document remains in `.llm/tasks/` for future reference
- System is ready for a new `/start-task` command
