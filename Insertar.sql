INSERT INTO Alumno (nombreCompleto , usuario, contraseña) VALUES 
('Emmanuel del Río Sarmiento','q','q'),
('Aaron Perez Ontiveros','Aaron','Apo'),
('Andrea Espinosa Azuela','Andy','Aea'),
('Ricardo Adolfo Solís Zugarazo','Ricky','Rasz');

INSERT INTO Maestro (nombreCompleto , usuario, contraseña) VALUES 
('Hugo Omar Alejandres Sánchez','Hugo','Hoas'),
('Nimrod Gonzalez','Nimrod','Ng'),
('Gwendolyne Delgado García','Gwen','Gdg'),
('Pedro Najera','Pedro','Pedro');

INSERT INTO Actividad (nombreActividad) VALUES 
('Actividad C++'),
('Actividad C#'),
('Actividad java'),
('Actividad4 SQL');

INSERT INTO ControlParental (usuario, contraseña) VALUES 
('e','e'),
('CP-Aaron','cpapo'),
('CP-Andy','cpaca'),
('CP-Ricky','cpricky');

INSERT INTO AlumnoControlParental (idAlumno, idControlParental) VALUES 
(1,1),
(2,2),
(3,3),
(4,4);

INSERT INTO Grupo (nombreGrupo) VALUES 
('Clase lenguajeS C/C++/C#'),
('Clase Java'),
('Clase SQL'),
('Clase Deportes');

INSERT INTO GrupoActividad (idActividad, idGrupo) VALUES 
(1,1),
(2,1),
(3,2),
(4,3);

INSERT INTO GrupoAlumno (idAlumno,idGrupo,faltas) VALUES 
(1,2,0),
(1,1,2),
(2,2,0),
(3,2,4),
(4,2,2);

INSERT INTO Calificacion (idActividad,idAlumno,calificacion) VALUES 
(1,1,0),
(1,2,10),
(1,3,10),
(1,4,8),
(2,1,9),
(2,2,9),
(2,3,9),
(2,4,9),
(3,1,9);

INSERT INTO GrupoMaestro (idMaestro,idGrupo) VALUES 
(1,4),
(1,2),
(2,3),
(3,2),
(4,1);