# Load a session

## Context:
- Sessions: @.claude/sessions/

## Preflight:
- If `$ARGUMENT` is provided:
Set `$SESSION_NAME` to `$ARGUMENT`, ensuring it is a valid session filename with `.md` extension.

- If `$ARGUMENT` is not provided
Set `$SESSION_NAME` to the current session name from `.claude/sessions/.current-session`, if it exists.
If it does not exist, STOP and prompt the user to specify a session name.

## Task:
1. Take the `$SESSION_NAME` and check if a file exists at `.claude/sessions/$SESSION_NAME`.
2. If the session file does **not** exist:
   * Notify the user that the session was not found.
   * List all available `.md` session files located in the `.claude/sessions/` directory.
   * Prompt the user to choose from the list.
3. If the session file **does** exist:
   * Update the current session pointer by writing the `$SESSION_NAME` filename to `.claude/sessions/.current-session`.
4. Load the session file content.
5. Check for running background Bash commands.

## Output:
```markdown
Loaded the session `$SESSION_NAME` successfully. Here is a summary of the session:

    <session content summary>

Let's continue working on this session.
```
