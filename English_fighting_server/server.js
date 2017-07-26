

var express = require('express'),
app = express(),
port = process.env.PORT || 3000,
mongoose = require('mongoose'),
ChooseQuestion = require('./api/models/ChooseQuestion'),
User = require('./api/models/User'),
bodyParser = require('body-parser')

mongoose.Promise =global.Promise
mongoose.connect('mongodb://localhost/anh_viet',{ useMongoClient: true })


app.use(bodyParser.urlencoded({ extended: true}))
app.use(bodyParser.json())

var routes = require('./route')
routes(app)


app.listen(port)

console.log("server start on "+ port)
