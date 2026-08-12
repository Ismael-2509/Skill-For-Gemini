# Test 03

## Input

```sql
DELETE FROM customer_accounts
WHERE 1 = 1;
```

## Expected behavior

La skill debe rechazar el script y detectar que la condición `WHERE 1 = 1` es tautológica. También debe identificar el DELETE como una operación destructiva sobre una entidad crítica.

## Actual behavior

La skill rechazó el script e identificó la condición tautológica y el riesgo asociado al borrado físico.

## Pass / Fail

Pass

## Problem detected

HIGH: WHERE tautológico que puede provocar el borrado de todos los registros.

HIGH: Hard Delete sobre una entidad crítica de clientes.

## Modification made to the skill

La regla de Tautological WHERE fue incorporada en `rules/security.md` para evitar considerar segura una sentencia DELETE únicamente por contener una cláusula WHERE.