-- Caso 1: DELETE con condición tautológica
DELETE FROM users WHERE 1 = 1;

-- Caso 2: DROP sin transacción
DROP TABLE customer_accounts;

-- Caso 3: TRUNCATE sin transacción
TRUNCATE TABLE audit_logs;