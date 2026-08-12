# Módulo de Reglas: Conventions

Este documento establece los estándares de escritura, legibilidad y buenas
prácticas operativas. La skill `sql-reviewer` evaluará el código para
asegurar que sea mantenible y seguro a nivel lógico.

## 1. Nombres Poco Descriptivos (Poor Naming Conventions)

**Descripción:** Uso de identificadores ambiguos que dificultan la
comprensión del modelo de datos.

**Condición de Activación:** Se detectan alias, nombres de tablas o columnas
con una o dos letras (ej. `t1`, `a`), o nombres genéricos sin contexto
(ej. `data`, `valor`, `tabla`).

**Excepciones:** Contadores de iteración en procedimientos almacenados o
variables espaciales comunes (`x`, `y`).

**Severidad:** `INFO`

**Mensaje de Error:**

"Nomenclatura deficiente. Utilice nombres descriptivos para tablas y
columnas que reflejen claramente la entidad o dato que representan."

---

## 2. Uso Incorrecto de NULL (Invalid NULL Comparison)

**Descripción:** Comparación directa con el valor `NULL` usando operadores
de igualdad matemática.

**Condición de Activación:** La consulta utiliza `= NULL` o `!= NULL` en
lugar de los operadores estándar.

**Excepciones:** Ninguna.

**Severidad:** `MEDIUM`

**Mensaje de Error:**

"Sintaxis SQL incorrecta para valores nulos. Utilice 'IS NULL' o
'IS NOT NULL' para evaluar la ausencia de datos."

---

## 3. Prevención de Borrado Físico (Hard Deletes)

**Descripción:** Borrado directo de registros en tablas que representan
entidades de negocio críticas, donde se requiere trazabilidad.

**Condición de Activación:** Se detecta una sentencia `DELETE` aplicada
sobre tablas cuyos nombres sugieran entidades principales
(ej. `users`, `empleados`, `tickets`, `tasks`, `logs`).

**Excepciones:** Tablas temporales o tablas de relación (tablas pivote).

**Severidad:** `HIGH`

**Mensaje de Error:**

"Borrado físico (Hard Delete) detectado en una entidad crítica. Se
recomienda encarecidamente implementar un borrado lógico (Soft Delete)
actualizando un campo de estado (ej. 'is_active = FALSE') para mantener
la integridad histórica."