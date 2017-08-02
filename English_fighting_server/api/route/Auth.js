'use strict'

module.exports = function(app){
    var  AuthController = require('../controllers/AuthController')
    app.route('/auth/token=:token').get(AuthController.auth)
    app.route('/fb/token=:token').get(AuthController.getData)
}