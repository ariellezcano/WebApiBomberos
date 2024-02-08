CREATE DATABASE BOMBEROMETROPOLITANA

USE BOMBEROMETROPOLITANA


--- TABLA UNIDAD SISTEMA
CREATE TABLE UNIDADSISTEMA
(
	id int NOT NULL IDENTITY PRIMARY KEY,
	nombre varchar(150) NOT NULL
);

--- TABLA ROL
CREATE TABLE ROL
(
	id int NOT NULL IDENTITY PRIMARY KEY,
	nombre varchar(50) NOT NULL,
	activo bit NOT NULL
);

--- TABLA USUARIOBOMBERO
CREATE TABLE USUARIOBOMBERO
(
	id int IDENTITY PRIMARY KEY NOT NULL,
	userCreaRepo int NOT NULL,
	usuarioRepo int,
	fechaAlta datetime NOT NULL,
	persona int NULL,
	civil int NULL,
	norDni int NULL,
	nombre varchar(50) NULL,
	apellido varchar(50) NULL,
	tipoPersona bit NULL,
	fechaBaja datetime NULL,
	usuarioBaja int NULL,
	baja bit NULL,
	sistema int FOREIGN KEY REFERENCES UNIDADSISTEMA(id),
	cifrado varchar(250),
	fechaVinculacion datetime NULL,
	rol int FOREIGN KEY REFERENCES ROL(id),
	activo bit NOT NULL
);

--- TABLA LOCALIDAD
CREATE TABLE LOCALIDAD
(
	id INT IDENTITY PRIMARY KEY NOT NULL,
	nombre NVARCHAR(50) NOT NULL
);

--- TABLA SOLICITANTE
CREATE TABLE SOLICITANTE
(
	id INT IDENTITY PRIMARY KEY NOT NULL,
	dniCuitCuil NVARCHAR(13) NOT NULL,
	apellido NVARCHAR(25) NOT NULL,
	nombre NVARCHAR(25) NOT NULL,
	calle NVARCHAR(50) NOT NULL,
	numero INT NULL,
	piso INT NULL,
	dpto INT NULL,
	localidad INT FOREIGN KEY REFERENCES LOCALIDAD(id),
	email NVARCHAR(50) NULL,
	telFijo NVARCHAR(20) NULL,
	celular NVARCHAR(20) NULL,
	activo BIT NOT NULL
);

--- TABLA MONTOUNIDADFISCAL
CREATE TABLE MONTOUNIDADFISCAL
(
	id INT IDENTITY PRIMARY KEY NOT NULL,
	---categoria INT FOREIGN KEY REFERENCES CATEGORIA(id) NOT NULL,
	fechaHabilitacion DATETIME NOT NULL,
	monto DECIMAL(9,2) NOT NULL,
	resolucion NVARCHAR(75) NULL,
	fechaBaja DATETIME NULL,
	activo BIT NULL
);

--- TABLA CATEGORIA
CREATE TABLE CATEGORIA
(
	id INT IDENTITY PRIMARY KEY NOT NULL,
	codigo INT NOT NULL,
	descripcion NVARCHAR(20) NULL,
	categoria NVARCHAR(2) NULL,
	unidadFiscal INT NOT NULL,
	montoUf INT FOREIGN KEY REFERENCES MONTOUNIDADFISCAL(id) NOT NULL,
	fechaBaja DATETIME NULL,
	activo BIT NOT NULL
);

--- TABLA LOCALES
CREATE TABLE LOCALES
(
	id INT IDENTITY PRIMARY KEY NOT NULL,
	calle NVARCHAR(30) NOT NULL,
	nro INT NULL,
	piso INT NULL,
	dpto INT NULL,
	mzPcUf NVARCHAR(8) NULL,
	localidad INT FOREIGN KEY REFERENCES LOCALIDAD(id) NOT NULL,
	superficieLocal INT NOT NULL,
	montoCategoria INT FOREIGN KEY REFERENCES MONTOUNIDADFISCAL(id) NOT NULL,
	personaSol INT FOREIGN KEY REFERENCES SOLICITANTE(id),
	fechaAlta DATETIME NOT NULL,
	usuarioAlta INT FOREIGN KEY REFERENCES USUARIOBOMBERO(id),
	fechaModif DATETIME NULL,
	usuarioModif INT FOREIGN KEY REFERENCES USUARIOBOMBERO(id) NULL,
	fechaBaja DATETIME NULL,
	usuarioBaja INT FOREIGN KEY REFERENCES USUARIOBOMBERO(id) NULL,
	activo BIT NOT NULL
);

--- TABLA ESTADO
CREATE TABLE ESTADO
(
	id INT IDENTITY PRIMARY KEY NOT NULL,
	nombre NVARCHAR(25) NOT NULL,
	activo BIT NOT NULL
)

--- TABLA HABILITACION
CREATE TABLE HABILITACION
(
	id INT IDENTITY PRIMARY KEY NOT NULL,
	localSolicitante INT FOREIGN KEY REFERENCES LOCALES(id) NOT NULL,
	fechaSolicitud DATETIME NOT NULL,
	estado INT FOREIGN KEY REFERENCES ESTADO(id),
	fechaHabilitacion DATETIME NULL,
	fechaVto DATETIME NULL,
	observaciones NVARCHAR(100) NULL,
	activo BIT NOT NULL
)

--- TABLA TIPOSERVICIO
CREATE TABLE TIPOSERVICIO
(
	id INT IDENTITY PRIMARY KEY NOT NULL,
	descripcion NVARCHAR(75) NOT NULL,
	activo BIT NOT NULL
)

--- TABLA FUNCIONALIDAD
CREATE TABLE FUNCIONALIDAD
(
	id INT IDENTITY PRIMARY KEY NOT NULL,
	codigo INT NULL,
	funcion NVARCHAR(50) NULL,
	activo BIT NOT NULL
)

--- TABLA IMPRESION
CREATE TABLE IMPRESION
(
	id INT IDENTITY PRIMARY KEY NOT NULL,
	localSol INT FOREIGN KEY REFERENCES LOCALES(id) NOT NULL,
	nroComprobante INT NOT NULL,
	fechaConfeccion DATETIME NOT NULL,
	funcionalidad INT FOREIGN KEY REFERENCES FUNCIONALIDAD(id) NOT NULL,
	tipoServicio INT FOREIGN KEY REFERENCES TIPOSERVICIO(id) NOT NULL,
	fechaPago DATETIME NULL,
	importe DECIMAL(9,2) NOT NULL,
	observaciones NVARCHAR(75) NULL,
	fechaAlta DATETIME NOT NULL,
	usuarioAlta INT FOREIGN KEY REFERENCES USUARIOBOMBERO(id) NOT NULL,
	fechaBaja DATETIME NULL,
	usuarioBaja INT FOREIGN KEY REFERENCES USUARIOBOMBERO(id) NULL,
	fechaModif DATETIME NULL,
	usuarioModif INT FOREIGN KEY REFERENCES USUARIOBOMBERO(id) NULL,
	activo BIT NOT NULL
)