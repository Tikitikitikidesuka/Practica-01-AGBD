DELIMITER //

CREATE PROCEDURE getEmailPorNombreCompleto(
    IN nombre VARCHAR(20),
    IN apellidos VARCHAR(30)
)
BEGIN
	SELECT DISTINCT clientes.Email
		FROM clientes
        WHERE clientes.Nombre = nombre AND clientes.Apellidos = apellidos;
END //

CREATE PROCEDURE getNumeroClientesPorProvincia(
    IN provincia VARCHAR(30)
)
BEGIN
	SELECT COUNT(*)
		FROM clientes
        WHERE clientes.Provincia = provincia;
END //

CREATE PROCEDURE getClientesPorCanalYPeriodo(
    IN canal ENUM('desconocido', 'web', 'llamadas', 'visitas', 'contactos'),
    IN inicioPeriodo DATE,
    IN finalPeriodo DATE
)
BEGIN
	SELECT clientes.Nombre, clientes.Apellidos, clientes.Email
		FROM clientes
        WHERE clientes.Canal = canal AND 
			clientes.FechaContacto >= inicioPeriodo AND
            clientes.FechaContacto <= finalPeriodo;
END //

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

CREATE PROCEDURE getPopularidadJuegos()
BEGIN
	SELECT juegos.JuegoID, juegos.Titulo, COUNT(*) AS VecesAlquilado
		FROM juegos JOIN clientes_juegos ON juegos.JuegoID = clientes_juegos.JuegoID
        GROUP BY juegos.JuegoID, juegos.Titulo
        ORDER BY VecesAlquilado DESC;
END //

CREATE PROCEDURE getClientesConMasDeNAlquileres(
	IN minAlquileres INT
)
BEGIN
	SELECT clientes.ClienteID, clientes.Nombre, clientes.Apellidos, COUNT(*) AS VecesAlquilado
		FROM clientes JOIN clientes_juegos ON clientes.ClienteID = clientes_juegos.ClienteID
        GROUP BY clientes.ClienteID, clientes.Nombre, clientes.Apellidos
        HAVING COUNT(*) >= minAlquileres
        ORDER BY VecesAlquilado DESC;
END //

DELIMITER ;
