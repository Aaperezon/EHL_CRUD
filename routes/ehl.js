let express = require('express')
let router = express.Router()

let ehlController = require('../controllers/ehl.controller')

router.get('/inicioSesion/:user/:pass', ehlController.inicio_sesion)


router.get('/read_alumnos', ehlController.read_alumnos)
router.get('/read_alumno/:id', ehlController.read_alumno)
router.post('/create_alumno', ehlController.create_alumno)

router.put('/update_alumno/:id', ehlController.update_alumno)
router.delete('/delete_alumno/:id', ehlController.delete_alumno)

module.exports = router