USE PracABD1;

ALTER TABLE clientes
ADD PRIMARY KEY (ClienteID);

ALTER TABLE juegos
ADD PRIMARY KEY (JuegoID);

ALTER TABLE clientes_juegos
ADD PRIMARY KEY (ClienteID, JuegoID, FechaAlquiler);