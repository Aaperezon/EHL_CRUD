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
#CALL AlumnoActividades( 5 );

	
    
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



/*Alumno : ActividadResolver
	ver las preguntas de las actividades para responder
*/
drop procedure if exists AlumnoActividadResolver;
DELIMITER //
CREATE PROCEDURE AlumnoActividadResolver(IN nameActivity VARCHAR(30))
BEGIN
	SELECT  CQuiz.pregunta as pregunta , CQuiz.respuesta, CQuiz.id
	FROM ((Actividad
		INNER JOIN CQuiz)
        INNER JOIN ActividadCQuiz ON Actividad.id = ActividadCQuiz.idActividad and CQuiz.id = ActividadCQuiz.idCQuiz)
	WHERE  Actividad.nombreActividad = nameActivity
    UNION ALL
    SELECT  CQuiz.pregunta,CQuiz.respuestaCorrecta, CQuiz.id
    FROM ((Actividad
		INNER JOIN CQuiz)
        INNER JOIN ActividadCQuiz ON Actividad.id = ActividadCQuiz.idActividad and CQuiz.id = ActividadCQuiz.idCQuiz)
	WHERE  Actividad.nombreActividad = nameActivity
	ORDER BY pregunta;

END //
DELIMITER ;
#    CALL AlumnoActividadResolver('g');
#SELECT * from Alumno



drop trigger if exists AutoCalificacion;
DELIMITER //
CREATE TRIGGER AutoCalificacion AFTER INSERT ON GrupoActividad FOR EACH ROW INSERT INTO Calificacion (idActividad,idAlumno,calificacion) VALUES
(NEW.idActividad,SELECT Alumno.id FROM (((((Actividad
	INNER JOIN Grupo)
    INNER JOIN GrupoActividad ON Actividad.id = GrupoActividad.idActividad and GrupoActividad.idGrupo = Grupo.id)
    INNER JOIN Alumno)
    INNER JOIN GrupoAlumno ON Grupo.id = GrupoAlumno.idGrupo and Alumno.id = GrupoAlumno.idAlumno)
)
WHERE Actividad.id = NEW.idActividad;, 0);



DELIMITER ;
#CALL FotoAvatar( 1 );



SELECT * FROM Calificacion;











/*Maestro : FotoAvatar
*/
drop procedure if exists FotoAvatar;
DELIMITER //
CREATE PROCEDURE FotoAvatar(IN usr INT)
BEGIN
	SELECT Maestro.foto 
    FROM Maestro
    WHERE Maestro.id = usr;
END //
DELIMITER ;
#CALL FotoAvatar( 1 );

/*Maestro : ActualizaFotoAvatar
*/
drop procedure if exists ActualizaFotoAvatar;
DELIMITER //
CREATE PROCEDURE ActualizaFotoAvatar(IN usr INT, IN newFoto VARCHAR(255))
BEGIN
	UPDATE Maestro 
    SET foto = newFoto WHERE Maestro.id = usr;
END //
DELIMITER ;
#CALL ActualizaFotoAvatar( 1 ," " );






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
drop procedure if exists MaestroAgregarAlumnoConGrupo;
DELIMITER //
CREATE PROCEDURE MaestroAgregarAlumnoConGrupo(IN mtro INT, IN nombre VARCHAR(30), IN usr VARCHAR(16),IN pass VARCHAR(16),IN newGroup VARCHAR(16), IN usrCP VARCHAR(16),IN passCP VARCHAR(16))
BEGIN
    DECLARE newIDAlumno INT;
    DECLARE newIDCP INT;
    DECLARE newIDGroup INT;
	INSERT INTO Alumno (nombreCompleto , usuario, contraseña) VALUES 
	(nombre,usr,pass);
	SET newIDAlumno = (SELECT Alumno.id FROM Alumno WHERE Alumno.nombreCompleto = nombre and usuario = usr and contraseña = pass);
    INSERT INTO ControlParental (usuario, contraseña) VALUES 
	(usrCP,passCP);
	SET newIDCP = (SELECT ControlParental.id FROM ControlParental WHERE usuario = usrCP and contraseña = passCP);
    INSERT INTO AlumnoControlParental (idAlumno, idControlParental) VALUES 
	(newIDAlumno,newIDCP);
    
	INSERT INTO Grupo (nombreGrupo) VALUES 
	(newGroup);
	SET newIDGroup = (SELECT Grupo.id FROM Grupo WHERE nombreGrupo = newGroup);
    INSERT INTO GrupoAlumno (idAlumno,idGrupo,faltas) VALUES 
	(newIDAlumno,newIDGroup,0);
	INSERT INTO GrupoMaestro (idGrupo,idMaestro) VALUES 
	(newIDGroup,mtro);
    
    
END //
DELIMITER ;
#CALL MaestroAgregarAlumnoConGrupo(1,'NewNombre','NewUser','NewPass','nGroup' ,'n','n');



drop procedure if exists MaestroAgregarAlumnoSinGrupo;
DELIMITER //
CREATE PROCEDURE MaestroAgregarAlumnoSinGrupo(IN nombre VARCHAR(30), IN usr VARCHAR(16),IN pass VARCHAR(16),IN newGroup VARCHAR(16), IN usrCP VARCHAR(16),IN passCP VARCHAR(16))
BEGIN
    DECLARE newIDAlumno INT;
    DECLARE newIDCP INT;
    DECLARE IDGroup INT;
    
	INSERT INTO Alumno (nombreCompleto , usuario, contraseña) VALUES 
	(nombre,usr,pass);
	SET newIDAlumno = (SELECT Alumno.id FROM Alumno WHERE Alumno.nombreCompleto = nombre and usuario = usr and contraseña = pass);
    
    INSERT INTO ControlParental (usuario, contraseña) VALUES 
	(usrCP,passCP);
    
	SET newIDCP = (SELECT ControlParental.id FROM ControlParental WHERE usuario = usrCP and contraseña = passCP);
    
    INSERT INTO AlumnoControlParental (idAlumno, idControlParental) VALUES 
	(newIDAlumno,newIDCP);
    
	SET IDGroup = (SELECT Grupo.id FROM Grupo WHERE nombreGrupo = newGroup);
    
	INSERT INTO GrupoAlumno (idAlumno,idGrupo,faltas) VALUES 
	(newIDAlumno,IDGroup,0);
   
    
END //
DELIMITER ;
#CALL MaestroAgregarAlumnoSinGrupo('NewNombre','NewUser','NewPass','Clase Deportes' ,'n','n');
/*
	SELECT * FROM Alumno;

	SELECT Alumno.id FROM Alumno WHERE Alumno.nombreCompleto = 'Emmanuel del Río Sarmiento' and usuario = 'a' and contraseña = 'a' LIMIT 1;
	SELECT ControlParental.id FROM ControlParental WHERE usuario = 'c' and contraseña = 'c' LIMIT 1;
	SELECT Grupo.id FROM Grupo WHERE nombreGrupo = 'Clase Deportes' LIMIT 1;
*/





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


/*Maestro : Boleta

*/

drop procedure if exists MaestroAlumnosBoleta;
DELIMITER //
CREATE PROCEDURE MaestroAlumnosBoleta(IN idAlumno INT, IN idGrupo INT)
BEGIN
   SELECT Alumno.nombreCompleto, Actividad.nombreActividad, Calificacion.calificacion
	FROM (((((Alumno
        INNER JOIN GrupoAlumno ON Alumno.id = GrupoAlumno.idAlumno)
        INNER JOIN Grupo ON GrupoAlumno.idGrupo = Grupo.id)
        INNER JOIN Actividad)
        INNER JOIN GrupoActividad ON Actividad.id = GrupoActividad.idActividad and Grupo.id = GrupoActividad.idGrupo)
        INNER JOIN Calificacion ON Actividad.id = Calificacion.idActividad and GrupoAlumno.idAlumno = Calificacion.idAlumno)
		
	WHERE Alumno.id = idAlumno and Grupo.id = idGrupo;

END //
DELIMITER ;
#CALL MaestroAlumnosBoleta(1,4);
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
drop procedure if exists MaestroTrabajosCQuiz;
DELIMITER //
CREATE PROCEDURE MaestroTrabajosCQuiz(IN usr INT)
BEGIN
   SELECT DISTINCT Actividad.nombreActividad, Grupo.nombreGrupo, Actividad.id
	FROM (((((Maestro
		INNER JOIN Grupo)
        INNER JOIN GrupoMaestro ON Grupo.id = GrupoMaestro.idGrupo and Maestro.id = GrupoMaestro.idMaestro)
        INNER JOIN Actividad)
		INNER JOIN GrupoActividad ON Grupo.id = GrupoActividad.idGrupo and Actividad.id = GrupoActividad.idActividad)
		INNER JOIN ActividadCQuiz ON Actividad.id = ActividadCQuiz.idActividad)
	WHERE  Maestro.id = usr
    ORDER BY Actividad.nombreActividad;
    
END //
DELIMITER ;
#CALL MaestroTrabajosCQuiz(1);
#SELECT * FROM Alumno;


drop procedure if exists MaestroTrabajosGuias;
DELIMITER //
CREATE PROCEDURE MaestroTrabajosGuias(IN usr INT)
BEGIN
  SELECT DISTINCT Actividad.nombreActividad, Grupo.nombreGrupo, Actividad.id
	FROM (((((Maestro
		INNER JOIN Grupo)
        INNER JOIN GrupoMaestro ON Grupo.id = GrupoMaestro.idGrupo and Maestro.id = GrupoMaestro.idMaestro)
        INNER JOIN Actividad)
		INNER JOIN GrupoActividad ON Grupo.id = GrupoActividad.idGrupo and Actividad.id = GrupoActividad.idActividad)
		INNER JOIN Guia ON Actividad.id = Guia.idActividad)
	WHERE  Maestro.id = usr
    ORDER BY Actividad.nombreActividad;
    
END //
DELIMITER ;
#CALL MaestroTrabajosGuias(1);
#SELECT * FROM Alumno;




drop procedure if exists MaestroAgregarCQuizConGrupo;
DELIMITER //
CREATE PROCEDURE MaestroAgregarCQuizConGrupo(IN mtro INT, IN nameGrupo Varchar(30), IN nameActivity Varchar(30))
BEGIN
	DECLARE newIdActivity INT;
	DECLARE newIdGrupo INT;
	INSERT INTO Actividad (nombreActividad) VALUES 
	(nameActivity);
    INSERT INTO Grupo (nombreGrupo) VALUES 
	(nameGrupo);
    SET newIdActivity = (SELECT Actividad.id FROM Actividad WHERE Actividad.nombreActividad = nameActivity);
    SET newIdGrupo = (SELECT Grupo.id FROM Grupo WHERE Grupo.nombreGrupo = nameGrupo);
	INSERT INTO GrupoActividad(idActividad, idGrupo) VALUES 
	(newIdActivity, newIdGrupo);
    INSERT INTO GrupoMaestro (idMaestro,idGrupo) VALUES
    (mtro,newIdGrupo);
    
END //
DELIMITER ;
#CALL MaestroAgregarCQuizConGrupo(1, "Grupo nuevo", "Actividad de Aaron");
#SELECT * FROM Alumno;



drop procedure if exists MaestroAgregarCQuizSinGrupo;
DELIMITER //
CREATE PROCEDURE MaestroAgregarCQuizSinGrupo(IN nameGrupo Varchar(30), IN nameActivity Varchar(30))
BEGIN
	DECLARE newIdActivity INT;
	DECLARE IdGrupo INT;
	INSERT INTO Actividad (nombreActividad) VALUES 
	(nameActivity);
    SET newIdActivity = (SELECT Actividad.id FROM Actividad WHERE Actividad.nombreActividad = nameActivity);
    SET IdGrupo = (SELECT Grupo.id FROM Grupo WHERE Grupo.nombreGrupo = nameGrupo);
	INSERT INTO GrupoActividad(idActividad, idGrupo) VALUES 
	(newIdActivity, IdGrupo);
    

END //
DELIMITER ;
#CALL MaestroAgregarCQuizSinGrupo("Grupo existente", "Guia nueva1");
#SELECT * FROM Actividad;







drop procedure if exists MaestroAgregarGuiaConGrupo;
DELIMITER //
CREATE PROCEDURE MaestroAgregarGuiaConGrupo(IN mtro INT, IN nameGrupo Varchar(30), IN nameActivity Varchar(30), IN nURL Varchar(255))
BEGIN
	DECLARE newIdActivity INT;
	DECLARE newIdGrupo INT;
	INSERT INTO Actividad (nombreActividad) VALUES 
	(nameActivity);
    INSERT INTO Grupo (nombreGrupo) VALUES 
	(nameGrupo);
    SET newIdActivity = (SELECT Actividad.id FROM Actividad WHERE Actividad.nombreActividad = nameActivity);
    SET newIdGrupo = (SELECT Grupo.id FROM Grupo WHERE Grupo.nombreGrupo = nameGrupo);
	INSERT INTO GrupoActividad(idActividad, idGrupo) VALUES 
	(newIdActivity, newIdGrupo);
    INSERT INTO GrupoMaestro (idMaestro,idGrupo) VALUES
    (mtro,newIdGrupo);
    INSERT INTO Guia (idActividad, url) VALUES
	(newIdActivity,nURL);

    SELECT * FROM Guia;
END //
DELIMITER ;
#CALL MaestroAgregarGuiaConGrupo(1, "Grupo nuevo", "Actividad de Aaron","url generica jeje");
#SELECT * FROM Alumno;



drop procedure if exists MaestroAgregarGuiaSinGrupo;
DELIMITER //
CREATE PROCEDURE MaestroAgregarGuiaSinGrupo(IN nameGrupo Varchar(30), IN nameActivity Varchar(30), IN nURL Varchar(255))
BEGIN
	DECLARE newIdActivity INT;
	DECLARE IdGrupo INT;
	INSERT INTO Actividad (nombreActividad) VALUES 
	(nameActivity);
  
    SET newIdActivity = (SELECT Actividad.id FROM Actividad WHERE Actividad.nombreActividad = nameActivity);
    SET IdGrupo = (SELECT Grupo.id FROM Grupo WHERE Grupo.nombreGrupo = nameGrupo);
	INSERT INTO GrupoActividad(idActividad, idGrupo) VALUES 
	(newIdActivity, IdGrupo);
   
    INSERT INTO Guia (idActividad, url) VALUES
	(newIdActivity,nURL);

    SELECT * FROM Guia;
END //
DELIMITER ;
#CALL MaestroAgregarGuiaSinGrupo( "Grupo nuevo", "Actividad de Aaron","url generica jeje");
#SELECT * FROM Alumno;






drop procedure if exists MaestroQuitarActividad;
DELIMITER //
CREATE PROCEDURE MaestroQuitarActividad(IN idActividad INT)
BEGIN
	DELETE FROM Actividad WHERE id = idActividad;
	DELETE FROM GrupoActividad WHERE GrupoActividad.idActividad = idActividad;
	DELETE FROM Calificacion WHERE Calificacion.idActividad = idActividad;
	DELETE FROM Guia WHERE Guia.idActividad = idActividad;
	DELETE CQuiz, ActividadCQuiz, Actividad FROM ((CQuiz
			INNER JOIN Actividad)
			INNER JOIN ActividadCQuiz ON CQuiz.id = ActividadCQuiz.idCQuiz and Actividad.id = ActividadCQuiz.idActividad
	) WHERE Actividad.id = idActividad;

END //
DELIMITER ;
#CALL MaestroQuitarActividad(9);
#SELECT * FROM Alumno;
#select * from Actividad;





drop procedure if exists MaestroAgregarPregunta;
DELIMITER //
CREATE PROCEDURE MaestroAgregarPregunta(IN nameActivity VARCHAR(30), IN pregunta VARCHAR(128), IN resCorrecta VARCHAR(128), IN res VARCHAR(128))
BEGIN
	DECLARE idActivity INT;
	DECLARE newIDCQuiz INT;

    SET idActivity = (SELECT Actividad.id FROM Actividad WHERE Actividad.nombreActividad = nameActivity);
	INSERT INTO CQuiz (pregunta, respuestaCorrecta, respuesta) VALUES
	(pregunta,resCorrecta, res);

	SET newIDCQuiz = (SELECT CQuiz.id FROM CQuiz WHERE CQuiz.pregunta = pregunta and  CQuiz.respuestaCorrecta = resCorrecta and  CQuiz.respuesta = res );

	INSERT INTO ActividadCQuiz (idCQuiz, idActividad) VALUES 
	(newIDCQuiz,idActivity);

END //
DELIMITER ;
#CALL MaestroAgregarPregunta("Actividad java","pregunta generica 1", "respuesta correcta 1", "respuesta no correcta 1");

#SELECT * FROM ActividadCQuiz;


drop procedure if exists MaestroVerCQuiz;
DELIMITER //
CREATE PROCEDURE MaestroVerCQuiz(IN nameActivity VARCHAR(30))
BEGIN
	DECLARE idActivity INT;
    SET idActivity = (SELECT Actividad.id FROM Actividad WHERE Actividad.nombreActividad = nameActivity);
	

    SELECT  CQuiz.pregunta as pregunta , CQuiz.respuesta
	FROM ((Actividad
		INNER JOIN ActividadCQuiz ON Actividad.id = ActividadCQuiz.idActividad)
        INNER JOIN CQuiz ON ActividadCQuiz.idCQuiz = CQuiz.id)
	WHERE  Actividad.id = idActivity
	UNION ALL
	SELECT  CQuiz.pregunta,CQuiz.respuestaCorrecta
	FROM ((Actividad
		INNER JOIN ActividadCQuiz ON Actividad.id = ActividadCQuiz.idActividad)
        INNER JOIN CQuiz ON ActividadCQuiz.idCQuiz = CQuiz.id)
	WHERE  Actividad.id = idActivity 
    ORDER BY pregunta;
    
    
END //
DELIMITER ;
#CALL MaestroVerCQuiz("Actividad java");



/*
drop procedure if exists MaestroAñadirPregunta;
DELIMITER //
CREATE PROCEDURE MaestroAñadirPregunta(IN usr INT)
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
*/
#CALL MaestroAñadirPregunta(1);
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