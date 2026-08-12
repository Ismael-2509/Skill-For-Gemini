# SQL Reviewer Skill

## Descripción del Proyecto

`sql-reviewer` es una skill reutilizable para la revisión técnica de código SQL. Su objetivo es analizar sentencias y scripts SQL para detectar problemas de seguridad, rendimiento, convenciones y operaciones potencialmente destructivas.

Este proyecto forma parte de la actividad **Ingeniería y Desarrollo de una Skill para IA**.

La skill utiliza reglas deterministas y evita inventar información cuando no existe suficiente contexto para confirmar un hallazgo.

---

## Objetivo

La skill busca proporcionar una revisión consistente de código SQL mediante:

* Detección de vulnerabilidades de seguridad.
* Identificación de problemas potenciales de rendimiento.
* Validación de convenciones SQL.
* Detección de operaciones destructivas.
* Manejo explícito de información insuficiente.
* Clasificación de hallazgos mediante niveles de severidad.

---

## Estructura del Repositorio

```text
Skill-For-Gemini/
│
├── README.md
├── SKILL.md
│
├── examples/
│   ├── valid.sql
│   ├── invalid.sql
│   └── edge-cases.sql
│
├── rules/
│   ├── security.md
│   ├── performance.md
│   └── conventions.md
│
└── tests/
    ├── test-01.md
    ├── test-02.md
    ├── test-03.md
    ├── test-04.md
    ├── test-05.md
    └── test-adversarial.sql
```

---

## Módulos de Reglas

### Security

Archivo: `rules/security.md`

Incluye reglas para detectar:

* `UPDATE` sin `WHERE`.
* `DELETE` sin `WHERE`.
* Condiciones tautológicas como `WHERE 1 = 1`.
* Concatenación insegura de variables.
* `DROP TABLE`, `DROP DATABASE` y `TRUNCATE` sin control transaccional.

### Performance

Archivo: `rules/performance.md`

Incluye:

* Uso de `SELECT *`.
* Ausencia potencial de `LIMIT`, `TOP` o `FETCH NEXT`.
* Leading wildcards en `LIKE` o `ILIKE`.
* Posibles conversiones implícitas de tipos.
* Índices potencialmente faltantes.

La skill no afirma que un índice falte ni que una consulta sea lenta cuando no existe información suficiente para demostrarlo.

### Conventions

Archivo: `rules/conventions.md`

Incluye:

* Nombres poco descriptivos.
* Comparaciones incorrectas con `NULL`.
* Detección de hard deletes en entidades críticas.

---

## Entradas

La skill acepta:

* Código SQL.
* Scripts `.sql`.
* Solicitudes para revisar, auditar o analizar SQL.

También puede recibir información adicional como:

* Motor de base de datos.
* Tablas.
* Columnas.
* Tipos de datos.
* Índices.
* Restricciones.
* Llaves primarias y foráneas.

Cuando esta información no está disponible, la skill no debe inventarla.

---

## Motores Soportados

La especificación contempla:

* PostgreSQL
* MySQL
* SQL Server
* Oracle
* SQLite

Si no se especifica el motor, se utiliza **ANSI SQL** como referencia y las reglas dependientes del motor se presentan como potenciales cuando corresponda.

---

## Niveles de Severidad

Los hallazgos utilizan cinco niveles:

```text
CRITICAL > HIGH > MEDIUM > LOW > INFO
```

El estado general del script utiliza la severidad más alta encontrada.

* **CRITICAL:** riesgo grave de seguridad o modificación destructiva sin control.
* **HIGH:** riesgo importante de seguridad, integridad o rendimiento.
* **MEDIUM:** problema relevante que debe corregirse.
* **LOW:** problema de menor impacto.
* **INFO:** recomendación o posible mejora.

---

## Manejo de Información Insuficiente

La skill tiene una restricción explícita contra las alucinaciones.

Cuando no existe información suficiente para confirmar un problema:

1. No inventa datos.
2. No afirma que el problema está confirmado.
3. Clasifica el hallazgo como potencial o no determinable.
4. Indica qué información adicional permitiría confirmarlo.

Por ejemplo, si no se proporciona el esquema de índices, la skill no afirma que un índice falta. Recomienda verificarlo mediante `EXPLAIN` o la herramienta equivalente del motor.

---

## Proceso de Revisión

La skill ejecuta las siguientes fases:

1. **Aislamiento:** identifica el código SQL relevante.
2. **Clasificación:** identifica las operaciones DML, DDL, DCL y TCL.
3. **Security:** aplica las reglas de seguridad.
4. **Performance:** aplica las reglas de rendimiento.
5. **Conventions:** aplica las reglas de convenciones.
6. **Resolución de severidad:** determina el nivel máximo encontrado.
7. **Validación de contexto:** evita conclusiones no demostrables.
8. **Emisión:** genera un reporte estructurado.

---

## Pruebas

La skill cuenta con cinco casos principales:

| Test    | Caso                     | Objetivo                                            |
| ------- | ------------------------ | --------------------------------------------------- |
| Test 01 | Happy Path               | Confirmar que SQL válido no genere falsos positivos |
| Test 02 | Error evidente           | Detectar múltiples violaciones                      |
| Test 03 | Edge Case                | Detectar un `WHERE` que no restringe realmente      |
| Test 04 | Información insuficiente | Evitar inventar información                         |
| Test 05 | Adversarial              | Detectar una posible inyección SQL                  |

Además, `tests/test-adversarial.sql` contiene casos adicionales de operaciones destructivas como `DELETE ... WHERE 1=1`, `DROP TABLE` y `TRUNCATE TABLE`.

### Resultados

Los cinco casos fueron revisados y documentados como:

```text
Test 01 → PASS
Test 02 → PASS
Test 03 → PASS
Test 04 → PASS
Test 05 → PASS
```

---

## Ejemplos

La carpeta `examples/` contiene:

* `valid.sql`: consulta válida utilizada como Happy Path.
* `invalid.sql`: conjunto de consultas con violaciones conocidas.
* `edge-cases.sql`: consultas diseñadas para comprobar casos límite.

---

## Limitaciones

La skill:

* No ejecuta consultas SQL.
* No modifica bases de datos.
* No crea bases de datos.
* No inventa esquemas.
* No inventa índices.
* No inventa tipos de datos.
* No puede confirmar problemas que requieran información no proporcionada.
* No genera SQL desde cero cuando no existe SQL para revisar.

---

## Formato de Salida

El resultado esperado utiliza un reporte estructurado:

```markdown
# SQL Reviewer Report

**Status:** [REJECTED | PASSED]
**Engine Assumed:** [Motor detectado o ANSI SQL]

---

### Findings

#### [Nivel de Severidad]
* **Problem:** [Descripción]
* **Rule Violated:** [Regla]
* **Snippet:** `[Código relacionado]`
* **Recommendation:** [Corrección recomendada]

---

### Final Recommendation

[Recomendación final]
```

---

## Conclusión

`sql-reviewer` está diseñado como una skill reutilizable, determinista y orientada a la revisión técnica de SQL. Su diseño prioriza la seguridad, el rendimiento, la mantenibilidad y, especialmente, la capacidad de reconocer cuándo no existe información suficiente para emitir una conclusión.
