CREATE DATABASE `Farmacia`;

CREATE TABLE if NOT EXISTS droga(
ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
codigo INT NOT NULL,
nombre VARCHAR(45) NOT NULL);

CREATE TABLE if NOT EXISTS Afiliado(
ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(45) NOT NULL,
apellido VARCHAR(45) NOT NULL);

CREATE TABLE if NOT EXISTS Proveedor(
ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
cuit INT NOT NULL,
razonSocial VARCHAR(45) NOT NULL,
esLaboratorio TINYINT NOT NULL,
esFarmacia TINYINT NOT NULL);

CREATE TABLE if NOT EXISTS Entrega(
ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
fecha DATE NOT NULL,
numero INT NOT NULL,
afiliadoID INT NOT NULL,
FOREIGN KEY (afiliadoID)
REFERENCES afiliado(ID)
);

CREATE TABLE if NOT EXISTS Medicamento(
ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombreComercial VARCHAR(45) NOT NULL,
precioCompra DECIMAL(15,2) NOT NULL,
precioVenta DECIMAL(15,2) NOT NULL,
ventaLibre TINYINT NOT NULL,
proveedorID INT NOT NULL,
drogaID INT NOT NULL,
FOREIGN KEY(proveedorID)
REFERENCES proveedor(ID),

FOREIGN KEY (drogaID)
REFERENCES droga(ID));

CREATE TABLE if NOT EXISTS EntregaDetalle(
ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
cantidad INT NOT NULL,
medicamentoID INT NOT NULL,
entregaID INT NOT NULL,
FOREIGN KEY(medicamentoID)
REFERENCES Medicamento(ID),
FOREIGN KEY (entregaID)
REFERENCES entrega(ID));

INSERT INTO droga(ID,codigo,nombre)VALUES
(1,002,'ibuprofeno'),
(2,003,'paracetamol');

INSERT INTO proveedor(ID,cuit,razonSocial,esLaboratorio,esFarmacia)VALUES
(1,1235,'ibuprofenolandia',TRUE,TRUE),
(2,1256,'paracetamolSA',TRUE,FALSE);

INSERT INTO medicamento(ID,nombreComercial,precioCompra,PrecioVenta,ventaLibre,proveedorID,drogaID)VALUES 
(1,'ibupirac',250,270.2,TRUE,1,1),
(2,'gelocatil',150,175.5,TRUE,2,2);

INSERT INTO afiliado(ID,nombre,apellido)VALUES 
(1, 'thiago','godoy');

INSERT INTO entrega(ID,fecha,numero,afiliadoID)VALUES 
(1,20210825,01,1);

INSERT INTO entregadetalle(ID,cantidad,medicamentoID,entregaID) VALUES
(1,1,1,1),
(2,1,2,1);


SELECT p.ID proveedor,m.proveedorID medicamentos,p.razonSocial ,COUNT(*) cantidad
FROM proveedor p INNER JOIN medicamento m ON p.ID=m.proveedorID
WHERE p.ID=m.proveedorID;

SELECT p.esLaboratorio laboratorio,m.ID medicamento,p.razonSocial,COUNT(*) cantidad
FROM proveedor p INNER JOIN medicamento m ON p.ID=m.proveedorID
WHERE p.esLaboratorio=TRUE AND p.ID=m.proveedorID
GROUP BY p.ID 
ORDER BY cantidad DESC;

SELECT e.fecha,e.numero, CONCAT(a.nombre,' ',a.apellido) AS NombreApellido
FROM entregadetalle ed INNER JOIN medicamento m ON m.ID=ed.medicamentoID
							  INNER JOIN entrega e ON e.ID=ed.entregaID
							  INNER JOIN afiliado a ON e.afiliadoID=a.ID
WHERE ed.cantidad>10;

SELECT d.nombre Nombre,m.drogaID COUNT(*) cantidad
FROM droga d INNER JOIN medicamento m ON m.drogaID=d.ID
WHERE d.codigo>5