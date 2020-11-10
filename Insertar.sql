INSERT INTO Alumno (nombreCompleto , usuario, contraseña) VALUES 
('alumno1','a','a'),
('alumno2','s','g'),
('alumno3','h','g'),
('alumno4','q','a');
INSERT INTO Maestro (nombreCompleto , usuario, contraseña) VALUES 
('Aaron','m','m'),
('Andrea','m','m'),
('Emmanuel','m','m'),
('Ricardo','m','m');
INSERT INTO Actividad (nombreActividad) VALUES 
('Actividad1'),
('Actividad2'),
('Actividad3'),
('Actividad4');

INSERT INTO ControlParental (usuario, contraseña) VALUES 
('c','c'),
('w','j'),
('ñ','l'),
('o','r');
INSERT INTO AlumnoControlParental (idAlumno, idControlParental) VALUES 
(1,1),
(2,2),
(3,3),
(4,4);
INSERT INTO Grupo (nombreGrupo) VALUES 
('Grupo1'),
('Grupo2'),
('Grupo3'),
('Grupo4');
INSERT INTO GrupoActividad (idActividad, idGrupo) VALUES 
(1,1),
(2,2);

INSERT INTO GrupoAlumno (idAlumno,idGrupo,faltas) VALUES 
(1,2,0),
(1,1,2),
(2,2,0),
(3,2,4),
(4,2,2);
INSERT INTO Calificacion (idActividad,idAlumno,calificacion) VALUES 
(1,1,1),
(1,2,7),
(1,3,8),
(1,4,8),
(2,1,9),
(2,2,9),
(2,3,9),
(2,4,9);

INSERT INTO GrupoMaestro (idMaestro,idGrupo) VALUES 
(1,4),
(1,2),
(2,3),
(3,2),
(4,1);