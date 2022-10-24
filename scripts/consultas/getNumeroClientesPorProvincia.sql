DELIMITER //

CREATE PROCEDURE getNumeroClientesPorProvincia(
    IN provincia VARCHAR(30)
)
BEGIN
	SELECT COUNT(*)
		FROM clientes
        WHERE clientes.Provincia = provincia;
END //

DELIMITER ;
