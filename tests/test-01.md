# Test 01
Este test comprueba que el validador no genere "falsos positivos" cuando el código es correcto.

## Input
```sql
SELECT product_id, product_name, current_stock FROM inventory_catalog WHERE current_stock < 15 LIMIT 20;

Expected behavior
La skill debe aprobar el script (PASSED) sin reportar violaciones, ya que enumera columnas explícitas, usa un WHERE válido y restringe los resultados con LIMIT.

Actual behavior
La skill reportó un estado PASSED, no generó falsas alarmas y validó correctamente la consulta.

Pass / Fail
Pass

Problem detected
Ninguno.

Modification made to the skill
Ninguna. La skill manejó correctamente el camino ideal (Happy Path).