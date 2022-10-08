CREATE TABLE `clientes_juegos` (
	ClienteID INT NOT NULL,
    JuegoID INT NOT NULL,
    FechaAlquiler DATE NOT NULL,
    Comentarios VARCHAR(500),
    PRIMARY KEY (ClienteID, JuegoID, FechaAlquiler)
) TABLESPACE `TBLS_clientes_juegos` 