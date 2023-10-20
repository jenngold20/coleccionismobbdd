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


