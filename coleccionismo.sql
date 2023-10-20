CREATE DATABASE coleccionismo;
use coleccionismo;

-- Crear la tabla "Coleccionistas"
CREATE TABLE IF NOT EXISTS Coleccionistas (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    CorreoElectronico VARCHAR(100) NOT NULL,
    NumeroTelefono VARCHAR(20) NOT NULL
);

-- Crear la tabla "Objetos"
CREATE TABLE IF NOT EXISTS Objetos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion TEXT,
    Categoria VARCHAR(50),
    AnioFabricacion INT,
    ValorAproximado DECIMAL(10, 2),
    FechaAdquisicion DATE
);

-- Crear la tabla "Colecciones"
CREATE TABLE IF NOT EXISTS Colecciones (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    IDColeccionista INT NOT NULL,
    FOREIGN KEY (IDColeccionista) REFERENCES Coleccionistas(ID)
);

-- Crear la tabla "Relacion Objeto-Coleccion"
CREATE TABLE IF NOT EXISTS RelacionObjetoColeccion (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    IDObjeto INT NOT NULL,
    IDColeccion INT NOT NULL,
    FOREIGN KEY (IDObjeto) REFERENCES Objetos(ID),
    FOREIGN KEY (IDColeccion) REFERENCES Colecciones(ID)
);

-- Crear la tabla "Transacciones"
CREATE TABLE IF NOT EXISTS Transacciones (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Fecha DATE NOT NULL,
    TipoTransaccion VARCHAR(20),
    Monto DECIMAL(10, 2),
    Notas TEXT,
    IDObjeto INT NOT NULL,
    IDColeccionista INT NOT NULL,
    FOREIGN KEY (IDObjeto) REFERENCES Objetos(ID),
    FOREIGN KEY (IDColeccionista) REFERENCES Coleccionistas(ID)
);

-- Crear la tabla "Ubicacion"
CREATE TABLE IF NOT EXISTS Ubicacion (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Ubicacion VARCHAR(100),
    IDObjeto INT NOT NULL,
    FOREIGN KEY (IDObjeto) REFERENCES Objetos(ID)
);

-- Crear la tabla "Eventos"
CREATE TABLE IF NOT EXISTS Eventos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NombreEvento VARCHAR(100) NOT NULL,
    FechaEvento DATE NOT NULL,
    DescripcionEvento TEXT,
    IDObjeto INT NOT NULL,
    IDColeccionista INT NOT NULL,
    FOREIGN KEY (IDObjeto) REFERENCES Objetos(ID),
    FOREIGN KEY (IDColeccionista) REFERENCES Coleccionistas(ID)
);

-- Crear la tabla "Etiquetas"
CREATE TABLE IF NOT EXISTS Etiquetas (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Etiqueta VARCHAR(50),
    IDObjeto INT NOT NULL,
    FOREIGN KEY (IDObjeto) REFERENCES Objetos(ID)
);

-- Inserción de datos en la tabla "Coleccionistas"
INSERT INTO Coleccionistas (Nombre, Direccion, CorreoElectronico, NumeroTelefono)
VALUES
    ('Juan Pérez', '123 Calle Principal, Ciudad', 'juan@email.com', '+1234567890'),
    ('María González', '456 Avenida Secundaria, Ciudad', 'maria@email.com', '+9876543210'),
    ('Luis Rodríguez', '789 Calle de Ejemplo, Ciudad', 'luis@email.com', '+5678901234');

-- Inserción de datos en la tabla "Objetos"
INSERT INTO Objetos (Nombre, Descripcion, Categoria, AnioFabricacion, ValorAproximado, FechaAdquisicion)
VALUES
    ('Moneda Antigua', 'Una moneda antigua de oro', 'Monedas', 1850, 500.00, '2021-01-15'),
    ('Sello Postal', 'Sello raro y antiguo', 'Sellos', 1900, 100.00, '2022-03-20'),
    ('Figura de Colección', 'Figura de acción de edición limitada', 'Figuras', 2005, 50.00, '2021-10-05');

-- Inserción de datos en la tabla "Colecciones"
INSERT INTO Colecciones (Nombre, Descripcion, IDColeccionista)
VALUES
    ('Colección de Monedas', 'Colección de monedas antiguas', 1),
    ('Colección de Sellos', 'Colección de sellos raros', 2),
    ('Colección de Figuras', 'Colección de figuras de películas', 1);

-- Inserción de datos en la tabla "Relacion Objeto-Coleccion"
INSERT INTO RelacionObjetoColeccion (IDObjeto, IDColeccion)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);

-- Inserción de datos en la tabla "Transacciones"
INSERT INTO Transacciones (Fecha, TipoTransaccion, Monto, Notas, IDObjeto, IDColeccionista)
VALUES
    ('2021-02-10', 'Compra', 200.00, 'Compra de moneda antigua', 1, 1),
    ('2022-04-05', 'Venta', 75.00, 'Venta de sello', 2, 2),
    ('2021-11-30', 'Intercambio', NULL, 'Intercambio de figuras de colección', 3, 1);

-- Inserción de datos en la tabla "Ubicacion"
INSERT INTO Ubicacion (Ubicacion, IDObjeto)
VALUES
    ('Estantería 1, Estante 3', 1),
    ('Caja 2', 2),
    ('Estantería 2, Estante 1', 3);

-- Inserción de datos en la tabla "Eventos"
INSERT INTO Eventos (NombreEvento, FechaEvento, DescripcionEvento, IDObjeto, IDColeccionista)
VALUES
    ('Exposición Numismática', '2022-06-15', 'Moneda en exhibición', 1, 1),
    ('Feria Filatélica', '2021-09-05', 'Venta de sellos', 2, 2),
    ('Convención de Figuras', '2022-12-12', 'Figura de colección destacada', 3, 1);

-- Inserción de datos en la tabla "Etiquetas"
INSERT INTO Etiquetas (Etiqueta, IDObjeto)
VALUES
    ('Antiguo', 1),
    ('Raro', 2),
    ('Edición Limitada', 3);


-- Inserción de datos en la tabla "Coleccionistas"
INSERT INTO Coleccionistas (Nombre, Direccion, CorreoElectronico, NumeroTelefono)
VALUES
    ('Ana López', '789 Avenida Principal, Ciudad', 'ana@email.com', '+1112223333'),
    ('Pedro Ramírez', '456 Calle Secundaria, Ciudad', 'pedro@email.com', '+4445556666'),
    ('Isabel Torres', '123 Calle Ejemplo, Ciudad', 'isabel@email.com', '+7778889999');

-- Inserción de datos en la tabla "Objetos"
INSERT INTO Objetos (Nombre, Descripcion, Categoria, AnioFabricacion, ValorAproximado, FechaAdquisicion)
VALUES
    ('Pintura al óleo', 'Obra maestra del siglo XIX', 'Arte', 1875, 1000.00, '2022-04-10'),
    ('Libro antiguo', 'Edición rara y coleccionable', 'Libros', 1905, 500.00, '2022-02-15'),
    ('Reloj de pulsera', 'Reloj suizo de lujo', 'Relojes', 2010, 800.00, '2021-11-20');

-- Inserción de datos en la tabla "Colecciones"
INSERT INTO Colecciones (Nombre, Descripcion, IDColeccionista)
VALUES
    ('Colección de Arte', 'Obras de arte históricas', 1),
    ('Colección de Libros Antiguos', 'Libros raros y coleccionables', 2),
    ('Colección de Relojes de Lujo', 'Relojes suizos y de alta gama', 1);

-- Inserción de datos en la tabla "Relacion Objeto-Coleccion"
INSERT INTO RelacionObjetoColeccion (IDObjeto, IDColeccion)
VALUES
    (4, 1),
    (5, 2),
    (6, 3);

-- Inserción de datos en la tabla "Transacciones"
INSERT INTO Transacciones (Fecha, TipoTransaccion, Monto, Notas, IDObjeto, IDColeccionista)
VALUES
    ('2022-06-05', 'Compra', 500.00, 'Compra de pintura al óleo', 4, 1),
    ('2022-03-15', 'Venta', 250.00, 'Venta de libro antiguo', 5, 2),
    ('2021-12-01', 'Intercambio', NULL, 'Intercambio de reloj de pulsera', 6, 1);

-- Inserción de datos en la tabla "Ubicacion"
INSERT INTO Ubicacion (Ubicacion, IDObjeto)
VALUES
    ('Pared 1, Sala de Estar', 4),
    ('Estantería 2, Estante 3', 5),
    ('Caja 1', 6);

-- Inserción de datos en la tabla "Eventos"
INSERT INTO Eventos (NombreEvento, FechaEvento, DescripcionEvento, IDObjeto, IDColeccionista)
VALUES
    ('Exposición de Arte', '2022-08-20', 'Exposición de pinturas', 4, 1),
    ('Feria del Libro Antiguo', '2022-09-30', 'Venta de libros raros', 5, 2),
    ('Exposición de Relojes', '2021-10-10', 'Exhibición de relojes suizos', 6, 1);

-- Inserción de datos en la tabla "Etiquetas"
INSERT INTO Etiquetas (Etiqueta, IDObjeto)
VALUES
    ('Óleo', 4),
    ('Antiguo', 5),
    ('Lujo', 6);




-- Creación de vistas

CREATE VIEW VistaObjetosYUbicaciones AS
SELECT Objetos.ID AS ObjetoID, Objetos.Nombre AS NombreObjeto, Objetos.Descripcion AS DescripcionObjeto, COALESCE(Ubicacion.Ubicacion, 'No especificada') AS Ubicacion
FROM Objetos
LEFT JOIN Ubicacion ON Objetos.ID = Ubicacion.IDObjeto;

CREATE VIEW VistaColeccionesYObjetosConValor AS
SELECT Colecciones.ID AS ColeccionID, Colecciones.Nombre AS NombreColeccion, Objetos.Nombre AS NombreObjeto, Objetos.ValorAproximado
FROM Colecciones
INNER JOIN RelacionObjetoColeccion ON Colecciones.ID = RelacionObjetoColeccion.IDColeccion
INNER JOIN Objetos ON RelacionObjetoColeccion.IDObjeto = Objetos.ID;

CREATE VIEW VistaTransaccionesDetalladas AS
SELECT Transacciones.ID AS TransaccionID, Transacciones.Fecha, Transacciones.TipoTransaccion, Transacciones.Monto, Transacciones.Notas, Objetos.Nombre AS NombreObjeto, Coleccionistas.Nombre AS NombreColeccionista
FROM Transacciones
LEFT JOIN Objetos ON Transacciones.IDObjeto = Objetos.ID
LEFT JOIN Coleccionistas ON Transacciones.IDColeccionista = Coleccionistas.ID;

CREATE VIEW VistaObjetosYEtiquetas AS
SELECT Objetos.ID AS ObjetoID, Objetos.Nombre AS NombreObjeto, Etiquetas.Etiqueta
FROM Objetos
LEFT JOIN Etiquetas ON Objetos.ID = Etiquetas.IDObjeto;

CREATE VIEW VistaObjetosConValorAlto AS
SELECT * FROM Objetos WHERE ValorAproximado > 100.00;

CREATE VIEW VistaColeccionesConConteo AS
SELECT Colecciones.ID AS ColeccionID, Colecciones.Nombre AS NombreColeccion, COUNT(RelacionObjetoColeccion.IDObjeto) AS NumeroDeObjetos
FROM Colecciones
LEFT JOIN RelacionObjetoColeccion ON Colecciones.ID = RelacionObjetoColeccion.IDColeccion
GROUP BY Colecciones.ID, Colecciones.Nombre;

CREATE VIEW VistaObjetosConValorTotal AS
SELECT
    C.ID AS ColeccionID,
    C.Nombre AS NombreColeccion,
    O.ID AS ObjetoID,
    O.Nombre AS NombreObjeto,
    O.ValorAproximado,
    COALESCE(SUM(O2.ValorAproximado), 0) AS ValorTotalColeccion
FROM Colecciones C
INNER JOIN RelacionObjetoColeccion RC ON C.ID = RC.IDColeccion
INNER JOIN Objetos O ON RC.IDObjeto = O.ID
LEFT JOIN RelacionObjetoColeccion RC2 ON RC2.IDColeccion = C.ID
LEFT JOIN Objetos O2 ON RC2.IDObjeto = O2.ID
GROUP BY C.ID, C.Nombre, O.ID, O.Nombre, O.ValorAproximado;

