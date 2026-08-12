# Test 01

## Input

```sql
SELECT product_id, product_name, current_stock
FROM inventory_catalog
WHERE current_stock < 15
LIMIT 20;
```

## Expected behavior

La skill debe aprobar el script (PASSED) sin reportar violaciones, ya que enumera las columnas explícitamente, utiliza una cláusula WHERE válida y limita los resultados mediante LIMIT.

## Actual behavior

La skill reportó un estado PASSED y no generó falsas alarmas.

## Pass / Fail

Pass

## Problem detected

Ninguno.

## Modification made to the skill

Ninguna. La skill manejó correctamente el caso válido.