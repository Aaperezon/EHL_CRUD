let express = require('express')
let router = express.Router()

let ehlController = require('../controllers/ehl.controller')

router.get('/ehl', ehlController.read_alumnos)
router.get('/ehl/:id', ehlController.read_alumno)
router.post('/ehl', ehlController.create_alumno)

router.put('/ehl/:id', ehlController.update_alumno)
router.delete('/ehl/:id', ehlController.delete_alumno)

module.exports = router