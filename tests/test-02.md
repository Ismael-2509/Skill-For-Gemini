# Test 02

## Input

```sql
UPDATE orders
SET order_status = 'DELIVERED';

SELECT *
FROM audit_logs;
```

## Expected behavior

La skill debe rechazar el script. Debe detectar el UPDATE sin cláusula WHERE como un problema CRITICAL y el uso de SELECT * como un problema MEDIUM.

## Actual behavior

La skill rechazó el script e identificó ambas violaciones mediante las reglas de Security y Performance.

## Pass / Fail

Pass

## Problem detected

CRITICAL: UPDATE sin cláusula WHERE (Missing WHERE).

MEDIUM: Uso de SELECT * (Escaneo Masivo).

## Modification made to the skill

Ninguna. Las reglas existentes de security.md y performance.md detectaron correctamente las violaciones.