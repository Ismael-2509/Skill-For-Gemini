# SQL Reviewer

## Purpose

Actuar como una skill reutilizable de revisión técnica de SQL.

Su responsabilidad es analizar sentencias y scripts SQL para identificar
problemas de seguridad, rendimiento, tipos de datos, nomenclatura y
operaciones potencialmente destructivas.

La skill debe aplicar reglas deterministas siempre que exista información
suficiente. Cuando una conclusión dependa de información que no fue
proporcionada, debe indicarlo explícitamente y no inventar contexto.

---

## When to activate

La skill debe activarse cuando:

- La entrada contiene código SQL.
- El usuario proporciona una sentencia o script `.sql`.
- El usuario solicita revisar, auditar, analizar u optimizar SQL.
- La entrada contiene operaciones SQL como `SELECT`, `INSERT`, `UPDATE`,
  `DELETE`, `MERGE`, `CREATE`, `DROP`, `ALTER` o `TRUNCATE`.

---

## When NOT to activate

La skill no debe activarse como revisora SQL cuando:

- El usuario proporciona únicamente código de JavaScript, Python, Java,
  React u otro lenguaje sin SQL explícito.
- El usuario utiliza exclusivamente bases de datos NoSQL como MongoDB,
  Redis o Firebase.
- El usuario solicita crear una consulta SQL desde cero sin proporcionar
  SQL para revisar.
- El usuario solicita modelado conceptual o diagramas ER sin proporcionar
  DDL o SQL relacionado.
- No existe ningún fragmento SQL que pueda analizarse.

En estos casos debe indicar que la entrada está fuera del alcance de
`sql-reviewer`.

---

## Inputs

### sql_payload

**Obligatorio.**

Cadena que contiene la sentencia o script SQL que será analizado.

### db_engine

**Opcional.**

Motor de base de datos utilizado:

- PostgreSQL
- MySQL
- SQL Server
- Oracle
- SQLite

Si no se proporciona, utilizar ANSI SQL como referencia y marcar las
reglas dependientes del motor como potenciales cuando sea necesario.

### schema_context

**Opcional.**

Información adicional sobre:

- Tablas.
- Columnas.
- Tipos de datos.
- Llaves primarias.
- Llaves foráneas.
- Índices.
- Restricciones.

Cuando no se proporciona, la skill no debe inventar esta información.

---

## Procedure

La skill debe ejecutar las siguientes fases en orden.

### 1. Aislamiento

Extraer el código SQL relevante e ignorar explicaciones en lenguaje natural
que no formen parte de la consulta.

### 2. Clasificación

Identificar las operaciones presentes:

- DML
- DDL
- DCL
- TCL

### 3. Security

Aplicar todas las reglas definidas en:

`rules/security.md`

Se deben revisar especialmente:

- UPDATE sin WHERE.
- DELETE sin WHERE.
- WHERE tautológico.
- Concatenación insegura.
- DROP.
- TRUNCATE.
- Operaciones destructivas.

Una cláusula `WHERE` no debe considerarse automáticamente segura.

Por ejemplo:

```sql
DELETE FROM users WHERE 1 = 1;