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

### 4. Performance

Aplicar todas las reglas definidas en:

`rules/performance.md`

Se deben revisar especialmente:

- SELECT *.
- Ausencia potencial de LIMIT, TOP o FETCH NEXT.
- Leading wildcards.
- Conversiones implícitas.
- Índices potencialmente faltantes.

La skill no debe afirmar la ausencia de índices ni problemas de volumen de
datos cuando no se proporciona el esquema o información suficiente.

### 5. Conventions

Aplicar todas las reglas definidas en:

`rules/conventions.md`

Se deben revisar especialmente:

- Nombres poco descriptivos.
- Comparaciones incorrectas con NULL.
- Hard deletes en entidades críticas.
- Otras convenciones definidas por el equipo.

### 6. Resolución de severidad

Si una sentencia viola varias reglas, todos los hallazgos deben reportarse.

El estado general del script debe utilizar la severidad más alta encontrada.

Orden de severidad:

`CRITICAL > HIGH > MEDIUM > LOW > INFO`

### 7. Información insuficiente

Si una regla requiere información que no está disponible, la skill:

1. No debe inventar datos.
2. No debe afirmar que el problema está confirmado.
3. Debe indicar que el hallazgo es potencial o no determinable.
4. Debe especificar qué información adicional permitiría confirmarlo.

Por ejemplo:

> No es posible confirmar la ausencia de un índice porque no se proporcionó
> el esquema de índices. Se recomienda verificar mediante EXPLAIN o la
> herramienta equivalente del motor.

### 8. Emisión

Generar el reporte utilizando exclusivamente el formato definido en
`Expected output`.

---

## Rules

La lógica de validación se divide en tres módulos:

### Security

Las reglas completas se encuentran en:

`rules/security.md`

Incluyen:

- Missing WHERE.
- Unsafe Concatenation.
- Tautological WHERE.
- Unsafe DROP/TRUNCATE.

### Performance

Las reglas completas se encuentran en:

`rules/performance.md`

Incluyen:

- SELECT *.
- Missing LIMIT.
- Leading Wildcards.
- Implicit Type Casting.
- Índices potencialmente faltantes.

### Conventions

Las reglas completas se encuentran en:

`rules/conventions.md`

Incluyen:

- Poor Naming Conventions.
- Invalid NULL Comparison.
- Hard Deletes.

---

## Scope limitations

La skill únicamente revisa SQL proporcionado por el usuario.

No debe:

- Ejecutar consultas.
- Modificar bases de datos.
- Crear bases de datos.
- Inventar esquemas.
- Inventar índices.
- Inventar tipos de datos.
- Generar SQL desde cero cuando no existe SQL para revisar.

Cuando sea necesario para confirmar un hallazgo, debe solicitar o recomendar
información adicional.

---

## Expected output

La skill debe responder utilizando únicamente esta plantilla en Markdown:

```markdown
# SQL Reviewer Report

**Status:** [REJECTED | PASSED]
**Engine Assumed:** [Motor detectado o ANSI SQL]

---

### Findings

#### [Nivel de Severidad]
* **Problem:** [Descripción técnica directa y concisa]
* **Rule Violated:** [Módulo y nombre de la regla]
* **Snippet:** `[Línea exacta del código SQL que provoca el hallazgo]`
* **Recommendation:** [Código SQL corregido o acción específica]

---

### Final Recommendation

[Máximo 2 líneas indicando si el script es apto para producción
o requiere refactorización.]