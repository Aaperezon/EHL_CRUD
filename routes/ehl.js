let express = require('express')
let router = express.Router()

let ehlController = require('../controllers/ehl.controller')

router.get('/inicioSesion/:user/:pass', ehlController.inicio_sesion)


router.get('/controlParentalCalificaciones/:usr/:pass', ehlController.controlParentalCalificaciones)
router.get('/controlParentalAsistencias/:usr/:pass', ehlController.controlParentalAsistencias)
router.get('/controlParentalNivelConocimiento/:usr/:pass', ehlController.controlParentalNivelConocimiento)


router.get('/alumnoActividades/:usr/:pass', ehlController.alumnoActividades)
router.get('/alumnoGrupos/:usr/:pass', ehlController.alumnoGrupos)
router.get('/alumnoAjustes/:usr/:pass', ehlController.alumnoAjustes)




router.get('/read_alumnos', ehlController.read_alumnos)
router.get('/read_alumno/:id', ehlController.read_alumno)
router.post('/create_alumno', ehlController.create_alumno)

router.put('/update_alumno/:id', ehlController.update_alumno)
router.delete('/delete_alumno/:id', ehlController.delete_alumno)

module.exports = router