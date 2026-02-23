# Error Recovery Workflow

## Automatic Recovery Process

1. **Detect Failure**
   - Non-zero exit code
   - Timeout condition
   - Error message in output

2. **Log Failure Details**
   - Command executed
   - Response/error message
   - Timestamp (ISO format)

3. **Execute Home Command**
   - Return to safe position
   - Command: `ssh pi@{HOST} "robot-cli home"` (adapt to user's syntax)

4. **Verify Home Position**
   - Check status after home command
   - Confirm successful return

5. **Retry Original Command**
   - Use exponential backoff (1s, 2s, 4s delays)
   - Maximum retry attempts: 3

6. **Escalate if Still Failing**
   - Log escalation event
   - Request manual intervention
   - Do not continue automated testing

## Recovery Decision Tree

| Error Type | Recovery Action |
|------------|----------------|
| Communication error | Retry SSH connection (max 3 attempts) |
| Movement error | Home + retry movement (max 3 attempts) |
| Limit exceeded | Document limit + home (no retry) |
| Unknown error | Home + manual investigation |

## Recovery Success Tracking

Log all recovery attempts with:
- Error type
- Recovery action taken
- Success/failure outcome
- Time to recover
