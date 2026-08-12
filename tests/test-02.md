### Archivo `tests/test-02.md` (Error Evidente)
Este test evalúa una entrada con múltiples violaciones claras[cite: 1].

```markdown
# Test 02
## Input
```sql
UPDATE orders SET order_status = 'DELIVERED';
SELECT * FROM audit_logs;
Expected behavior
La skill debe rechazar el script asignando un nivel CRITICAL por el UPDATE sin cláusula WHERE, y un nivel MEDIUM por el uso no óptimo de SELECT *.

Actual behavior
Rechazado. La skill identificó ambas violaciones aplicando las reglas de security.md y performance.md.

Pass / Fail
Pass

Problem detected
CRITICAL: DML sin filtros de alcance (Missing WHERE).

MEDIUM: Escaneo Masivo (Uso de SELECT *).

Modification made to the skill
Ninguna. El motor de reglas reaccionó determinísticamente ante las fallas.