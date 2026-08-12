# SQL Reviewer Skill

## Descripción del Proyecto
Este repositorio contiene la ingeniería y desarrollo de la skill `sql-reviewer`, construida para actuar como un revisor técnico automatizado de bases de datos. Su responsabilidad es analizar sentencias y scripts SQL para detectar vulnerabilidades, problemas de rendimiento y violaciones de convenciones.

Este proyecto forma parte de la Actividad: Ingeniería y Desarrollo de una Skill para IA.

## Estructura del Repositorio
* **`SKILL.md`**: Documento principal con la especificación, propósito, procedimiento y niveles de severidad de la skill.
* **`rules/`**: Módulos de reglas deterministas evaluadas por el sistema (`security.md`, `performance.md`, `conventions.md`).
* **`examples/`**: Scripts SQL de prueba utilizados para validar el comportamiento (`valid.sql`, `invalid.sql`, `edge-cases.sql`).
* **`tests/`**: Documentación de los casos de prueba ejecutados frente al motor de IA, incluyendo análisis de casos límite y adversarial.

## Uso y Activación
La skill se activa automáticamente al proporcionar sentencias SQL. Evaluará el código y emitirá un reporte estructurado clasificando cada hallazgo bajo los niveles: `CRITICAL`, `HIGH`, `MEDIUM`, `LOW` o `INFO`. No intentará adivinar contextos inexistentes ni generar bases de datos desde cero.