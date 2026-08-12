# Módulo de Reglas: Security

Este documento define las reglas de validación deterministas relacionadas
con la seguridad y la integridad estructural de los datos. La skill
`sql-reviewer` debe evaluar estrictamente el `sql_payload` contra estos
criterios.

## 1. DML sin filtros de alcance (Missing WHERE)

**Descripción:** Operaciones de actualización o borrado masivo sin una
condición explícita.

**Condición de Activación:** El bloque de código contiene una sentencia
`UPDATE` o `DELETE` y carece de la cláusula `WHERE`.

**Excepciones:** Ninguna.

**Severidad:** `CRITICAL`

**Mensaje de Error:**  
"Operación destructiva detectada. Falta la cláusula WHERE, lo que afectará
a todos los registros de la tabla."

---

## 2. Prevención de Inyección SQL (Unsafe Concatenation)

**Descripción:** Uso de operadores de concatenación con posibles variables
no sanitizadas.

**Condición de Activación:** Se detecta el uso de `+` o `||` junto a
comillas simples `''` en cláusulas `WHERE`, `INSERT` o `VALUES`, sugiriendo
que se están armando consultas de forma dinámica y manual.

**Excepciones:** El uso de funciones seguras como `CONCAT()` o parámetros
preparados como `$1` o `?`.

**Severidad:** `CRITICAL`

**Mensaje de Error:**  
"Riesgo inminente de Inyección SQL. Evite concatenar cadenas manualmente;
utilice consultas parametrizadas o prepared statements."

---

## 3. Tautologías en condiciones (Tautological WHERE)

**Descripción:** Cláusulas que siempre evalúan a verdadero, comúnmente usadas
para evadir filtros o en inyecciones SQL básicas.

**Condición de Activación:** La cláusula `WHERE` contiene expresiones como
`1=1`, `'a'='a'` o `TRUE`.

**Excepciones:** Ninguna en entornos de producción.

**Severidad:** `HIGH`

**Mensaje de Error:**  
"Condición tautológica detectada. Esto anula el propósito del filtro y
puede ser un vector de ataque."

---

## 4. Operaciones Destructivas DDL (Unsafe DROP/TRUNCATE)

**Descripción:** Borrado de estructuras completas sin un marco de
transacción de seguridad.

**Condición de Activación:** El script ejecuta comandos `DROP TABLE`,
`DROP DATABASE` o `TRUNCATE TABLE` y no se encuentra dentro de un bloque
`BEGIN ... COMMIT` / `ROLLBACK`.

**Excepciones:** Scripts explícitamente marcados como migraciones iniciales
(`DOWN migrations`).

**Severidad:** `HIGH`

**Mensaje de Error:**  
"Operación estructural destructiva sin control transaccional. Envuélvala
en un bloque de transacción para prevenir pérdidas irrecuperables por
errores de ejecución."