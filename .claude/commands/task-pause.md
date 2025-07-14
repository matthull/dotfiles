Create a conversation handoff entry in the current task document to facilitate resuming the task after context clearing.

## Syntax
```
/task-pause
```

## Behavior
This command will:
1. **Check for active task**: Error if no task is in progress (no `.llm/current-task` file)
2. **Get current task**: Read task name from `.llm/current-task` file
3. **Append handoff section**: Add a conversation handoff to `.llm/tasks/{task-name}-task.md` with:
   - Current timestamp
   - Summary of current progress/status
   - Key context needed for resuming
   - Next steps or actions planned
   - Any blockers or open questions

## Error Conditions
- **No active task**: If `.llm/current-task` doesn't exist, the command will fail with an error message
- **Missing task document**: If the task document doesn't exist, will create a minimal handoff entry

## Usage Notes
- Use this command before context clearing when you need to pause work on a task
- Handoff entries help maintain continuity when resuming tasks later
- Multiple handoffs can be added to the same task document over time
- Task remains active (`.llm/current-task` file is not removed)