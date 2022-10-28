USE PracABD1;

/**
 * Esta operación no funciona de serie
 *
 * En el tab de 'Conexión' de MySQL Workbench ve a 'Avanzado' y en el hueco de 'Otros' introduce:
 * 	 OPT_LOCAL_INFILE=1
 */

SET GLOBAL local_infile = TRUE;


LOAD DATA LOCAL INFILE 'dirección_datos/Clientes.csv'
	INTO TABLE clientes
	CHARACTER SET utf8mb4
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	(@ClienteID, DNI, Nombre, Apellidos, Genero, Direccion, Localidad, Provincia, CodPostal, Telefono, Canal, @FechaNacimiento, @FechaContacto, Email)
	SET ClienteID = CAST(@ClienteID AS DECIMAL), FechaNacimiento = STR_TO_DATE(@FechaNacimiento, '%m/%d/%Y'), FechaContacto = STR_TO_DATE(@FechaContacto, '%m/%d/%Y');

LOAD XML LOCAL INFILE 'dirección_datos/MegaDrive.xml'
	INTO TABLE juegos
	ROWS IDENTIFIED BY '<game>'
	(@imageNumber, @releaseNumber, @title, @romSize, @publisher, @location, @sourceRom, @language, @im1CRC, @im2CRC, @comment)
	SET JuegoID = CAST(@imageNumber AS DECIMAL) + 10000, Titulo = @title, Consola = 'MegaDrive', Tamanio = CAST(@romSize AS DECIMAL), Editor = @publisher;

LOAD XML LOCAL INFILE 'dirección_datos/Nintendo.xml'
	INTO TABLE juegos
	ROWS IDENTIFIED BY '<game>'
	(@imageNumber, @title, @romSize, @location, @language, @im1CRC, @im2CRC, @comment)
	SET JuegoID = CAST(@imageNumber AS DECIMAL) + 12000, Titulo = @title, Consola = 'Nintendo', Tamanio = CAST(@romSize AS DECIMAL), Editor = 'Nintendo';

LOAD XML LOCAL INFILE 'dirección_datos/GameBoy.xml'
	INTO TABLE juegos
	ROWS IDENTIFIED BY '<game>'
	(@imageNumber, @releaseNumber, @title, @saveType, @romSize, @publisher, @location, @sourceRom, @language, @im1CRC, @im2CRC, @comment, @duplicateID)
	SET JuegoID = CAST(@imageNumber AS DECIMAL) + 15000, Titulo = @title, Consola = 'GameBoy', Tamanio = CAST(@romSize AS DECIMAL), Editor = @publisher;
    
LOAD DATA LOCAL INFILE 'dirección_datos/Clientes_Juegos.csv'
	INTO TABLE clientes_juegos
	CHARACTER SET utf8mb4
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	(@ClienteID, @JuegoID, @FechaAlquiler, Comentarios)
	SET ClienteID = CAST(@ClienteID AS DECIMAL), JuegoID = CAST(@JuegoID AS DECIMAL), FechaAlquiler = STR_TO_DATE(@FechaAlquiler, '%m/%d/%Y');


SET GLOBAL local_infile = FALSE;
