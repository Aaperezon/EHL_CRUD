use ehl;
/*Control Parental : Calificaciones
	nombre del alumno, nombre de los grupos a los que pertenece, calificaciones de cada actividad y sacar el promedio
*/



drop procedure if exists ControlParentalCalificaciones;
DELIMITER //
CREATE PROCEDURE ControlParentalCalificaciones(IN usr VARCHAR(16), IN pass VARCHAR(16))
BEGIN
	DROP TEMPORARY TABLE  IF EXISTS Resultado1;
	CREATE TEMPORARY TABLE Resultado1 AS
		SELECT Alumno.nombreCompleto, Grupo.nombreGrupo, Actividad.nombreActividad, Calificacion.calificacion
		FROM (((((((ControlParental
			INNER JOIN AlumnoControlParental ON ControlParental.idControlParental = AlumnoControlParental.idControlParental)
			INNER JOIN Alumno ON AlumnoControlParental.idAlumno = Alumno.idAlumno)
			INNER JOIN GrupoAlumno ON GrupoAlumno.idAlumno = Alumno.idAlumno)
			INNER JOIN Grupo ON GrupoAlumno.idGrupo = Grupo.idGrupo)
			INNER JOIN GrupoActividad ON Grupo.idGrupo = GrupoActividad.idGrupo)
			INNER JOIN Actividad ON GrupoActividad.idActividad = Actividad.idActividad)
			INNER JOIN Calificacion ON GrupoAlumno.idAlumno = Calificacion.idAlumno and Actividad.idActividad = Calificacion.idActividad)
		WHERE  ControlParental.idControlParental and ControlParental.usuario = usr and ControlParental.contraseña = pass;
	DROP TEMPORARY TABLE  IF EXISTS Resultado2;
    CREATE TEMPORARY TABLE Resultado2 AS
		SELECT Grupo.nombreGrupo, AVG(Calificacion.calificacion) as promedio
		FROM (((((((ControlParental
			INNER JOIN AlumnoControlParental ON ControlParental.idControlParental = AlumnoControlParental.idControlParental)
			INNER JOIN Alumno ON AlumnoControlParental.idAlumno = Alumno.idAlumno)
			INNER JOIN GrupoAlumno ON GrupoAlumno.idAlumno = Alumno.idAlumno)
			INNER JOIN Grupo ON GrupoAlumno.idGrupo = Grupo.idGrupo)
			INNER JOIN GrupoActividad ON Grupo.idGrupo = GrupoActividad.idGrupo)
			INNER JOIN Actividad ON GrupoActividad.idActividad = Actividad.idActividad)
			INNER JOIN Calificacion ON GrupoAlumno.idAlumno = Calificacion.idAlumno and Actividad.idActividad = Calificacion.idActividad)
		WHERE  ControlParental.idControlParental and ControlParental.usuario = usr and ControlParental.contraseña = pass
		GROUP BY Grupo.nombreGrupo; 
        
	SELECT Resultado1.nombreCompleto,Resultado1.nombreGrupo,  Resultado2.promedio , Resultado1.nombreActividad, Resultado1.calificacion
    FROM(Resultado1
		INNER JOIN Resultado2 ON Resultado1.nombreGrupo = Resultado2.nombreGrupo);
        
        
END //
DELIMITER ;
#CALL ControlParentalCalificaciones( 'e', 'e' );


/*Control Parental : Asistencias
	nombre del alumno, nombre de los grupos a lso que pertenece, faltas del alumno en cada grupo
*/

drop procedure if exists ControlParentalAsistencias;
DELIMITER //
CREATE PROCEDURE ControlParentalAsistencias(IN usr VARCHAR(16), IN pass VARCHAR(16))
BEGIN
	SELECT Alumno.nombreCompleto, Grupo.nombreGrupo, GrupoAlumno.faltas
	FROM ((((ControlParental
		INNER JOIN AlumnoControlParental ON ControlParental.idControlParental = AlumnoControlParental.idControlParental)
		INNER JOIN Alumno ON AlumnoControlParental.idAlumno = Alumno.idAlumno)
		INNER JOIN GrupoAlumno ON GrupoAlumno.idAlumno = Alumno.idAlumno)
		INNER JOIN Grupo ON GrupoAlumno.idGrupo = Grupo.idGrupo)
		
	WHERE  ControlParental.idControlParental and ControlParental.usuario = usr and ControlParental.contraseña = pass;

END //
DELIMITER ;
#CALL ControlParentalAsistencias( 'c', 'c' );


/*Control Parental : Nivel de conocimiento
	calificaciones de todas las actividades del alumno.
*/
drop procedure if exists ControlParentalNivelConocimiento;
DELIMITER //
CREATE PROCEDURE ControlParentalNivelConocimiento(IN usr VARCHAR(16), IN pass VARCHAR(16))
BEGIN
	SELECT Alumno.nombreCompleto, ROUND(AVG(Calificacion.calificacion),1) as nivelConocimiento
	FROM (((((((ControlParental
		INNER JOIN AlumnoControlParental ON ControlParental.idControlParental = AlumnoControlParental.idControlParental)
		INNER JOIN Alumno ON AlumnoControlParental.idAlumno = Alumno.idAlumno)
		INNER JOIN GrupoAlumno ON GrupoAlumno.idAlumno = Alumno.idAlumno)
		INNER JOIN Grupo ON GrupoAlumno.idGrupo = Grupo.idGrupo)
		INNER JOIN GrupoActividad ON Grupo.idGrupo = GrupoActividad.idGrupo)
		INNER JOIN Actividad ON GrupoActividad.idActividad = Actividad.idActividad)
        INNER JOIN Calificacion ON GrupoAlumno.idAlumno = Calificacion.idAlumno and Actividad.idActividad = Calificacion.idActividad)
	WHERE  ControlParental.idControlParental and ControlParental.usuario = usr and ControlParental.contraseña = pass
    GROUP BY Alumno.nombreCompleto;
END //
DELIMITER ;
#CALL ControlParentalNivelConocimiento( 'e', 'e' );

/*Alumno : Actividades
	nombre de todos los grupos, actividades de cada grupo, calificacion de cada actividad.
*/

drop procedure if exists AlumnoActividades;
DELIMITER //
CREATE PROCEDURE AlumnoActividades(IN usr VARCHAR(16), IN pass VARCHAR(16))
BEGIN
	SELECT Alumno.nombreCompleto, Actividad.nombreActividad, Calificacion.calificacion
	FROM (((((Alumno
        INNER JOIN GrupoAlumno ON Alumno.idAlumno = GrupoAlumno.idAlumno)
        INNER JOIN Grupo ON GrupoAlumno.idGrupo = Grupo.idGrupo)
        INNER JOIN GrupoActividad ON Grupo.idGrupo = GrupoActividad.idGrupo)
        INNER JOIN Actividad ON GrupoActividad.idActividad = Actividad.idActividad)
        INNER JOIN Calificacion ON GrupoAlumno.idAlumno = Calificacion.idAlumno and Actividad.idActividad = Calificacion.idActividad)
        
        
	WHERE  Alumno.usuario = usr and Alumno.contraseña = pass;
END //
DELIMITER ;
#CALL AlumnoActividades( 'q', 'q' );

/*Alumno : Grupos
	nombre del grupo, nombre del maestro que da ese grupo.
*/

drop procedure if exists AlumnoGrupos;
DELIMITER //
CREATE PROCEDURE AlumnoGrupos(IN usr VARCHAR(16), IN pass VARCHAR(16))
BEGIN
	SELECT Grupo.nombreGrupo, Maestro.nombreCompleto
	FROM ((((Alumno
        INNER JOIN GrupoAlumno ON Alumno.idAlumno = GrupoAlumno.idAlumno)
        INNER JOIN Grupo ON GrupoAlumno.idGrupo = Grupo.idGrupo)
        INNER JOIN GrupoMaestro ON Grupo.idGrupo = GrupoMaestro.idGrupo)
        INNER JOIN Maestro ON GrupoMaestro.idMaestro = Maestro.idMaestro)

	WHERE  Alumno.usuario = usr and Alumno.contraseña = pass;
END //
DELIMITER ;
#CALL AlumnoGrupos( 'q', 'q' );

/*Alumno : Ajustes
	comprobar contraseña actual y 
	cambiar contraseña
*/

drop procedure if exists AlumnoAjustes;
DELIMITER //
CREATE PROCEDURE AlumnoAjustes(IN usr VARCHAR(16), IN pass VARCHAR(16),IN newPass VARCHAR(16))
BEGIN
	DECLARE id INT;
    SET id = (SELECT Alumno.idAlumno FROM Alumno WHERE Alumno.usuario = usr and Alumno.contraseña = pass);
    
	UPDATE Alumno 
    SET contraseña = newPass WHERE Alumno.idAlumno = id;

	
END //
DELIMITER ;
#CALL AlumnoAjustes( 'q', 'q', 'w');

#SELECT * from Alumno

/*Maestro : Alumnos
	nombre de los grupos del maestro, alumnos de cada grupo
	Asignar faltas a cada alumno
    ♦Añadir alumno
		añadir nombre, añadir usuario, añadir contraseña.
        asociar nuevo alumno con un grupo
	♦Añadir grupo
		añadir nombre del grupo y asociarlo con el profesor
*/

/*Maestro : Trabajos
	nombre de las actividades que hizo el profesor
    ♦Asignar actividades a cada grupo
		nombre de cada grupo del profesor
	♦Editar	 actividad
		editar nombre de la actividad, editar pregunta, editar respuestaCorrecta, editar respuesta2, editar respuesta3
	♦Añadir actividad
		añadir nombre de la actividad, añadir pregunta, añadir respuestaCorrecta, añadir respuesta2, añadir respuesta3
*/







/*Maestro : Ajustes
	comprobar contraseña actual y 
	cambiar contraseña
    
    cambiar imagen
*/
drop procedure if exists MaestroAjustes;
DELIMITER //
CREATE PROCEDURE MaestroAjustes(IN usr VARCHAR(16), IN pass VARCHAR(16),IN newPass VARCHAR(16))
BEGIN
	DECLARE id INT;
    SET id = (SELECT Maestro.idMaestro FROM Maestro WHERE Maestro.usuario = usr and Maestro.contraseña = pass);
    
	UPDATE Maestro 
    SET contraseña = newPass WHERE Maestro.idMaestro = id;

	
END //
DELIMITER ;
#CALL MaestroAjustes( 'q', 'q', 'w');

#SELECT * from Maestro