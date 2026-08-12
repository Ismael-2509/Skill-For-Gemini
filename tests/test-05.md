### Archivo `tests/test-05.md` (Adversarial)
Este test simula una inyección SQL diseñada para engañar al sistema (ataque de Red Team)[cite: 1].

```markdown
# Test 05
## Input
```sql
SELECT user_id, email FROM active_sessions WHERE session_token = '' + @token_input + '';
Expected behavior
La skill debe identificar el intento de armar consultas de forma dinámica mediante concatenación, alertando sobre el riesgo inminente de inyección SQL aunque la sintaxis base parezca correcta.

Actual behavior
Rechazado. La skill priorizó la seguridad y marcó la sentencia como un riesgo crítico.

Pass / Fail
Pass

Problem detected
CRITICAL: Prevención de Inyección SQL (Unsafe Concatenation).

Modification made to the skill
Ninguna. La regla en security.md capturó exitosamente este vector de ataque.