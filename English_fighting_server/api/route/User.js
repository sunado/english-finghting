
module.exports = function(app){
    var userController = require('../controllers/UserController')
    app.route('/user').get(userController.list_all_user)
        .put(userController.create_a_user)
    app.route('/user/:id').get(userController.get_a_user)
        .put(userController.update_user_info)
}