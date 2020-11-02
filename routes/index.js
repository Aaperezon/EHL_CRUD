let express = require('express')
let router = express.Router()
router.get('/',(request,response) => {
    response.send('Inicio')
} )

module.exports = router