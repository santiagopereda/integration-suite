# Hook Merging Logic

When merging hooks into target's `settings.local.json`:

1. Read target file (or create default structure if missing)
2. For each hook in agent's dependencies:
   - Check if matcher exists in target
   - If matcher doesn't exist → Add hook
   - If exists with same command → Skip (already present)
   - If exists with different command → Ask user how to proceed
3. **Preserve** target's existing permissions (allow, deny, ask arrays)
4. Write merged configuration

## Default Structure (if file missing)

```json
{
  "permissions": {
    "allow": [],
    "deny": [],
    "ask": []
  },
  "hooks": {}
}
```

## Example: Merging a PostToolUse Hook

**Source hook** (from agent dependency):
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write|NotebookEdit",
        "hooks": [
          {
            "type": "command",
            "command": "bash .agent/telemetry/hooks/log_invocation.sh"
          }
        ]
      }
    ]
  }
}
```

**Merge logic**:
1. Check if `PostToolUse` array exists in target
2. Check if matcher `Edit|Write|NotebookEdit` already exists
3. If not → append the hook entry
4. If yes with same command → skip (already configured)
5. If yes with different command → prompt user to choose
