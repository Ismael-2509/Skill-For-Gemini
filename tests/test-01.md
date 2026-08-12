# Test 01

## Input

```sql
SELECT product_id, product_name, current_stock
FROM inventory_catalog
WHERE current_stock < 15
LIMIT 20;