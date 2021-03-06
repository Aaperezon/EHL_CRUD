let mysql = require('mysql')
let config = require('../helpers/config')
let conexion = mysql.createConnection(config)

module.exports.inicio_sesion = (request,response) => {
    let sql = 'SELECT Alumno.perfil, Alumno.id FROM Alumno WHERE Alumno.usuario = ? and Alumno.contraseña =?'
    conexion.query(sql, [request.params.user, request.params.pass], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        else if(results == ''){
            let sql = 'SELECT Maestro.perfil, Maestro.id FROM Maestro WHERE Maestro.usuario =? and Maestro.contraseña = ?'
            conexion.query(sql, [request.params.user, request.params.pass], (error, results, fields) =>{
                if(error){
                    response.send(error)
                }
                else if(results == ''){
                    let sql = 'SELECT ControlParental.perfil, ControlParental.id FROM ControlParental WHERE ControlParental.usuario = ? and ControlParental.contraseña = ?'
                    conexion.query(sql, [request.params.user, request.params.pass], (error, results, fields) =>{
                        if(error){
                            response.send(error)
                        }else{
                            response.json(results)
                        }
                    })
                }else{
                    response.json(results)
                }
            })
        }
        else{
            response.json(results)
        }
    })
    
} 



module.exports.controlParentalCalificaciones = (request,response) => {
    let sql = 'Call ControlParentalCalificaciones(?)'
    conexion.query(sql, [request.params.id], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
} 
module.exports.controlParentalAsistencias = (request,response) => {
    let sql = 'Call ControlParentalAsistencias(?)'
    conexion.query(sql, [request.params.id], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
} 
module.exports.controlParentalNivelConocimiento = (request,response) => {
    let sql = 'Call ControlParentalNivelConocimiento(?)'
    conexion.query(sql, [request.params.id], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
} 


module.exports.alumnoActividadesCQuiz = (request,response) => {
    let sql = 'Call AlumnoActividadesCQuiz(?)'
    conexion.query(sql, [request.params.id], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
} 
module.exports.alumnoActividadesGuias = (request,response) => {
    let sql = 'Call AlumnoActividadesGuias(?)'
    conexion.query(sql, [request.params.id], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
} 

module.exports.alumnoGrupos = (request,response) => {
    let sql = 'Call AlumnoGrupos(?)'
    conexion.query(sql, [request.params.id], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
} 

module.exports.alumnoAjustes = (request,response) => {
    let sql = 'Call AlumnoAjustes(?,?)'
    conexion.query(sql, [request.params.id, request.params.confirm], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results)
    })
} 
module.exports.alumnoActividadResolver = (request,response) => {
    let sql = 'Call AlumnoActividadResolver(?)'
    conexion.query(sql, [request.params.nameActivity.replace(/\+/g," ")], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
} 










module.exports.maestroAlumnos = (request,response) => {
    let sql = 'Call MaestroAlumnos(?)'
    conexion.query(sql, [request.params.id], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}

module.exports.maestroFotoAvatar = (request,response) => {
    let sql = 'Call FotoAvatar(?)'
    conexion.query(sql, [request.params.id], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}

module.exports.actualizarMaestroFotoAvatar = (request,response) => {
    console.log(request.params.path)
    //request.params.nName.replace(/\+/g," ")
    let sql = 'Call ActualizaFotoAvatar(?,?)'
    conexion.query(sql, [request.params.id, request.params.path], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}
module.exports.alumnosGruposMaestro = (request,response) => {
    let sql = 'Call AlumnosGruposMaestro(?)'
    conexion.query(sql, [request.params.id], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}
module.exports.alumnosFaltas = (request,response) => {
    let sql = 'Call AlumnosFaltas(?,?)'
    conexion.query(sql, [request.params.idAlumno, request.params.idGrupo], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}
module.exports.maestroAlumnosBoleta = (request,response) => {
    let sql = 'Call MaestroAlumnosBoleta(?,?)'
    conexion.query(sql, [request.params.idAlumno, request.params.idGrupo], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}

module.exports.maestroAgregarAlumnoConGrupo = (request,response) => {
    let sql = 'Call MaestroAgregarAlumnoConGrupo(?,?,?,?,?,?,?)'
    conexion.query(sql, [request.params.id,request.params.nName.replace(/\+/g," "),request.params.nUser,request.params.nPass,request.params.nGroup.replace(/\+/g," "),request.params.nUserCP,request.params.nPassCP], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}
module.exports.maestroAgregarAlumnoSinGrupo = (request,response) => {
    let sql = 'Call MaestroAgregarAlumnoSinGrupo(?,?,?,?,?,?)'
    conexion.query(sql, [request.params.nName.replace(/\+/g," "),request.params.nUser,request.params.nPass,request.params.Group.replace(/\+/g," "),request.params.nUserCP,request.params.nPassCP], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}


module.exports.maestroTrabajosCQuiz = (request,response) => {
    let sql = 'Call MaestroTrabajosCQuiz(?)'
    conexion.query(sql, [request.params.id], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}
module.exports.maestroTrabajosGuias = (request,response) => {
    let sql = 'Call MaestroTrabajosGuias(?)'
    conexion.query(sql, [request.params.id], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}

module.exports.maestroAgregarCQuizConGrupo = (request,response) => {
    let sql = 'Call MaestroAgregarCQuizConGrupo(?,?,?)'
    conexion.query(sql, [request.params.id,request.params.nGrupo.replace(/\+/g," "), request.params.nActivity.replace(/\+/g," ")], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}
module.exports.maestroAgregarCQuizSinGrupo = (request,response) => {
    let sql = 'Call MaestroAgregarCQuizSinGrupo(?,?)'
    conexion.query(sql, [request.params.nGrupo.replace(/\+/g," "), request.params.nActivity.replace(/\+/g," ")], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}

module.exports.maestroAgregarGuiaConGrupo = (request,response) => {
    let sql = 'Call MaestroAgregarGuiaConGrupo(?,?,?,?)'
    conexion.query(sql, [request.params.id,request.params.nGrupo.replace(/\+/g," "), request.params.nActivity.replace(/\+/g," "), request.params.nURL.replace(/\+/g," ")], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}

module.exports.maestroAgregarGuiaSinGrupo = (request,response) => {
    let sql = 'Call MaestroAgregarGuiaSinGrupo(?,?,?)'
    conexion.query(sql, [request.params.nGrupo.replace(/\+/g," "), request.params.nActivity.replace(/\+/g," "), request.params.nURL.replace(/\+/g," ")], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}


module.exports.maestroQuitarActividads = (request,response) => {
    let sql = 'Call MaestroQuitarActividad(?)'
    conexion.query(sql, [request.params.idActividad], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}


module.exports.maestroVerCQuiz = (request,response) => {
    let sql = 'Call MaestroVerCQuiz(?)'
    conexion.query(sql, [request.params.nameActivity.replace(/\+/g," ")], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}

module.exports.maestroAgregarPregunta = (request,response) => {
    let sql = 'Call MaestroAgregarPregunta(?,?,?,?)'
    conexion.query(sql, [request.params.nameActivity.replace(/\+/g," "),request.params.nPregunta.replace(/\+/g," "),request.params.nRessCorrecta.replace(/\+/g," "),request.params.nRes.replace(/\+/g," ")], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
}



















module.exports.maestroAjustes = (request,response) => {
    let sql = 'Call MaestroAjustes(?,?)'
    conexion.query(sql, [request.params.id, request.params.confirm], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results)
    })
} 



module.exports.read_alumnos = (request,response) => {
    //response.send('Car list')
    let sql = 'SELECT * FROM Alumno'
    conexion.query(sql, (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results)
    })
} 

module.exports.read_alumno = (request,response) => {
    //response.send('Car list')
    let sql = 'SELECT * FROM Alumno WHERE idAlumno = ?'
    conexion.query(sql, [request.params.id], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results[0])
    })
} 


module.exports.create_alumno = (request,response) => {
    let car = request.body
    let sql = 'INSERT INTO Alumno SET ?'
    conexion.query(sql, [car], (error,results,fields) =>{
        if(error){
            response.send(error)
        }
        response.json(results)
    })
}


module.exports.update_alumno = (request,response) => {
    let car = request.body
    let sql = 'UPDATE Alumno SET ? WHERE idAlumno = ?'  //Se va a sustituir por: model = 'Tsuru', brand = 'Nissan'
    console.log(request.params, car)
    conexion.query(sql,[car, request.params.id], (error,results,fields) =>{
        if(error){
            //Esto solo para depuracion
            response.send(error)
        }
        response.json(results)
    })
}

module.exports.delete_alumno = (request,response) => {
    let sql = 'DELETE FROM Alumno WHERE idAlumno = ?'
    conexion.query(sql, [request.params.id],(error,results,fields) =>{
        if(error){
            //Esto solo para depuracion
            response.send(error)
        }
        response.json(results)
    })
} 