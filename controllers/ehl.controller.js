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


module.exports.alumnoActividades = (request,response) => {
    let sql = 'Call AlumnoActividades(?)'
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









module.exports.maestroAlumnos = (request,response) => {
    let sql = 'Call MaestroAlumnos(?)'
    conexion.query(sql, [request.params.id], (error, results, fields) =>{
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


module.exports.maestroTrabajos = (request,response) => {
    let sql = 'Call MaestroTrabajos(?)'
    conexion.query(sql, [request.params.id], (error, results, fields) =>{
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