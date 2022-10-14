USE PracABD1;

SET sql_safe_updates = FALSE;

UPDATE juegos
	SET juegos.Titulo = CONCAT(juegos.Titulo, ' - ', juegos.Editor)
    WHERE juegos.Editor IS NOT NULL AND juegos.Titulo IN (
		SELECT juegos.Titulo FROM (
			SELECT juegos.Titulo
				FROM juegos
				GROUP BY juegos.Titulo
				HAVING COUNT(juegos.Titulo) > 1
			) AS titulos_repetidos
		);

CREATE TEMPORARY TABLE juegos_id_map
	SELECT juegos.JuegoID AS OLD_ID, NEW_ID
		FROM juegos JOIN (
			SELECT MIN(juegos.JuegoID) AS NEW_ID, juegos.Titulo
				FROM juegos
				GROUP BY juegos.Titulo
				HAVING COUNT(juegos.Titulo) > 1
			) juegos_repetidos ON juegos.Titulo = juegos_repetidos.Titulo
		WHERE juegos.JuegoID <> NEW_ID;

UPDATE clientes_juegos 
	JOIN juegos_id_map ON clientes_juegos.JuegoID = juegos_id_map.OLD_ID
	SET clientes_juegos.JuegoID = juegos_id_map.NEW_ID;

DELETE FROM juegos
	WHERE juegos.JuegoID IN (
		SELECT juegos_id_map.OLD_ID
			FROM juegos_id_map
		);

DROP TEMPORARY TABLE juegos_id_map;

SET sql_safe_updates = TRUE;