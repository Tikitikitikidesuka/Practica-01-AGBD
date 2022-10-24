SHOW VARIABLES LIKE 'secure_file_priv';

# Si la variable 'secure_file_priv' es NULL, no se pueden exportar los datos. Para arreglar el problema:
# editar el fichero '/etc/mysql/my.cnf' la linea secure-file-prive = NULL, en vez de NULL, poner dos comillas dobles.
#
# Para acceder al entorno del contenedor docker MySQL: `docker exec -it mysql bash`

SELECT * FROM clientes INTO OUTFILE '/tmp/clientes.csv';

# El fichero se creará dentro del sistema de ficheros del contenedor docker.
# Para extraerlo: `docker cp mysql:/tmp/clientes.csv <destino>`
# Si el fichero se crea con privilegios root, se puede hacer un apaño rápido con:
# `sudo chmod 777 clientes.csv`
# Lo mismo con el resto