USE PracABD1;

/**
 * Esta operación no funciona de serie
 *
 * En el tab de 'Conexión' de MySQL Workbench ve a 'Avanzado' y en el hueco de 'Otros' introduce:
 * 	 OPT_LOCAL_INFILE=1
 */

SET GLOBAL local_infile = TRUE;


LOAD DATA LOCAL INFILE '<DIRECCIÓN_DEL_FICHERO>/Clientes.csv'
	INTO TABLE clientes
	CHARACTER SET utf8
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	(@ClienteID, DNI, Nombre, Apellidos, Genero, Direccion, Localidad, Provincia, CodPostal, Telefono, Canal, @FechaNacimiento, @FechaContacto, Email)
	SET ClienteID = CAST(@ClienteID AS DECIMAL), FechaNacimiento = STR_TO_DATE(@FechaNacimiento, '%m/%d/%Y'), FechaContacto = STR_TO_DATE(@FechaContacto, '%m/%d/%Y');

LOAD XML LOCAL INFILE '<DIRECCIÓN_DEL_FICHERO>/GameBoy.xml'
	INTO TABLE juegos
    ROWS IDENTIFIED BY '<game>'
    (@imageNumber, @releaseNumber, @title, @saveType, @romSize, @publisher, @location, @sourceRom, @language, @im1CRC, @im2CRC, @comment, @duplicateID)
    SET JuegoID = CAST(@releaseNumber AS DECIMAL) + 15000, Titulo = @title, Consola = 'GameBoy', Tamanio = CAST(@romSize AS DECIMAL), Editor = @publisher;

LOAD DATA LOCAL INFILE '<DIRECCIÓN_DEL_FICHERO>/Clientes_Juegos.csv'
	INTO TABLE clientes_juegos
	CHARACTER SET utf8
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	(@ClienteID, @JuegoID, @FechaAlquiler, Comentarios)
	SET ClienteID = CAST(@ClienteID AS DECIMAL), JuegoID = CAST(@JuegoID AS DECIMAL), FechaAlquiler = STR_TO_DATE(@FechaAlquiler, '%m/%d/%Y');
    

SET GLOBAL local_infile = FALSE;
