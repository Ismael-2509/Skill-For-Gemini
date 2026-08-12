### Archivo `tests/test-03.md` (Edge Case)
Este test introduce un caso que superficialmente tiene un `WHERE`, pero esconde un problema grave[cite: 1].

# Test 03
## Input
```sql
DELETE FROM customer_accounts WHERE 1=1;
Expected behavior
La skill debe detectar que, aunque existe la sintaxis WHERE, la condición 1=1 es una tautología que causará el borrado total de la tabla, marcándolo como HIGH/CRITICAL.

Actual behavior
Rechazado. El analizador ignoró el falso sentido de seguridad del WHERE y detonó la alerta de tautología.

Pass / Fail
Pass

Problem detected
HIGH: Tautologías en condiciones (Tautological WHERE).
HIGH: Prevención de Borrado Físico (Hard Deletes) detectado en una entidad crítica de clientes.

Modification made to the skill
Se agregó previamente a security.md la regla de "Tautologías en condiciones" para asegurar que la skill evalúe la lógica de la sentencia y no solo su sintaxis superficial.