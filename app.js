let express = require('express')
let path = require('path')
let bodyParser = require('body-parser')

let port = 3000
let app = express()

let index = require('./routes/index')
let ehl = require('./routes/ehl')

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))
app.use('/', index)
app.use('/api', ehl)
/*
function servidor(){
    console.log(`Servidor iniciado en puerto ${port}`)
}
app.listen(port, "")
*/
app.listen(port, () =>{
    console.log(`Servidor iniciado en puerto ${port}`)
})