let mysql = require('mysql')
let config = require('../helpers/config')
let conexion = mysql.createConnection(config)

module.exports.inicio_sesion = (request,response) => {
    let sql = 'SELECT Alumno.perfil, Alumno.idAlumno FROM Alumno WHERE Alumno.usuario = ? and Alumno.contraseña =?'
    conexion.query(sql, [request.params.user, request.params.pass], (error, results, fields) =>{
        if(error){
            response.send(error)
        }
        else if(results == ''){
            let sql = 'SELECT Maestro.perfil, Maestro.idMaestro FROM Maestro WHERE Maestro.usuario =? and Maestro.contraseña = ?'
            conexion.query(sql, [request.params.user, request.params.pass], (error, results, fields) =>{
                if(error){
                    response.send(error)
                }
                else if(results == ''){
                    let sql = 'SELECT ControlParental.perfil, ControlParental.idControlParental FROM ControlParental WHERE ControlParental.usuario = ? and ControlParental.contraseña = ?'
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