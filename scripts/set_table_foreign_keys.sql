USE PracABD1;

ALTER TABLE clientes_juegos
ADD FOREIGN KEY (ClienteID) REFERENCES clientes(ClienteID),
ADD FOREIGN KEY (JuegoID) REFERENCES juegos(JuegoID);