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
        
SET sql_safe_updates = TRUE;