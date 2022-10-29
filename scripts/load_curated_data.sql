SET GLOBAL local_infile = TRUE;

LOAD DATA LOCAL INFILE 'directorio_datos/clientes.csv'
	INTO TABLE clientes
	CHARACTER SET utf8mb4
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	(@ClienteID, DNI, Nombre, Apellidos, Genero, Direccion, Localidad, Provincia, CodPostal, Telefono, Canal, @FechaNacimiento, @FechaContacto, Email)
	SET ClienteID = CAST(@ClienteID AS DECIMAL), FechaNacimiento = STR_TO_DATE(@FechaNacimiento, '%Y-%m-%d'), FechaContacto = STR_TO_DATE(@FechaContacto, '%Y-%m-%d');

LOAD DATA LOCAL INFILE 'directorio_datos/juegos.csv'
	INTO TABLE juegos
	CHARACTER SET utf8mb4
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	(@JuegoID, Titulo, Consola, @Tamanio, Editor)
	SET JuegoID = CAST(@JuegoID AS DECIMAL), Tamanio = CAST(@Tamanio AS DECIMAL);

LOAD DATA LOCAL INFILE 'directorio_datos/clientes_juegos.csv'
	INTO TABLE clientes_juegos
	CHARACTER SET utf8mb4
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	(@ClienteID, @JuegoID, @FechaAlquiler, Comentarios)
	SET ClienteID = CAST(@ClienteID AS DECIMAL), JuegoID = CAST(@JuegoID AS DECIMAL), FechaAlquiler = STR_TO_DATE(@FechaAlquiler, '%Y-%m-%d');


SET GLOBAL local_infile = FALSE;
