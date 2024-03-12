--CREATE DATABASE exp
--USE exp

CREATE TABLE Servicio (
	CodigoServicio INT PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(200),
	Monto DECIMAL(18,5)
);

CREATE TABLE Producto (
	CodigoProducto INT PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(200),
	Monto DECIMAL(18,5)
);

CREATE TABLE FormaDePago(
	CodigoFormaDePago INT PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(200)
);

CREATE TABLE EstadoCita (
	CodigoEstadoCita INT PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(200)
);

CREATE TABLE EstadoVenta (
	CodigoEstadoVenta INT PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(200)
);

CREATE TABLE EstadoFactura (
	CodigoEstadoFactura INT PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(200)
);

CREATE TABLE ClaseDocumento (
	CodigoClaseDocumento INT PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(200)
);

CREATE TABLE DepartamentoEmpresa (
	CodigoDepartamentoEmpresa INT PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(200)
);

CREATE TABLE Paciente (
    CodigoPaciente INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(200) NOT NULL,
    Correo VARCHAR(200) UNIQUE NOT NULL,
    FechaNacimiento DATETIME NOT NULL,
	FechaCreacion DATETIME DEFAULT GETDATE(),
    Descripcion VARCHAR(200)
);

CREATE TABLE Usuario (
    CodigoUsuario INT PRIMARY KEY IDENTITY(1,1),
	Usuario VARCHAR(200) NOT NULL,
    Nombre VARCHAR(200) NOT NULL,
    Correo VARCHAR(200) UNIQUE NOT NULL,
    Password VARCHAR(200) NOT NULL,
	Estado BIT DEFAULT 1,
    FechaCreacion DATETIME DEFAULT GETDATE(),
	CodigoDepartamentoEmpresa INT FOREIGN KEY REFERENCES DepartamentoEmpresa(CodigoDepartamentoEmpresa)
);

CREATE TABLE Factura (
	CodigoFactura INT PRIMARY KEY IDENTITY(1,1),
	NumeroDeFactura VARCHAR(200),
	SerieDeFactura VARCHAR(200),
	FechaCreacion DATETIME DEFAULT GETDATE(),
	CodigoEstadoFactura INT FOREIGN KEY REFERENCES EstadoFactura(CodigoEstadoFactura),
	CodigoClaseDocumento INT FOREIGN KEY REFERENCES ClaseDocumento(CodigoClaseDocumento)
);

CREATE TABLE Venta (
	CodigoVenta INT PRIMARY KEY IDENTITY(1,1),
	Cantidad INT,
	FechaCreacion DATETIME DEFAULT GETDATE(),
	CodigoUsuario INT FOREIGN KEY REFERENCES Usuario(CodigoUsuario),
	CodigoFactura INT FOREIGN KEY REFERENCES Factura(CodigoFactura),
	CodigoServicio INT FOREIGN KEY REFERENCES Servicio(CodigoServicio),
	CodigoEstadoVenta INT FOREIGN KEY REFERENCES EstadoVenta(CodigoEstadoVenta)
);

CREATE TABLE VentaProducto (
	CodigoVentaProducto INT PRIMARY KEY IDENTITY(1,1),
	CodigoVenta INT FOREIGN KEY REFERENCES Venta(CodigoVenta),
	CodigoProducto INT FOREIGN KEY REFERENCES Producto(CodigoProducto)
);

CREATE TABLE Cita (
	CodigoCita INT PRIMARY KEY IDENTITY(1,1),
	Descripcion VARCHAR(200),
	FechaHoraInicio DATETIME NOT NULL,
	FechaHoraFin DATETIME NOT NULL,
	FechaCreacion DATETIME DEFAULT GETDATE(),
	CodigoFactura INT FOREIGN KEY REFERENCES Factura(CodigoFactura),
	CodigoPaciente INT FOREIGN KEY REFERENCES Paciente(CodigoPaciente),
	CodigoEstadoCita INT FOREIGN KEY REFERENCES EstadoCita(CodigoEstadoCita)
);

CREATE TABLE Cobro (
	CodigoCobro INT PRIMARY KEY IDENTITY(1,1),
	Cuotas INT,
	MontoCuota DECIMAL(18,5),
	BoletaDeposito VARCHAR(200),
	NumeroDeAutorizacion VARCHAR(200),
	FechaCreacion DATETIME DEFAULT GETDATE(),
	CodigoFormaDePago INT FOREIGN KEY REFERENCES FormaDePago(CodigoFormaDePago)
);