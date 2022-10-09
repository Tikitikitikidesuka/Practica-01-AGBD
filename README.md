# Practica 01 AGDB

Repositorio de la primera práctica de la asignatura de administración y gestión de bases de datos.

---

## Instrucciones

### Creación del servidor MySQL

Con **Docker** instalado, ejecutar:

```sh
docker run --name <NOMBRE_DEL_CONTENDOR>\
    -p <PUERTO_DE_ACCESO>:<PUERTO_DE_ACCESO>\
    -e MYSQL_ROOT_PASSWORD=<CONTRASEÑA_DEL_USUARIO_ROOT>\
    -d mysql:<VERSION_DE_MYSQL>
```

En nuestro caso en particular se ejecuta:

```sh
docker run --name mysql\
    -p 3306:3306\
    -e MYSQL_ROOT_PASSWORD=Keo\
    -d mysql:8.0.22
```

**La contraseña está obviamente cambiada ( ͡ ͡° ͜ ʖ ͡ ͡°)**

---

## Parte 1

### Tareas

- [X] Script de creación de la base de datos PracABD1
- [X] Script de eliminación de la base de datos PracABD1

- [X] Script de creacion de los espacios físicos (datafiles) y lógicos (tablespaces) de la BD
- [X] Script de eliminación de los espacios físicos (datafiles) y lógicos (tablespaces) de la BD

- [X] Script de creación de las tablas de la BD en los espacios lógicos definidos anteriormente
- [X] Script de eliminación de las tablas de la BD

- [ ] Script de carga de los datos del juego de datos

- [ ] Script de creación de las claves primarias de cada tabla
- [ ] Script de creación de las claves foráneas
- [ ] Script de borrado de las claves foráneas de las tablas
- [ ] Script de borrado de las claves primarias de las tablas

- [ ]  Justificación empírirca y razonada sobre la influencia de la creación de índices antes o después de hacer la carga de los datos
  - [ ] Medición del tiempo de ejecución de los scripts **creando los índices antes de la carga**:
    1. Creación de la base de datos
    2. Creación de los espacios
    3. Creación de las tablas
    4. Creación de las claves primarias               (creación de índices)
    5. Creación de las claves foráneas                (creación de índices)
    6. Inserción de los datos del juego de datos      (inserción)
  - [ ] Medición del tiempo de ejecución de los scripts **cargando los datos antes de la creación de los índices**:
    1. Creación de la base de datos
    2. Creación de los espacios
    3. Creación de las tablas
    4. Inserción de los datos del juego de datos      (inserción)
    5. Creación de las claves primarias               (creación de índices)
    6. Creación de las claves foráneas                (creación de índices)
