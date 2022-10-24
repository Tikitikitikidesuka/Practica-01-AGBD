DELIMITER //

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

DELIMITER ;
