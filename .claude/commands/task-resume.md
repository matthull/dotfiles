Resume work on the current task by reading the task document and understanding any handoff context.

## Syntax
```
/task-resume
```

## Behavior
This command will:
1. **Check for active task**: Error if no task is in progress (no `.llm/current-task` file)
2. **Get current task**: Read task name from `.llm/current-task` file
3. **Read task document**: Load and review `.llm/tasks/{task-name}-task.md` content
4. **Process handoff context**: Understand any conversation handoffs and current status
5. **Resume workflow**: Continue from where the task was paused

## Error Conditions
- **No active task**: If `.llm/current-task` doesn't exist, the command will fail with an error message
- **Missing task document**: If the task document doesn't exist, will report the error

## Usage Notes
- Use this command after context clearing to resume a paused task
- Claude will read the full task document and understand current progress
- Handoff sections provide context for continuing work seamlessly
- Task workflow resumes from the appropriate phase based on documented status