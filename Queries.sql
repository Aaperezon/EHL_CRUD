use ehl;
/*Control Parental : Calificaciones
	nombre del alumno, nombre de los grupos a los que pertenece, calificaciones de cada actividad y sacar el promedio
*/



drop procedure if exists ControlParentalCalificaciones;
DELIMITER //
CREATE PROCEDURE ControlParentalCalificaciones(IN usr INT)
BEGIN
	DROP TEMPORARY TABLE  IF EXISTS Resultado1;
	CREATE TEMPORARY TABLE Resultado1 AS
		SELECT Alumno.nombreCompleto, Grupo.nombreGrupo, Actividad.nombreActividad, Calificacion.calificacion
		FROM (((((((ControlParental
			INNER JOIN AlumnoControlParental ON ControlParental.id = AlumnoControlParental.idControlParental)
			INNER JOIN Alumno ON AlumnoControlParental.idAlumno = Alumno.id)
			INNER JOIN GrupoAlumno ON GrupoAlumno.idAlumno = Alumno.id)
			INNER JOIN Grupo ON GrupoAlumno.idGrupo = Grupo.id)
			INNER JOIN GrupoActividad ON Grupo.id = GrupoActividad.idGrupo)
			INNER JOIN Actividad ON GrupoActividad.idActividad = Actividad.id)
			INNER JOIN Calificacion ON GrupoAlumno.idAlumno = Calificacion.idAlumno and Actividad.id = Calificacion.idActividad)
		WHERE ControlParental.id = usr;
	DROP TEMPORARY TABLE  IF EXISTS Resultado2;
    CREATE TEMPORARY TABLE Resultado2 AS
		SELECT Grupo.nombreGrupo, AVG(Calificacion.calificacion) as promedio
		FROM (((((((ControlParental
			INNER JOIN AlumnoControlParental ON ControlParental.id = AlumnoControlParental.idControlParental)
			INNER JOIN Alumno ON AlumnoControlParental.idAlumno = Alumno.id)
			INNER JOIN GrupoAlumno ON GrupoAlumno.idAlumno = Alumno.id)
			INNER JOIN Grupo ON GrupoAlumno.idGrupo = Grupo.id)
			INNER JOIN GrupoActividad ON Grupo.id = GrupoActividad.idGrupo)
			INNER JOIN Actividad ON GrupoActividad.idActividad = Actividad.id)
			INNER JOIN Calificacion ON GrupoAlumno.idAlumno = Calificacion.idAlumno and Actividad.id = Calificacion.idActividad)
		WHERE  ControlParental.id = usr
		GROUP BY Grupo.nombreGrupo; 
        
	SELECT Resultado1.nombreCompleto,Resultado1.nombreGrupo,  Resultado2.promedio , Resultado1.nombreActividad, Resultado1.calificacion
    FROM(Resultado1
		INNER JOIN Resultado2 ON Resultado1.nombreGrupo = Resultado2.nombreGrupo);
        
        
END //
DELIMITER ;
#CALL ControlParentalCalificaciones( 1 );


/*Control Parental : Asistencias
	nombre del alumno, nombre de los grupos a lso que pertenece, faltas del alumno en cada grupo
*/

drop procedure if exists ControlParentalAsistencias;
DELIMITER //
CREATE PROCEDURE ControlParentalAsistencias(IN usr INT)
BEGIN
	SELECT Alumno.nombreCompleto, Grupo.nombreGrupo, GrupoAlumno.faltas
	FROM ((((ControlParental
		INNER JOIN AlumnoControlParental ON ControlParental.id = AlumnoControlParental.idControlParental)
		INNER JOIN Alumno ON AlumnoControlParental.idAlumno = Alumno.id)
		INNER JOIN GrupoAlumno ON GrupoAlumno.idAlumno = Alumno.id)
		INNER JOIN Grupo ON GrupoAlumno.idGrupo = Grupo.id)
		
	WHERE  ControlParental.id  = usr;

END //
DELIMITER ;
#CALL ControlParentalAsistencias( 1 );


/*Control Parental : Nivel de conocimiento
	calificaciones de todas las actividades del alumno.
*/
drop procedure if exists ControlParentalNivelConocimiento;
DELIMITER //
CREATE PROCEDURE ControlParentalNivelConocimiento(IN usr INT)
BEGIN
	SELECT Alumno.nombreCompleto, ROUND(AVG(Calificacion.calificacion),1) as nivelConocimiento
	FROM (((((((ControlParental
		INNER JOIN AlumnoControlParental ON ControlParental.id = AlumnoControlParental.idControlParental)
		INNER JOIN Alumno ON AlumnoControlParental.idAlumno = Alumno.id)
		INNER JOIN GrupoAlumno ON GrupoAlumno.idAlumno = Alumno.id)
		INNER JOIN Grupo ON GrupoAlumno.idGrupo = Grupo.id)
		INNER JOIN GrupoActividad ON Grupo.id = GrupoActividad.idGrupo)
		INNER JOIN Actividad ON GrupoActividad.idActividad = Actividad.id)
        INNER JOIN Calificacion ON GrupoAlumno.idAlumno = Calificacion.idAlumno and Actividad.id = Calificacion.idActividad)
	WHERE  ControlParental.id  = usr
    GROUP BY Alumno.nombreCompleto;
END //
DELIMITER ;
#CALL ControlParentalNivelConocimiento( 1 );























/*Alumno : Actividades
	nombre de todos los grupos, actividades de cada grupo, calificacion de cada actividad.
*/

drop procedure if exists AlumnoActividades;
DELIMITER //
CREATE PROCEDURE AlumnoActividades(IN usr INT)
BEGIN
	SELECT Alumno.nombreCompleto, Actividad.nombreActividad, Calificacion.calificacion
	FROM (((((Alumno
        INNER JOIN GrupoAlumno ON Alumno.id = GrupoAlumno.idAlumno)
        INNER JOIN Grupo ON GrupoAlumno.idGrupo = Grupo.id)
        INNER JOIN GrupoActividad ON Grupo.id = GrupoActividad.idGrupo)
        INNER JOIN Actividad ON GrupoActividad.idActividad = Actividad.id)
        INNER JOIN Calificacion ON GrupoAlumno.idAlumno = Calificacion.idAlumno and Actividad.id = Calificacion.idActividad)        
	WHERE  Alumno.id = usr;
    
END //
DELIMITER ;
#CALL AlumnoActividades( 1 );

/*Alumno : Grupos
	nombre del grupo, nombre del maestro que da ese grupo.
*/
drop procedure if exists AlumnoGrupos;
DELIMITER //
CREATE PROCEDURE AlumnoGrupos(IN usr INT)
BEGIN
	SELECT Grupo.nombreGrupo, Maestro.nombreCompleto
	FROM ((((Alumno
        INNER JOIN GrupoAlumno ON Alumno.id = GrupoAlumno.idAlumno)
        INNER JOIN Grupo ON GrupoAlumno.idGrupo = Grupo.id)
        INNER JOIN GrupoMaestro ON Grupo.id = GrupoMaestro.idGrupo)
        INNER JOIN Maestro ON GrupoMaestro.idMaestro = Maestro.id)

	WHERE  Alumno.id = usr;
END //
DELIMITER ;
#CALL AlumnoGrupos( 1 );

/*Alumno : Ajustes
	comprobar contraseña actual y 
	cambiar contraseña
*/
drop procedure if exists AlumnoAjustes;
DELIMITER //
CREATE PROCEDURE AlumnoAjustes(IN usr INT, IN newPass VARCHAR(16))
BEGIN
	
	UPDATE Alumno 
    SET contraseña = newPass WHERE Alumno.id = usr;

	
END //
DELIMITER ;
#CALL AlumnoAjustes( 1, 'w');
#SELECT * from Alumno
























/*Maestro : Alumnos
	nombre de los grupos del maestro, alumnos de cada grupo
*/
drop procedure if exists MaestroAlumnos;
DELIMITER //
CREATE PROCEDURE MaestroAlumnos(IN usr INT)
BEGIN
	SELECT Grupo.nombreGrupo, Alumno.nombreCompleto, Alumno.id as idAlumno, Grupo.id as idGrupo
	FROM ((((Maestro
        INNER JOIN GrupoMaestro ON Maestro.id = GrupoMaestro.idMaestro)
        INNER JOIN Grupo ON GrupoMaestro.idGrupo = Grupo.id)
        INNER JOIN GrupoAlumno ON Grupo.id = GrupoAlumno.idGrupo)
        INNER JOIN Alumno ON GrupoAlumno.idAlumno = Alumno.id)
	WHERE  Maestro.id = usr
    ORDER BY Grupo.nombreGrupo;
END //
DELIMITER ;
#CALL MaestroAlumnos( 1 );




/*Maestro : AlumnosFaltas
	Asignar faltas a cada alumno
*/
drop procedure if exists AlumnosFaltas;
DELIMITER //
CREATE PROCEDURE AlumnosFaltas(IN idAlum INT, IN idGrup INT)
BEGIN
	UPDATE GrupoAlumno 
    SET faltas = (faltas+1) WHERE GrupoAlumno.idAlumno = idAlum  and GrupoAlumno.idGrupo = idGrup;
END //
DELIMITER ;
#CALL AlumnosFaltas(1,1);
#SELECT * FROM GrupoAlumno;


/*Maestro : AlumnosAdd
    ♦Añadir alumno
		añadir nombre, añadir usuario, añadir contraseña.
        asociar nuevo alumno con un grupo
*/
drop procedure if exists AlumnosAdd;
DELIMITER //
CREATE PROCEDURE AlumnosAdd(IN nombre VARCHAR(30), IN usr VARCHAR(16),IN pass VARCHAR(16))
BEGIN
	INSERT INTO Alumno (nombreCompleto , usuario, contraseña) VALUES 
	(nombre,usr,pass);
    
END //
DELIMITER ;
#CALL AlumnosAdd('NewNombre','NewUser','NewPass');
#SELECT * FROM Alumno;


/*Maestro : AlumnosAddGrupo
	♦Añadir grupo
		añadir nombre del grupo y asociarlo con el profesor
*/
drop procedure if exists AlumnosAddGrupo;
DELIMITER //
CREATE PROCEDURE AlumnosAddGrupo(IN idMtro INT,IN newGroup VARCHAR(30))
BEGIN
    DECLARE idNewGroup INT;

	INSERT INTO Grupo (nombreGrupo) VALUES 
	(newGroup);
    SET idNewGroup = (SELECT Grupo.id FROM Grupo WHERE Grupo.nombreGrupo = newGroup);
    
	INSERT INTO GrupoMaestro (idMaestro,idGrupo) VALUES 
	(idMtro,idNewGroup);
    
END //
DELIMITER ;
#CALL AlumnosAddGrupo(1,'NewGroup',);
#SELECT * FROM Alumno;





/*Maestro : AlumnosGruposMaestro
	♦Enlistar grupos existentes releacionados con el maestro
*/
drop procedure if exists AlumnosGruposMaestro;
DELIMITER //
CREATE PROCEDURE AlumnosGruposMaestro(IN usr INT)
BEGIN
   SELECT Grupo.nombreGrupo
	FROM ((Maestro
        INNER JOIN GrupoMaestro ON Maestro.id = GrupoMaestro.idMaestro)
        INNER JOIN Grupo ON GrupoMaestro.idGrupo = Grupo.id)
	WHERE  Maestro.id = usr
    ORDER BY Grupo.nombreGrupo;
    
END //
DELIMITER ;
#CALL AlumnosGruposMaestro(1);
#SELECT * FROM Alumno;





/*Maestro : Trabajos
	nombre de las actividades que hizo el profesor
    ♦Asignar actividades a cada grupo
		nombre de cada grupo del profesor
	♦Editar	 actividad
		editar nombre de la actividad, editar pregunta, editar respuestaCorrecta, editar respuesta2, editar respuesta3
	♦Añadir actividad
		añadir nombre de la actividad, añadir pregunta, añadir respuestaCorrecta, añadir respuesta2, añadir respuesta3
*/
drop procedure if exists MaestroTrabajos;
DELIMITER //
CREATE PROCEDURE MaestroTrabajos(IN usr INT)
BEGIN
   SELECT DISTINCT Actividad.nombreActividad, Grupo.nombreGrupo
	FROM (((((Maestro
        INNER JOIN GrupoMaestro ON Maestro.id = GrupoMaestro.idMaestro)
        INNER JOIN Grupo ON GrupoMaestro.idGrupo = Grupo.id)
		INNER JOIN GrupoActividad ON Grupo.id = GrupoActividad.idActividad)
		INNER JOIN Actividad ON GrupoActividad.idActividad = Actividad.id)
		INNER JOIN ActividadCQuiz ON Actividad.id = ActividadCQuiz.idActividad)
	WHERE  Maestro.id = usr
    ORDER BY Actividad.nombreActividad;
    
END //
DELIMITER ;
CALL MaestroTrabajos(1);
#SELECT * FROM Alumno;






/*Maestro : Ajustes
	comprobar contraseña actual y 
	cambiar contraseña
    
    cambiar imagen
*/
drop procedure if exists MaestroAjustes;
DELIMITER //
CREATE PROCEDURE MaestroAjustes(IN usr INT,IN newPass VARCHAR(16))
BEGIN
	
	UPDATE Maestro 
    SET contraseña = newPass WHERE Maestro.id = usr;

	
END //
DELIMITER ;
#CALL MaestroAjustes( 1, 'w');

#SELECT * from Maestro