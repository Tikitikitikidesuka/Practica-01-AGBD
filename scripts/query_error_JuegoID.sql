/**
 * Para investigar este error primero hay que librarse del que ocurre debido a
 * la unicidad de los títulos de los juegos (Mirar README.md para más detalles)
 */

/**
 * Mínimo y máximo `JuegoID` de los juegos de la MegaDrive
 */
SELECT MIN(JuegoID), MAX(JuegoID)
	FROM juegos
	WHERE JuegoID < 12000;
    
SELECT MIN(JuegoID), MAX(JuegoID)
	FROM clientes_juegos
	WHERE JuegoID < 12000;
    
/**
 * Mínimo y máximo `JuegoID` de los juegos de la Nintendo
 */
 
SELECT MIN(JuegoID), MAX(JuegoID)
	FROM juegos
	WHERE JuegoID >= 12000 AND JuegoID < 15000;
    
SELECT MIN(JuegoID), MAX(JuegoID)
	FROM clientes_juegos
	WHERE JuegoID >= 12000 AND JuegoID < 15000;
    
/**
 * Mínimo y máximo `JuegoID` de los juegos de la GameBoy
 */
 
SELECT MIN(JuegoID), MAX(JuegoID)
	FROM juegos
	WHERE JuegoID >= 15000;
    
SELECT MIN(JuegoID), MAX(JuegoID)
	FROM clientes_juegos
	WHERE JuegoID >= 15000; 

/**
 * Mínimo y máximo `JuegoID` de los juegos de la GameBoy
 */

SELECT *
	FROM clientes_juegos LEFT JOIN juegos ON juegos.JuegoID = clientes_juegos.JuegoID
	WHERE juegos.JuegoID IS NULL;
