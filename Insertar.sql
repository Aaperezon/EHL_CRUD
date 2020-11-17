INSERT INTO Alumno (nombreCompleto , usuario, contraseña) VALUES 
('Emmanuel del Río Sarmiento','a','a'),
('Aaron Perez Ontiveros','Aaron','Apo'),
('Andrea Espinosa Azuela','Andy','Aea'),
('Ricardo Adolfo Solís Zugarazo','Ricky','Rasz');

INSERT INTO Maestro (nombreCompleto , usuario, contraseña) VALUES 
('Hugo Omar Alejandres Sánchez','h','h'),
('Nimrod Gonzalez','Nimrod','Ng'),
('Gwendolyne Delgado García','Gwen','Gdg'),
('Pedro Najera','Pedro','Pedro');

INSERT INTO Actividad (nombreActividad) VALUES 
('Actividad C++'),
('Actividad C#'),
('Actividad java'),
('Actividad4 SQL');

INSERT INTO CQuiz (pregunta, respuestaCorrecta, respuesta ) VALUES
('Pregunta 1','Respuesta correcta 1','Respuesta incorrecta'),
('Pregunta 2','Respuesta correcta 2','Respuesta incorrecta'),
('Pregunta 3','Respuesta correcta 3','Respuesta incorrecta'),
('Pregunta 4','Respuesta correcta 4','Respuesta incorrecta'),
('Pregunta 5','Respuesta correcta 5','Respuesta incorrecta');

INSERT INTO ActividadCQuiz (idCQuiz, idActividad) VALUES 
(1,2),
(2,2),
(3,2),
(4,2),
(5,2);

INSERT INTO ControlParental (usuario, contraseña) VALUES 
('c','c'),
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
(1,4,0),
(1,2,2),
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