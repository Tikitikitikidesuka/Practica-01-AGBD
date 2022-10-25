DELIMITER //

CREATE PROCEDURE getAlquileres20192020PorProvincia(
    IN provincia VARCHAR(30)
)
BEGIN
	SELECT clientes.Nombre, clientes.Apellidos, juegos.Titulo, clientes_juegos.FechaAlquiler
		FROM clientes JOIN clientes_juegos
			ON clientes.ClienteID = clientes_juegos.ClienteID JOIN juegos
            ON clientes_juegos.JuegoID = juegos.JuegoID
        WHERE clientes_juegos.FechaAlquiler >= DATE '2019-01-01' AND
			clientes_juegos.FechaAlquiler <= DATE '2020-12-31' AND
            clientes.Provincia = provincia
		ORDER BY clientes.Apellidos;
END //

DELIMITER ;
