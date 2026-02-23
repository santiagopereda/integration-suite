# SSH Command Patterns for Robot Arm Testing

## Basic Status Check
```bash
ssh pi@{HOST} "robot-cli status"
```

## Movement with Status Verification
```bash
ssh pi@{HOST} "robot-cli move x {VALUE} && robot-cli status"
```

## Multi-Step Test Sequence with Logging
```bash
{
  echo "Test started: $(date -Iseconds)"
  ssh pi@{HOST} "robot-cli home && robot-cli status"
  ssh pi@{HOST} "robot-cli move x 50 && robot-cli status"
  ssh pi@{HOST} "robot-cli move y 50 && robot-cli status"
  ssh pi@{HOST} "robot-cli home && robot-cli status"
  echo "Test completed: $(date -Iseconds)"
} 2>&1 | tee test-session-$(date +%Y%m%d-%H%M%S).log
```

## Error Recovery with Home Return
```bash
ssh pi@{HOST} "robot-cli move x {VALUE}" || {
  echo "Movement failed, returning home..."
  ssh pi@{HOST} "robot-cli home"
}
```

## Timestamped Iteration Loop
```bash
for i in {1..10}; do
  echo "=== Iteration $i - $(date -Iseconds) ===" | tee -a log.txt
  ssh pi@{HOST} "robot-cli {COMMAND}"
done
```

**Note**: Adapt command syntax (`robot-cli`, `arm`, etc.) to match the user's specific robot arm control interface.
