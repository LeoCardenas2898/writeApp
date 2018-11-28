CREATE DATABASE WRITEAPP;
USE WRITEAPP;
CREATE TABLE PAIS
(IDPAIS INT AUTO_INCREMENT PRIMARY KEY,
PAIS VARCHAR(20),
FOTO VARCHAR(20)
);

CREATE TABLE USUARIO
(
 IDUSUARIO INT AUTO_INCREMENT PRIMARY KEY,
 NOMBRE VARCHAR(30),
 APELLIDOS VARCHAR(30),
 CORREO VARCHAR(40),
 CONTRASEŅA VARCHAR(10),
 NICK VARCHAR(45),
IDPAIS INT,
FOREIGN KEY (IDPAIS) REFERENCES PAIS(IDPAIS) 

);

CREATE TABLE BORRADOR
(
 IDBORRADOR INT AUTO_INCREMENT PRIMARY KEY,
 TITULO VARCHAR(40),
 CONTENIDO TEXT,
 IDUSUARIO INT NOT NULL, 
 FOREIGN KEY (IDUSUARIO) REFERENCES USUARIO(IDUSUARIO) 
);
CREATE TABLE CATEGORIA
(
 IDCATEGORIA INT AUTO_INCREMENT PRIMARY KEY,
 CATEGORIA VARCHAR(15) 
);
CREATE TABLE LIBRO
(IDLIBRO INT AUTO_INCREMENT PRIMARY KEY,
 TITULO VARCHAR(45),
 FOTO VARCHAR(20),
 DESCRIPCION VARCHAR(100),
 IDCATEGORIA INT NOT NULL, 
 USUARIO VARCHAR(30) NOT NULL,
FOREIGN KEY (IDCATEGORIA) REFERENCES CATEGORIA(IDCATEGORIA) 
);

CREATE TABLE CAPITULO
(
 IDCAPITULO INT AUTO_INCREMENT PRIMARY KEY,
 IDLIBRO INT NOT NULL,
 IDBORRADOR INT NOT NULL, 
 FOREIGN KEY (IDBORRADOR) REFERENCES BORRADOR(IDBORRADOR),
 FOREIGN KEY (IDLIBRO) REFERENCES LIBRO(IDLIBRO)
);
CREATE TABLE BIBLIOTECA
(
 IDBIBLIOTECA INT AUTO_INCREMENT PRIMARY KEY,
 IDLIBRO INT,
 IDUSUARIO INT,
 FOREIGN KEY (IDUSUARIO) REFERENCES USUARIO(IDUSUARIO),
 FOREIGN KEY (IDLIBRO) REFERENCES LIBRO(IDLIBRO)
);