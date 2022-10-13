# Practica 01 AGDB

Repositorio de la primera práctica de la asignatura de administración y gestión de bases de datos.

---

## Creación del servidor MySQL

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

**( ͡° ͜ʖ ͡°) La contraseña está obviamente cambiada ¯\\\_(ツ)\_/¯**

---

## Inserción de los datos

La inserción de los datos desde ficheros tiene truco. Sin realizar algunos pasos previos, es muy probable que salte el siguiente error:

``` 
Error Code: 3948. Loading local data is disabled; this must be enabled on both the client and server sides
```

El primer paso para solucionar este problema es asegurarse de que el valor de la variable `local_infile` es `TRUE`. El valor se puede comprobar mediante la sentencia `SHOW GLOBAL VARIABLES LIKE 'local_infile';` aunque no es necesario comprobarlo, pues se puede establecer incondicionalmente como `TRUE` antes de realizar las operaciones de inserción.

Se cambia el valor de la variable introduciendo la linea `SET GLOBAL local_infile = TRUE;`.

Es importante acordarse de volver a establecer el valor a `FALSE` tras las inserciones. No hacerlo podría conllevar errores de seguridad para la base de datos.

El proceso completo sería:

```sql
# Permitir la inserción de datos desde ficheros
SET GLOBAL local_infile = TRUE;

# Operaciones de inserción
...
# Fin de  las operaciones de inserción

# Impedir la inserción de datos desde ficheros
SET GLOBAL local_infile = FALSE;
```

Tras esto sigue siendo posible que salte otro error distinto:

```
Error Code: 2068. LOAD DATA LOCAL INFILE file request rejected due to restrictions on access.
```

Si se accede al servidor con **MySQL Workbench** el problema se soluciona editando las propiedades de la conexión.

1. En la pagina de conexiones de MySQL Workbench se presiona click derecho sobre la conexión que se desea editar y se selecciona la opción "**Edit connection...**".
2. Dentro de la ventana que se abre, **Manage Server Connections**, se pincha en la pestaña **Advanced**.
3. En el cuadro de texto **Others** de la pestaña **Advanced** se introduce la siguiente linea al final: `OPT_LOCAL_INFILE=1`.

Este será el aspecto final de la ventana **Manage Server Connections** se ha realizado el proceso correctamente:

<p align="center">
  <img src="https://user-images.githubusercontent.com/68425553/194750333-02417ba3-0b71-47e1-9f61-161036064f87.png">
</p>

---

### Tareas Parte 1

- [X] Script de creación de la base de datos PracABD1
- [X] Script de eliminación de la base de datos PracABD1

- [X] Script de creacion de los espacios físicos (datafiles) y lógicos (tablespaces) de la BD
- [X] Script de eliminación de los espacios físicos (datafiles) y lógicos (tablespaces) de la BD

- [X] Script de creación de las tablas de la BD en los espacios lógicos definidos anteriormente
- [X] Script de eliminación de las tablas de la BD

- [X] Script de carga de los datos del juego de datos

- [X] Script de creación de las claves primarias de cada tabla
- [X] Script de creación de las claves foráneas
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

--- 

## Comentarle a Dani

1. Longitud de los títulos de los juegos no caben en 32 carácteres. Ejemplo: "Wagamama Fairy Mirumo de Pon! - Ougon Maracas no Densetsu"
2. Colisiones por títulos repetidos de juegos, a pesar de que tienen editores distintos. Ejemplo: "Super Mario Advance 4 - Super Mario Bros. 3" que aparece cuatro veces con los editores: "Menace", "Independent", "Indecline" y "Trashman".
