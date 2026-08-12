# Test 04

## Input

```sql
SELECT calculate_annual_taxes(total_amount)
FROM sales_records
LIMIT 50;
```

## Expected behavior

La skill debe identificar que `calculate_annual_taxes` es una función cuyo comportamiento interno no puede evaluarse sin información adicional. No debe inventar su costo computacional ni afirmar que existe un problema confirmado.

## Actual behavior

La skill indicó que no existe suficiente información para evaluar el comportamiento interno de la función y clasificó cualquier impacto de rendimiento como potencial.

## Pass / Fail

Pass

## Problem detected

INFO: Información insuficiente para determinar el costo computacional de la función `calculate_annual_taxes`.

Para confirmar el impacto sería necesario proporcionar información sobre la definición de la función, su implementación o el plan de ejecución.

## Modification made to the skill

Se agregó en `SKILL.md` la regla de información insuficiente para impedir que la skill invente datos cuando no se proporciona el esquema o la implementación necesaria.