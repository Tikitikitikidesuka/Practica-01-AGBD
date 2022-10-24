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

DELIMITER ;
