DELIMITER //

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
