USE PracABD1;

CREATE TABLE clientes (
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
    Email VARCHAR(60),
    PRIMARY KEY (ClienteID)
) TABLESPACE TBLS_clientes;

CREATE TABLE juegos (
	JuegoID INT UNIQUE NOT NULL,
	Titulo VARCHAR(32) UNIQUE NOT NULL,
	Consola VARCHAR(12) NOT NULL,
	Tamanio INT,
	Editor VARCHAR(32),
	PRIMARY KEY (JuegoID)
) TABLESPACE TBLS_juegos;

CREATE TABLE clientes_juegos (
	ClienteID INT NOT NULL,
    JuegoID INT NOT NULL,
    FechaAlquiler DATE NOT NULL,
    Comentarios VARCHAR(500),
    PRIMARY KEY (ClienteID, JuegoID, FechaAlquiler),
    FOREIGN KEY (ClienteID) REFERENCES clientes(ClienteID),
    FOREIGN KEY (JuegoID) REFERENCES juegos(JuegoID)
) TABLESPACE TBLS_clientes_juegos;
