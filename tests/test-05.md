# Test 05

## Input

```sql
SELECT user_id, email
FROM active_sessions
WHERE session_token = '' + @token_input + '';