USE PracABD1;

/**
 * Esta operación no funciona de serie
 *
 * En el tab de 'Conexión' de MySQL Workbench ve a 'Avanzado' y en el hueco de 'Otros' introduce:
 * 	 OPT_LOCAL_INFILE=1
 */
 
SET GLOBAL local_infile = TRUE;

LOAD DATA LOCAL INFILE '/home/miguel/Documents/projects/practica_01_agdb/datos/Clientes.csv'
	INTO TABLE clientes
	CHARACTER SET utf8
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	(@ClienteID, DNI, Nombre, Apellidos, Genero, Direccion, Localidad, Provincia, CodPostal, Telefono, Canal, @FechaNacimiento, @FechaContacto, Email)
	SET ClienteID = CAST(@ClienteID AS DECIMAL), FechaNacimiento = STR_TO_DATE(@FechaNacimiento, '%m/%d/%Y'), FechaContacto = STR_TO_DATE(@FechaContacto, '%m/%d/%Y');

SET GLOBAL local_infile = FALSE;
