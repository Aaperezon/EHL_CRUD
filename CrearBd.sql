DROP DATABASE IF EXISTS ehl;
CREATE DATABASE IF NOT EXISTS ehl;
USE ehl;
drop table if exists Actividad;
drop table if exists ActividadCQuiz;
drop table if exists ActividadMemorama;
drop table if exists AlumnoControlParental;
drop table if exists Calificacion;
drop table if exists ControlParental;
drop table if exists Alumno;
drop table if exists CQuiz;
drop table if exists Grupo;
drop table if exists GrupoActividad;
drop table if exists GrupoAlumno;
drop table if exists GrupoMaestro;
drop table if exists Maestro;
drop table if exists Memorama;

CREATE TABLE Maestro(
	idMaestro INT AUTO_INCREMENT PRIMARY KEY,
	nombreCompleto VARCHAR(30) NOT NULL,
    foto VARCHAR(255) NOt NULL default 'liga o url de la foto',
	usuario VARCHAR(16) NOT NULL,
	contraseña VARCHAR(16) NOT NULL,
    perfil varchar (7) null default 'Maestro'

);

CREATE TABLE Grupo(
	idGrupo INT AUTO_INCREMENT PRIMARY KEY,
	nombreGrupo VARCHAR(30) NOT NULL
);

CREATE TABLE GrupoMaestro( 
idGrupo INT NOT NULL, 
idMaestro INT NOT NULL, 
PRIMARY KEY(idGrupo, idMaestro), 
FOREIGN KEY (idGrupo ) REFERENCES Grupo(idGrupo) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (idMaestro) REFERENCES Maestro(idMaestro) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Actividad(
	idActividad INT AUTO_INCREMENT PRIMARY KEY,
	nombreActividad VARCHAR(30) NOT NULL
);

CREATE TABLE GrupoActividad( 
idGrupo INT NOT NULL, 
idActividad INT NOT NULL, 
PRIMARY KEY(idGrupo, idActividad), 
FOREIGN KEY (idGrupo) REFERENCES Grupo(idGrupo) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (idActividad) REFERENCES Actividad(idActividad) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CQuiz(
	idCQuiz INT AUTO_INCREMENT PRIMARY KEY,
	pregunta VARCHAR(128) NOT NULL,
	respuestaCorrecta VARCHAR(128) NOT NULL,
	respuesta VARCHAR(128) NOT NULL
);
CREATE TABLE ActividadCQuiz( 
idCQuiz INT NOT NULL, 
idActividad INT NOT NULL, 
PRIMARY KEY(idCQuiz, idActividad), 
FOREIGN KEY (idCQuiz) REFERENCES CQuiz(idCQuiz) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (idActividad) REFERENCES Actividad(idActividad) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE FlashCard(
	idFlashCard INT AUTO_INCREMENT PRIMARY KEY,
	url LONGBLOB NOT NULL
);
CREATE TABLE ActividadFlashCard( 
idFlashCard INT NOT NULL, 
idActividad INT NOT NULL, 
PRIMARY KEY(idFlashCard, idActividad), 
FOREIGN KEY (idFlashCard) REFERENCES FlashCard(idFlashCard) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (idActividad) REFERENCES Actividad(idActividad) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE ControlParental(
idControlParental INT auto_increment primary key,
usuario varchar(16) not null,
contraseña varchar(16) not null,
perfil varchar (15) null default 'ControlParental'

);

CREATE TABLE Alumno(
idAlumno INT auto_increment primary key,
nombreCompleto varchar (30) not null,
usuario varchar(16) not null,
contraseña varchar(16) not null,
perfil varchar (6) null default 'Alumno'
);

CREATE TABLE GrupoAlumno(
idGrupo INT NOT NULL, 
idAlumno INT NOT NULL, 
PRIMARY KEY(idGrupo, idAlumno), 
foreign key (idGrupo) references Grupo(idGrupo) ON DELETE CASCADE ON UPDATE CASCADE,
foreign key (idAlumno) references Alumno(idAlumno) ON DELETE CASCADE ON UPDATE CASCADE,
faltas INT
);

CREATE TABLE AlumnoControlParental(
idControlParental INT NOT NULL, 
idAlumno INT NOT NULL, 
PRIMARY KEY(idControlParental, idAlumno), 
foreign key (idControlParental) references ControlParental(idControlParental) ON DELETE CASCADE ON UPDATE CASCADE,
foreign key (idAlumno) references Alumno(idAlumno) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Calificacion(
idActividad INT NOT NULL, 
idAlumno INT NOT NULL, 
calificacion FLOAT NOT NULL, 
PRIMARY KEY( idActividad,idAlumno), 
foreign key (idActividad) references Actividad(idActividad) ON DELETE CASCADE ON UPDATE CASCADE,
foreign key (idAlumno) references GrupoAlumno(idAlumno) ON DELETE CASCADE ON UPDATE CASCADE
);
