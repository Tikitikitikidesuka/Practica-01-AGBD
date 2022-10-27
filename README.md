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
- [X] Script de borrado de las claves foráneas de las tablas
- [X] Script de borrado de las claves primarias de las tablas

- [X]  Justificación empírirca y razonada sobre la influencia de la creación de índices antes o después de hacer la carga de los datos
    - [X] Medición del tiempo de ejecución de los scripts **creando los índices antes de la carga**: T = 2.4412 s
        1. Creación de la base de datos
        2. Creación de los espacios
        3. Creación de las tablas
        4. Creación de las claves primarias               (creación de índices)     T = 259.24 ms
        5. Creación de las claves foráneas                (creación de índices)     T = 178.14 ms
        6. Inserción de los datos del juego de datos      (inserción)               T = 2.0038 s
    - [X] Medición del tiempo de ejecución de los scripts **cargando los datos antes de la creación de los índices**: T = 8.5519 s
        1. Creación de la base de datos
        2. Creación de los espacios
        3. Creación de las tablas
        4. Inserción de los datos del juego de datos      (inserción)               T = 1.6264 s
        5. Creación de las claves primarias               (creación de índices)     T = 6.6568 s
        6. Creación de las claves foráneas                (creación de índices)     T = 268.76 ms

    **Explicación razonada**:
    
     Si primero se ponen las claves y se crean sus índices, cada vez que se introduzca un dato se comprueba si cumple las restricciones y dado que ya existe un índice de las claves, se puede hacer mucho más rápidamente que comprobando que la clave es única fila a fila.
     Si se introdujesen los datos primero y luego se insertasen las claves, crear sus índices sería una tarea muchísimo más costosa, como se puede ver por los tiempos obtenidos.
     
### Tareas Parte 2
- [X] Crear las siguientes consultas:
    - [X] Obtener el correo de un cliente a partir de su nombre y sus apellidos. Probar la consulta con "Ángeles del Nido".
    - [X] Obtener el número de clientes de una provincia. Probar la consulta con "Lugo".
    - [X] Obtener un listado con el nombre, los apellidos y el correo electrónico de los clientes que hayan contactado por un determinado canal en un determinado periodo de tiempo. Probar la consulta con "canal web" y el periodo de "2019".
    - [X] Obtener un listado de clientes que contenga el nombre, los apellidos y los juegos que hayan alquilado entre los años 2019 y 2020, así como la fecha de alquiler de cada juego. El listado resultante se desea ordenado por apellidos y que solo contenga clientes de una determinada provincia. Probar la consulta con los clientes de "Madrid".
    - [X] Dos consultas que puedan ser de interés para la empresa y con las que se pueda extraer alguna conclusión de interés relativa al uso de índices.

- [ ] Optimizar las consultas anteriores:
    - [X] Eliminar las claves primarias y foráneas y obtener los tiempos de ejecución de las consultas.         T = 246.918 ms
        1. T = 26.672 ms
        2. T = 14.731 ms
        3. T = 23.737 ms
        4. T = 56.779 ms
        5. T = 49.494 ms
        6. T = 75.505 ms
    - [X] Añadir las claves primarias y obtener los tiempos de ejecución de las consultas.                      T = 232.843 ms
        1. T = 43.996 ms
        2. T = 17.417 ms
        3. T = 27.835 ms
        4. T = 42.950 ms
        5. T = 41.608 ms
        6. T = 59.037 ms
    - [X] Añadir las claves primarias y foráneas y obtener los tiempos de ejecución de las consultas.           T = 213.057 ms
        1. T = 22.188 ms
        2. T = 17.107 ms
        3. T = 24.291 ms
        4. T = 50.475 ms
        5. T = 34.668 ms
        6. T = 64.328 ms
    - [X] Crear los índices oportunos para optimizar las consultas y obtener los tiempos de ejecución de las consultas según se especifica en la tabla del enunciado.
        1. Índice Nombre cliente: T = 210.56 ms
        2. Índice Apellido cliente: T = 178.49 ms
        3. Índice Título juego. T = 212.67 ms
        4. Todos los índices: T = 170.73 ms
    - [X] Indicar que conjunto de índices final es el más apropiado para la base de datos teniendo en cuenta que las consultas más frecuentes van a ser la 1, 4, 2 y la 3.
        Todos los índices activados producen la mejor velocidad teniendo solo en cuenta las consultas más frecuentes.
    - [ ] Añadir unas conclusiones sobre el estudio de los índices.

--- 

## Problemas

- [X] Longitud de los títulos de los juegos no caben en 32 carácteres. Ejemplo: "Wagamama Fairy Mirumo de Pon! - Ougon Maracas no Densetsu" -> **Solución**: Aumentar el tamaño de las strings a más de 32 carácteres.
- [X] Colisiones por títulos repetidos de juegos, a pesar de que tienen editores distintos. Ejemplo: "Super Mario Advance 4 - Super Mario Bros. 3" que aparece cuatro veces con los editores: "Menace", "Independent", "Indecline" y "Trashman" -> **Solución propuesta**: Añadir al final de los títulos de los juegos repetidos el nombre de la compañía.
- [X] Colisiones por títulos repetidos de juegos que no tienen editores, por lo que no se puede resolver igual que el problema anterior. -> **Solución propuesta**: Ya que las filas son idénticas excepto el id, eliminar los juegos duplicados y actualizar la tabla clientes_juegos para que usen el id de la versión no eliminada.
- [X] Permiso denegado en XAMPP -> **Solución**: Ir al fichero `C:\xampp\phpMyAdmin\config.inc.php` y actualizar la fila con la ip, para incluir el puerto que se ha configurado en el servidor MySQL.
- [X] No deja iniciar el MySQL del phpMyAdmin tras cambiar los tamaños de página y expandir el tamaño de la base de datos -> **Solución**: Ir a la carpeta `C:\xampp\mysql\data` y eliminar todos los archivos menos el directorio mysql y el fichero my.ini.
- [ ] Volver a realizar el backup de la base de datos (datos filtrados e índices implementados).
