USE PracADB1;

CREATE TABLE `clientes` (
	ClienteID INT UNIQUE NOT NULL,
    DNI VARCHAR(9) UNIQUE NOT NULL,
    Nombre VARCHAR(20) NOT NULL,
    Apellidos VARCHAR(30) NOT NULL,
    Genero ENUM('H', 'M'), 
    Direccion VARCHAR(60),
    Localidad VARCHAR(50),
	Provincia VARCHAR(30),
    CodPostal INT,
    Telefono INT,
    Canal ENUM('desconocido', 'web', 'llamadas', 'visitas', 'contactos'),
    FechaNacimiento DATE,
    FechaContacto DATE,
    Email VARCHAR(60)
    )
    
TABLESPACE TBLS_clientes;