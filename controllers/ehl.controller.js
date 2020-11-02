let mysql = require('mysql')
let config = require('../helpers/config')
let conexion = mysql.createConnection(config)

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