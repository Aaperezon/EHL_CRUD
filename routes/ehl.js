let express = require('express')
let router = express.Router()

let ehlController = require('../controllers/ehl.controller')

router.get('/inicioSesion/:user/:pass', ehlController.inicio_sesion)


router.get('/controlParentalCalificaciones/:id', ehlController.controlParentalCalificaciones)
router.get('/controlParentalAsistencias/:id', ehlController.controlParentalAsistencias)
router.get('/controlParentalNivelConocimiento/:id', ehlController.controlParentalNivelConocimiento)


router.get('/alumnoActividades/:id', ehlController.alumnoActividades)
router.get('/alumnoGrupos/:id', ehlController.alumnoGrupos)
router.get('/alumnoAjustes/:id/:confirm', ehlController.alumnoAjustes)


router.get('/maestroAlumnos/:id', ehlController.maestroAlumnos)
router.get('/maestroFotoAvatar/:id', ehlController.maestroFotoAvatar)
router.get('/actualizarMaestroFotoAvatar/:id/:path', ehlController.actualizarMaestroFotoAvatar)
router.get('/alumnosGruposMaestro/:id', ehlController.alumnosGruposMaestro)
router.get('/alumnosFaltas/:idAlumno/:idGrupo', ehlController.alumnosFaltas)
router.get('/maestroAlumnosBoleta/:idAlumno/:idGrupo', ehlController.maestroAlumnosBoleta)
router.get('/maestroAgregarAlumnoConGrupo/:id/:nName/:nUser/:nPass/:nGroup/:nUserCP/:nPassCP', ehlController.maestroAgregarAlumnoConGrupo)
router.get('/maestroAgregarAlumnoSinGrupo/:nName/:nUser/:nPass/:Group/:nUserCP/:nPassCP', ehlController.maestroAgregarAlumnoSinGrupo)
router.get('/maestroTrabajos/:id', ehlController.maestroTrabajos)


router.get('/maestroAjustes/:id/:confirm', ehlController.maestroAjustes)






router.get('/read_alumnos', ehlController.read_alumnos)
router.get('/read_alumno/:id', ehlController.read_alumno)
router.post('/create_alumno', ehlController.create_alumno)

router.put('/update_alumno/:id', ehlController.update_alumno)
router.delete('/delete_alumno/:id', ehlController.delete_alumno)

module.exports = router