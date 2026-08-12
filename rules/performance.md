# Módulo de Reglas: Performance

Este documento define las reglas de validación orientadas a la optimización
de recursos, tiempos de respuesta y carga del motor de base de datos. La
skill `sql-reviewer` aplicará estas reglas para prevenir cuellos de botella.

## 1. Escaneo Masivo (Uso de SELECT *)

**Descripción:** Solicitar todas las columnas de una o varias tablas sin
necesidad explícita.

**Condición de Activación:** Se detecta la instrucción `SELECT *` en la
consulta.

**Excepciones:** Consultas que utilicen funciones de agregación como
`SELECT COUNT(*)`.

**Severidad:** `MEDIUM`

**Mensaje de Error:**

"Uso ineficiente de memoria y red. El uso de 'SELECT *' está prohibido en
producción; enumere explícitamente las columnas requeridas."

---

## 2. Ausencia de Paginación en Consultas Abiertas (Missing LIMIT)

**Descripción:** Consultas de selección sin filtros suficientemente
restrictivos y sin un límite definido, lo que puede retornar un volumen
elevado de registros.

**Condición de Activación:** Una sentencia `SELECT` carece de la cláusula
`LIMIT`, `TOP` o `FETCH NEXT` y no contiene un filtro que pueda identificarse
como suficientemente restrictivo a partir de la información disponible.

**Excepciones:** Subconsultas utilizadas dentro de `EXISTS` o `IN`.
Consultas agregadas que no retornan directamente grandes conjuntos de filas.

**Severidad:** `MEDIUM`

**Mensaje de Error:**

"Riesgo de sobrecarga de memoria. Implemente una cláusula LIMIT, TOP o
FETCH NEXT cuando el caso de uso no requiera recuperar todas las filas."

**Nota:** La skill no debe afirmar que una consulta devolverá millones de
registros si no dispone de información sobre el volumen de datos.

---

## 3. Invalidación de Índices por Comodines (Leading Wildcards)

**Descripción:** Uso de comodines al inicio de una cadena en búsquedas, lo
que puede impedir el uso eficiente de índices B-Tree convencionales.

**Condición de Activación:** La cláusula `WHERE` contiene un operador `LIKE`
o `ILIKE` cuyo patrón de búsqueda comienza con `%` o `_`, por ejemplo:

`LIKE '%termino'`

o:

`LIKE '%termino%'`

**Excepciones:** Ninguna.

**Severidad:** `HIGH`

**Mensaje de Error:**

"Rendimiento degradado. El uso de un comodín al inicio de un LIKE puede
impedir que el motor utilice índices B-Tree convencionales y provocar un
escaneo amplio."

---

## 4. Problemas Evidentes en Tipos de Datos (Implicit Type Casting)

**Descripción:** Comparaciones entre tipos de datos incompatibles que pueden
provocar conversiones implícitas y afectar el uso eficiente de índices.

**Condición de Activación:** Se detecta una comparación en `WHERE` entre un
valor cuyo tipo aparente no coincide con el tipo conocido o explícitamente
definido de la columna.

**Excepciones:** Conversiones explícitas autorizadas mediante `CAST` o
`CONVERT`.

**Severidad:** `LOW`

**Mensaje de Error:**

"Posible conversión implícita de tipos. Asegúrese de que los valores
comparados coincidan con el tipo de dato de la columna para evitar
conversiones innecesarias y posibles problemas de rendimiento."

**Nota:** Si no se conoce el tipo de la columna, la skill no debe afirmar
que existe una conversión implícita. Debe clasificarlo como no determinable
o solicitar el esquema.

---

## 5. Índices Potencialmente Faltantes

**Descripción:** Uso de columnas en filtros, uniones u ordenamientos que
podrían beneficiarse de un índice.

**Condición de Activación:** Se detectan columnas utilizadas en cláusulas
`WHERE`, `JOIN ... ON` u `ORDER BY` que podrían beneficiarse de indexación.

**Excepciones:** Si se proporciona información que demuestra que ya existe
un índice adecuado. También puede omitirse cuando el contexto indique que
la tabla tiene un volumen trivial de datos.

**Severidad:** `INFO`

**Mensaje de Error:**

"Revisión recomendada: Verifique que las columnas utilizadas en las
cláusulas WHERE, JOIN u ORDER BY posean índices adecuados para optimizar el
plan de ejecución."

**Nota:** La skill no debe afirmar que un índice falta sin disponer del
esquema de índices o del plan de ejecución. En ausencia de esta información,
el hallazgo debe considerarse potencial y debe recomendarse verificarlo
mediante `EXPLAIN` o la herramienta equivalente del motor.

---

## Regla general de rendimiento

La skill no debe inventar información sobre el volumen de datos, índices,
tipos de columnas o planes de ejecución.

Cuando la información disponible no permita confirmar un problema de
rendimiento, el hallazgo debe presentarse como potencial y debe indicarse
qué información adicional sería necesaria para confirmarlo.