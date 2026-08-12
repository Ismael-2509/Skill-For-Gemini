SELECT 
    product_id, 
    product_name, 
    current_stock, 
    supplier_code
FROM inventory_catalog
WHERE current_stock < 15 
  AND is_discontinued = FALSE
  AND category_name = 'Accessories'
ORDER BY current_stock ASC
LIMIT 20;