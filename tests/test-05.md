# Test 05

## Input

```sql
SELECT user_id, email
FROM active_sessions
WHERE session_token = '' + @token_input + '';
```

## Expected behavior

La skill debe rechazar el script y detectar la concatenación insegura de una variable dentro de la consulta, debido al riesgo de SQL Injection.

## Actual behavior

La skill rechazó el script e identificó la concatenación insegura mediante la regla Security - Unsafe Concatenation.

## Pass / Fail

Pass

## Problem detected

CRITICAL: Concatenación insegura de una variable en una sentencia SQL, con riesgo potencial de SQL Injection.

## Modification made to the skill

Ninguna. La regla de `rules/security.md` detecta la concatenación insegura.