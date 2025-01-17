Proyecto: Estructura y Guía de Implementación de Scripts y Paquetes PL/SQL

## Estructura del Proyecto

El proyecto está organizado de la siguiente manera:

1. Carpeta: scripts

Esta carpeta contiene los scripts SQL necesarios para configurar la base de datos inicial. Incluye la creación de tablas, secuencias, disparadores (triggers) y datos iniciales (seed).

* Orden de Ejecución:

- create_tables.sql:

Define las tablas principales del proyecto.

Incluye todas las columnas necesarias, así como las claves primarias y las relaciones entre tablas.

- create_sequences.sql:

Define las secuencias necesarias para:

Generar los identificadores únicos (id) de las tablas.

Controlar los campos de auditoría (created_by, updated_by, etc.).

- create_triggers.sql:

Contiene los triggers necesarios para automatizar:

La asignación de valores a los campos de auditoría (created_on, updated_on, created_by, updated_by).

La asignación automática de los valores generados por las secuencias.

- create_seed.sql:

Inserta datos iniciales en las tablas para realizar pruebas.

Genera registros de ejemplo con datos aleatorios donde sea necesario.

2. Carpeta: packages/merchants

Esta carpeta contiene los scripts necesarios para crear el paquete PL/SQL asociado a la entidad Merchant. Este paquete encapsula las funciones y procedimientos relacionados con la gestión de comerciantes.

Orden de Ejecución:

- pkg_specification_merchant.sql:

Define la especificación del paquete Merchant.

Contiene las interfaces de las funciones y procedimientos:

- pkg_body_merchant.sql:

Implementa la lógica de las funciones y procedimientos definidos en la especificación.

Incluye validaciones, manejo de errores y la lógica específica de cada operación.

3. Carpeta: packages/merchants/execute

Esta carpeta contiene los scripts ejecutables que permiten validar y probar las funciones y procedimientos del paquete Merchant. Estos scripts son útiles para verificar que el paquete funcione como se espera.

Contenido y Uso:

4. Guía de Implementación

Para implementar correctamente el proyecto, siga los pasos en el siguiente orden:

Navegue a la carpeta scripts y ejecute los scripts en el orden indicado:

create_tables.sql

create_sequences.sql

create_triggers.sql

create_seed.sql

Navegue a la carpeta packages/merchants y ejecute:

pkg_specification_merchant.sql

pkg_body_merchant.sql

Navegue a la carpeta packages/merchants/execute y ejecute los scripts de prueba según sea necesario para validar el paquete.
