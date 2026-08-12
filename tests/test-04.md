### Archivo `tests/test-04.md` (Información Insuficiente)
Este test asegura que la IA reconozca sus límites y no invente datos[cite: 1].

# Test 04
## Input
```sql
SELECT calculate_annual_taxes(total_amount) FROM sales_records LIMIT 50;
Expected behavior
La skill debe reconocer que calculate_annual_taxes es una función personalizada cuyo esquema y costo computacional desconoce, emitiendo una advertencia en lugar de adivinar su impacto.

Actual behavior
La skill declaró que carece de contexto (DDL) para auditar el interior de la función almacenada.

Pass / Fail
Pass

Problem detected
Información insuficiente para validar el impacto en rendimiento de la función invocada.

Modification made to the skill
Se blindó el archivo SKILL.md añadiendo la directiva "Restricción de Alucinación" en la sección de Failure handling para forzar este comportamiento.