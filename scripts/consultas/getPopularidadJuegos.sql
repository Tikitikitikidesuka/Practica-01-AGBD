DELIMITER //

CREATE PROCEDURE getPopularidadJuegos()
BEGIN
	SELECT juegos.JuegoID, juegos.Titulo, COUNT(*) AS VecesAlquilado
		FROM juegos JOIN clientes_juegos ON juegos.JuegoID = clientes_juegos.JuegoID
        GROUP BY juegos.JuegoID, juegos.Titulo
        ORDER BY VecesAlquilado DESC;
END //

DELIMITER ;
