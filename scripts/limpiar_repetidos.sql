DELIMITER $$
CREATE PROCEDURE limpiarRepetidos()
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE idMinimo INT;
	DECLARE tit VARCHAR(256);
	DECLARE cur1 CURSOR FOR (SELECT juegos.Titulo
								FROM juegos
								GROUP BY juegos.Titulo, juegos.Editor
								HAVING COUNT(*) > 1);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	OPEN cur1;
	read_loop: LOOP
		FETCH cur1 INTO tit;
		IF done THEN
			LEAVE read_loop;
		END IF;
        
        SELECT JuegoID INTO idMinimo
			FROM juegos
			WHERE juegos.Titulo = tit
			LIMIT 1;
        
        UPDATE clientes_juegos
			SET JuegoID = idMinimo
			WHERE JuegoID IN (SELECT JuegoID
								FROM juegos
								WHERE juegos.Titulo = tit);
                       
		DELETE FROM juegos
			WHERE juegos.Titulo = tit AND juegos.JuegoID <> idMinimo;
            
	END LOOP;
	CLOSE cur1;
END$$
DELIMITER ;
